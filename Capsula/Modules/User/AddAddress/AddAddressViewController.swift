//
//  AddAddressViewController.swift
//  Capsula
//
//  Created by SherifShokry on 1/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import KVNProgress
import Moya
import Intercom

class AddAddressViewController : UIViewController {
    
    var fromDeliveryMan = false
    var openHomeScreen = false
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    @IBOutlet weak var addressField : CapsulaInputFeild!
    @IBOutlet weak var addAddressBtn : UIButton!
    private let provider = MoyaProvider<UserDataSource>()
    let marker = GMSMarker()
    var addressString = ""
    var longitude = 0.0
    var latitude = 0.0
    var onAddAddressCompleted : ((String,Double,Double) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressField.titleLabel.text  =  Strings.shared.currentLocation
        addressField.type = .action
        addressField.setTextFeildSpecs()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 70
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    
    @IBAction func addAddress(_ sender : Any){
        if addressField.getText() != "" {
            if fromDeliveryMan {
                
                if onAddAddressCompleted != nil {
                    self.dismiss(animated: true) {
                        self.onAddAddressCompleted!(self.addressField.getText() , self.latitude, self.longitude)
                    }
                }
                
            }else{
                
                KVNProgress.show()
                
                provider.request(.addAddress(addressString, latitude, longitude)) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        KVNProgress.dismiss()
                        do {
                            let userResponse = try response.map(BaseResponse<UserResponse>.self).data ?? UserResponse()
                            var updatedUser = Utils.loadUser() ?? UserResponse()
                            updatedUser.user = userResponse.user ?? User()
                            UserDefaults.standard.set(false, forKey: "isDelivery")
                            Utils.saveUser(user: updatedUser)
                            
                            if (self.openHomeScreen){
                                Utils.openHomeScreen()
                            }else{
                                self.dismiss(animated: true) {
                                    self.onAddAddressCompleted!(self.addressField.getText() , self.latitude, self.longitude)
                                }
                            }
                            
                            
                        } catch(let catchError) {
                            self.showMessage(catchError.localizedDescription)
                        }
                    case .failure(let error):
                        do{
                            if let body = try error.response?.mapJSON(){
                                let errorData = (body as! [String:Any])
                                KVNProgress.dismiss()
                                self.showMessage((errorData["errors"] as? String) ?? "")
                            }
                        }catch{
                            KVNProgress.dismiss()
                            self.showMessage(error.localizedDescription)
                        }
                    }
                }
            }
            
            
        }
        
        
        
    }
    
}

extension AddAddressViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.getAddressFromLatLon(pdblLatitude: String(location.coordinate.latitude) , withLongitude: String(location.coordinate.longitude))
        mapView.delegate = self
        marker.map = mapView
        mapView.selectedMarker = marker
        locationManager.stopUpdatingLocation()
    }
    
}

extension AddAddressViewController: GMSMapViewDelegate{
    
    //    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    //    {
    //
    //        return true
    //    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.getAddressFromLatLon(pdblLatitude: String(coordinate.latitude), withLongitude: String(coordinate.longitude))
        marker.map = mapView
        mapView.selectedMarker = marker
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks as? [CLPlacemark] ?? [CLPlacemark]()
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    self.addressString = addressString
                    self.latitude = lat
                    self.longitude = lon
                    self.marker.title = addressString
                    self.addressField.field.text = addressString
                }
        })
        
    }
    
}

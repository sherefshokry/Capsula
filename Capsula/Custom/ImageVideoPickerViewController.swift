//
//  ImageVideoPickerViewController.swift
//  ADSC
//
//  Created by Karim abdelhameed mohamed on 9/4/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ImageVideoPickerViewController: UIViewController{
    
    let imagepicker = UIImagePickerController()
    var imageString = ""
    var youTubeLink = ""
    var videoURL : URL?
    var completion : ((UIImage , URL)->())!
    var youtubeCompletion : ((String , String)->())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
    }
    
    func openUploadImageBottomSheet(withTitle string : String)
    {
        
        let picker = CustomPickerView()
//        var options = [Country]()
//        var country1 = Country()
//        var country2 = Country()
//        var country3 = Country()
//        country1.name = "Photo Library".localize()
//        country1.myImage = #imageLiteral(resourceName: "ic_gallery.png")
//        country2.name = "Take Photo".localize()
//        country2.myImage = #imageLiteral(resourceName: "ic_camera.png")
//        country3.name = "Youtube link".localize()
//        country3.myImage = #imageLiteral(resourceName: "ic_youtube.png")
//        options.append(country1)
//        options.append(country2)
//        options.append(country3)
       // picker.fromFlag = true
        picker.selectedIndex = -1
        picker.titleText = string
        picker.subTitleText = ""
        //picker.countries = options
        picker.doneSelectingAction = { index in
            switch index {
                case 0:
                    self.openGallary()
                    break
                case 1:
                    self.checkCamerAccess()
                    break
                case 2:
                   // self.addYoutubeLink()
                    break
            default:
                break
            }
        }
        picker.show()
    }
    
    func openGallary()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
            self.imagepicker.allowsEditing = false
            self.imagepicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagepicker.mediaTypes = [kUTTypeImage as String , kUTTypeMovie as String]
            self.present(self.imagepicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Can't find photo Library".localize(), message: "This device doesn't have photo Library".localize(), preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK".localize(), style:.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkCamerAccess()
    {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                    self.imagepicker.allowsEditing = false
                    self.imagepicker.sourceType = UIImagePickerController.SourceType.camera
                    self.imagepicker.mediaTypes = [kUTTypeImage as String , kUTTypeMovie as String]
                    self.imagepicker.videoQuality = .typeMedium
                    self.present(self.imagepicker, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Can't find camera".localize(), message: "This device doesn't have camera".localize(), preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok".localize(), style:.default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Camera".localize(), message: "Camera access is necessary to capture your photo".localize(), preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Open Settings".localize(), style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel".localize(), style: .cancel, handler: { (action) in
                    
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    
}
extension ImageVideoPickerViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            self.dismiss(animated: true) {
                if self.completion != nil{
                    self.videoURL = videoURL
                    self.completion( #imageLiteral(resourceName: "ic_video_holder.png"), videoURL)
                }
            }
        }
        else{
            guard let selectedImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                return
            }
            let image = UIImage.compress(selectedImage)
            imageString = getImageString(image: image)
            self.dismiss(animated: true) {
                if self.completion != nil{
                    self.completion(image , URL.init(string: "image")!)
                }
            }
        }
    }
    
    func getImageString(image : UIImage)->String{
        if image != UIImage(){
            let imageData : NSData = NSData(data: image.jpegData(compressionQuality: 0.5)!)
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
        }else{
            return  ""
        }
    }
}


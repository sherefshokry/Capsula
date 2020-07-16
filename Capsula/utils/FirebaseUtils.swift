//
//  FirebaseUtils.swift
//  Mansour
//
//  Created by SherifShokry on 12/23/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import Foundation
import  UIKit
import  Firebase
import  FirebaseMessaging

class FirebaseUtils {
    

    public static func subscribeToAllTopic(){
        
        if Utils.isNotificationOn() {
            
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                Messaging.messaging().subscribe(toTopic: "all_ar_ios")
                Messaging.messaging().unsubscribe(fromTopic: "all_ios")
            }else{
                Messaging.messaging().subscribe(toTopic: "all_ios")
                Messaging.messaging().unsubscribe(fromTopic: "all_ar_ios")
            }
            
        }
        
    }
    public static func unSubscribeFromAllTopics(){
        if !Utils.isNotificationOn(){
            Messaging.messaging().unsubscribe(fromTopic: "all_ar_ios")
            Messaging.messaging().unsubscribe(fromTopic: "all_ios")
        }
    }
    
    
}




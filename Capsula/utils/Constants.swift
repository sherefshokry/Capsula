//
//  Constants.swift
//  Loreal Medical
//
//  Created by Nora on 3/18/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit
class Constants {
    struct NotificationTopics {
        static var general = "all_ios"
    }
    struct User {
        static var USER = "user"
    }
    
    struct KEYS {
         static var googleSignInKey = "757084905257-9too7a0ebpgni85megj1khobbat2uvr0"
         static var facebookSignInKey = ""
         static var twitterConsumerKey = "apLhnsYRogSs0d43hfdkQcW9a"
        static var twitterConsumerSecretKey = "axOppPYZhhp85PJsySsYwY8iohRzsjWjD0kHmy0qYbusoWuZ2y"
        
    }
    
       static var BASE_URL = "https://Capsula.cc/api"
    //"http://capsulasa-001-site2.itempurl.com/api"
    //"https://Capsula.cc/api"
    //
    
       static var per_page = 40
       static var FACEBOOK_NOTIFICATION = "FACEBOOK_NOTIFICATION"
       static var TWITTER_NOTIFICATION = "TWITTER_NOTIFICATION"
       static var GOOGLE_NOTIFICATION = "GOOGLE_NOTIFICATION"
    
       static var CART_UPDATE_NOTIFICATION = "CART_UPDATE_NOTIFICATION"
       static var RELOAD_DELIVERY_MAN_ORDERS_LIST = "RELOAD_DELIVERY_MAN_ORDERS_LIST"
       static var RELOAD_ORDERS_LIST = "RELOAD_DELIVERY_LIST"
       static var REFRESH_USER_DATA =  "REFRESH_USER_DATA"
     static var REFRESH_DELIVERY_DATA =  "REFRESH_DELIVERY_DATA"
}

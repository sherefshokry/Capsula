//
//  CachingModel.swift
//  ESMA
//
//  Created by Nora on 10/14/18.
//  Copyright © 2018 BlueCrunch. All rights reserved.
//
import Foundation

class CachingModel{
    
    public struct CachingKeys  {
        static var FIRST_TIME = "first_time"
        static var NOTIFICATION_STATUS = "notification_status"
    }
    
    
    static func getCachedData<T : Codable>(CACHE_KEY : String) -> (T)?
    {
        if let value = UserDefaults.standard.value(forKey: CACHE_KEY) as? Data{
            if let data = try? JSONDecoder().decode(T.self , from: value){
                return data
            }
        }
        return nil
    }
    
    static func setCached<T : Codable>(item : T , key : String){
        if let value = try? JSONEncoder().encode(item) {
            UserDefaults.standard.set(value, forKey: key)
        } else {
            UserDefaults.standard.set(nil, forKey: key)
        }
    }
}

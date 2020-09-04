//
//  FAQResponse.swift
//  Capsula
//
//  Created by SherifShokry on 8/31/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
 
import Foundation

struct  FAQResponse : Codable {
    var  faqsList : [FAQ]?
    
    
   enum CodingKeys: String, CodingKey {
      case  faqsList  = "list"
    }
    
    init(){
     faqsList  = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { faqsList  = try container.decodeIfPresent(.faqsList) ?? [] }
        catch { faqsList  = [] }
    }
}

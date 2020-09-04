//
//  FAQ.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct FAQ : Codable {

    
    let  question: String?
    let  answer: String?
    var  isExpanded = false
    
    enum CodingKeys: String, CodingKey {
        case question, answer
    }
    
    init(){
  
        question = ""
        answer = ""
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { question = try container.decodeIfPresent(. question) ?? "" }
        catch {  question = "" } 
        do {   answer = try container.decodeIfPresent(.answer) ?? ""}
        catch { answer = "" }
    }
}

//
//  Brand.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation

struct Brand : Codable {
    
    let  brandId: Int?
    let  brandName : String?
    let  imageLink : String?
    
    
    enum CodingKeys: String, CodingKey {
        case brandId, brandName , imageLink
    }
    
    init(){
        brandId = -1
        brandName = ""
        imageLink = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { brandId = try container.decodeIfPresent(.brandId) ?? -1 }
        catch { brandId = -1 }
        do {   brandName = try container.decodeIfPresent(.brandName) ?? ""}
        catch { brandName = "" }
        do {   imageLink = try container.decodeIfPresent(.imageLink) ?? ""}
        catch { imageLink = "" }
    }
}


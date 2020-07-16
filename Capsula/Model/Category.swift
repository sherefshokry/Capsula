//
//  Category.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation

struct Category : Codable {
    
    let categoryId: Int?
    let categoryName : String?
    let imageLink : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryId, categoryName , imageLink
    }
    
    init(){
        categoryId = -1
        categoryName = ""
        imageLink = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { categoryId = try container.decodeIfPresent(.categoryId) ?? -1 }
        catch { categoryId = -1 }
        do {   categoryName = try container.decodeIfPresent(.categoryName) ?? ""}
        catch { categoryName = "" }
        do {   imageLink = try container.decodeIfPresent(.imageLink) ?? ""}
        catch { imageLink = "" }
    }
}

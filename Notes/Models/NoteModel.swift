//
//  NoteModel.swift
//  Notes
//
//  Created by nimik on 05/08/2018.
//  Copyright © 2018 nimik. All rights reserved.
//

import Foundation

struct NoteModel : Codable {
    let id : Int
    let title : String
    
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case title = "title"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = (try values.decodeIfPresent(Int.self, forKey: .id))!
//        title = (try values.decodeIfPresent(String.self, forKey: .title))!
//    }
    
}


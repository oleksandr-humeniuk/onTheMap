//
//  Username.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import Foundation

struct User : Decodable{
    let lastName:String
    let firstName:String
    var fullName:String {
        return "\(firstName) \(lastName)"
    }
  
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}

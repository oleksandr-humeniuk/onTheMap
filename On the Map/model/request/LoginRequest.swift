//
//  LoginRequest.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

struct LoginRequest : Encodable {
    let udacity: Udacity?
    
    enum CodingKeys: String, CodingKey {
        case udacity = "udacity"
    }
}

struct Udacity : Encodable{
    let username: String
    let password: String
}

//
//  LoginResponse.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

class LoginResponse: Decodable {
    let account: Account
    let session: Session
}

class Account: Decodable {
    let registered: Bool
    let key: String
}

class Session: Decodable {
    let id:String
    let expiration:String
}

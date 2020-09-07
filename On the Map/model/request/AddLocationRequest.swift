//
//  CreatePinRequest.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import Foundation

struct AddLocationRequest: Encodable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}

//
//  StudentInformation.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

struct StudentInformation: Decodable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String
    
    var fullName:String{
        return "\(firstName) \(lastName)"
    }
}

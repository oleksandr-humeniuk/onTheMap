//
//  UdacityApi.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

enum Endoints {
    private static let base = "https://onthemap-api.udacity.com/v1/"
    
    case login
    
    private var stringUrl: String {
        switch self {
        case .login: return Endoints.base + "session"
        }
    }
    
    var url:URL {
        URL(string: stringUrl)!
    }
}

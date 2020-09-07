//
//  UdacityApi.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

enum Endoints {
    private static let base = "https://onthemap-api.udacity.com/v1/"
    
    case login,logout,studentInformation(last: Int), userDetails(userId:String), createPin
    
    private var stringUrl: String {
        switch self {
        case .login: return Endoints.base + "session"
        case .logout: return Endoints.base + "session"
        case let .studentInformation(last): return  Endoints.base + "StudentLocation?limit=\(last)" + "&order=-updatedAt"
        case let .userDetails(userId): return Endoints.base + "users/\(userId)"
        case .createPin: return Endoints.base + "StudentLocation"
        }
    }
    
    var url:URL {
        URL(string: stringUrl)!
    }
}

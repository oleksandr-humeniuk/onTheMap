//
//  FindLocationInteractor.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import Foundation
import CoreLocation

fileprivate let LOCATION_CANNOT_BE_EMPTY_MESSAGE = "Location cannot be empty"
fileprivate let LOCATION_NOT_FOUND_MESSAGE = "Location not found"
class FindLocationInteractor {
    class func find(location: String, completion: @escaping (CLLocation?,Error?)->Void){
        guard !location.isEmpty else {
            completion(nil,ErrorResponse(status: 0, error: LOCATION_CANNOT_BE_EMPTY_MESSAGE))
            return
        }
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            guard let foundLocation = placemarks?.first?.location else {
                completion(nil,ErrorResponse(status: 0, error: LOCATION_NOT_FOUND_MESSAGE))
                return
            }
            completion(foundLocation,nil)
        }
    }
}

//
//  PostLocation.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import Foundation

class AddLocationInteractor {
    class func add(user:User,
                    mapName:String,
                    mediaUrl:String,
                    long:Double,
                    lat:Double,
                    completion: @escaping (AddLocationResponse?,Error?)->Void){
        NetworkClient.taskForPOSTRequest(url: Endoints.createPin.url,
                                         requestBody: AddLocationRequest(uniqueKey: UUID().uuidString,
                                                                       firstName: user.firstName,
                                                                       lastName: user.lastName,
                                                                       mapString: mapName,
                                                                       mediaURL: mediaUrl,
                                                                       latitude: lat,
                                                                       longitude: long),
                                         responseType: AddLocationResponse.self,
                                         completion: completion)
    }
}

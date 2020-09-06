//
//  LogoutInteractor.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation
class LogoutInteractor {
    
    class func logout(completion: @escaping (LogoutResponse?,Error?) -> Void ){
        NetworkClient.taskForDELETERequest(url: Endoints.logout.url,
                                                                  requestBody: LogoutRequest(),
                                                                  responseType: LogoutResponse.self,
                                                                  completion: completion )
    }
}

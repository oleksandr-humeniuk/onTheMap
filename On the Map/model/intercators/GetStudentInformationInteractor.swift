//
//  GetStudentInformationInteractor.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation
class GetStudentInformationInteractor {
    
    class func get(completion: @escaping ([StudentInformation]?,Error?) -> Void) {
        NetworkClient.taskForGETRequest(url: Endoints.studentInformation(last: 100).url,
                                        responseType: GetStudentInformationResponse.self,
                                        completion: {response,error in
                                            completion(response?.results,error)
                                        })
    }
}

//
//  LoginInteractor.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

fileprivate let INVALID_EMAIL_ERROR = "Invalid email adress"
fileprivate let INVALID_PASSWORD_ERROR = "Password could not be empty"
fileprivate let EMAIL_PATTERN = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

class LoginInteractor {
    
    class func login(username:String,
                     password:String,
                     completion: @escaping (User?, Error?)->Void) {
        
        guard validateEmail(username) else {
            completion(nil,ErrorResponse(status: 0, error: INVALID_EMAIL_ERROR))
            return
        }
        guard !password.isEmpty else {
            completion(nil,ErrorResponse(status: 0, error: INVALID_PASSWORD_ERROR))
            return
        }
        
        NetworkClient.taskForPOSTRequest(url: Endoints.login.url,
                                         requestBody: LoginRequest(udacity: Udacity(username:username,password:password)),
                                         responseType: LoginResponse.self,
                                         completion: {loginResponse,error in
                                            guard let loginResponse = loginResponse else{
                                                completion(nil,error)
                                                return
                                            }
                                            fetchUser(id: loginResponse.account.key, completion: completion)
                                         })
    }
    private class func fetchUser(id:String,completion: @escaping(User?,Error?)->Void) {
        NetworkClient.taskForGETRequest(url: Endoints.userDetails(userId: id).url,
                                        responseType: User.self,
                                        completion: completion)
    }
    private class func validateEmail(_ enteredEmail: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", EMAIL_PATTERN)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
}

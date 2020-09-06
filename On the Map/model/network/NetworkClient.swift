//
//  NetworkClient.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

class NetworkClient {
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL,
                                                          responseType: ResponseType.Type,
                                                          completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        task.resume()
        
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL,
                                                                                   requestBody: RequestType,
                                                                                   responseType: ResponseType.Type,
                                                                                   completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let jsonBody = try! JSONEncoder().encode(requestBody)
        request.httpBody = jsonBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        task.resume()
        return task
    }
    
    class func taskForDELETERequest<RequestType: Encodable, ResponseType: Decodable>(url: URL,
                                                                                     requestBody: RequestType?,
                                                                                     responseType: ResponseType.Type,
                                                                                     completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask{
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = try? JSONEncoder().encode(requestBody)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        task.resume()
        return task
    }
    
    private class func handleResponse<ResponseType:Decodable>(data:Data? ,
                                                              error :Error?,
                                                              completion: @escaping (ResponseType?, Error?) -> Void){
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil, error)
            }
            return
        }
        
        //      strangest thing I have ever seen
        let newData:Data
        if String(data: data,encoding: .utf8)?.starts(with: ")") == true {
            newData = data.subdata(in: 5..<data.count)
        }else{
            newData = data
        }
        
        let decoder = JSONDecoder()
        DispatchQueue.main.async {
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                completion(responseObject, nil)
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData) as Error
                    completion(nil, errorResponse)
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
}

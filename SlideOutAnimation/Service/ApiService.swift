//
//  ApiService.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import Foundation

enum BackEndErrors: Error {
    case urlError(reason: String)
    case serializationError(reaseon: String)
}

struct ApiService {

static func apiServiceRequest<T> (requestUrl: URLRequest?, resultStruct: T.Type, completion: @escaping ((Any?, Error?) -> ())) where T : Decodable {
    
    guard let apiRequestUrl = requestUrl, let _ = apiRequestUrl.url else {
        completion(nil, BackEndErrors.urlError(reason: "Url is wrong"))
        return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: apiRequestUrl){ (data, response, error) in
        
        guard let responseData = data, let _ = response else {
            completion(nil, BackEndErrors.urlError(reason: "Data Error"))
            return
        }
        let jsonDecoder = JSONDecoder()
        do {
        let decodedJson = try jsonDecoder.decode(resultStruct, from: responseData)
            DispatchQueue.main.async {
                completion(decodedJson, nil)
            }
        }
        catch {
            completion(nil, error)
        }
    }
    task.resume()
 }
}

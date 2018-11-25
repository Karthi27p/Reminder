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

static func apiServiceRequest<T> (requestUrl: NSURLRequest, resultStruct: T.type completion: @escaping ((Any?, Error?) -> ())) where T : Decodable {
    
    guard let apiRequestUrl = requestUrl, let _ = apiRequestUrl.url else {
        completion(nil, urlError(reason: "Url is wrong"))
        return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(
}

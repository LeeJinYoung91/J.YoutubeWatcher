//
//  NetworkRequest.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import Alamofire

typealias HttpsSuccess = (_ responseObject: [String:Any?]) -> Void
typealias HttpsFailure = () -> Void
typealias HttpsParam = [String:Any]

class NetworkRequest {
    func sendRequest(requestURL:String, httpMethod:HTTPMethod, param:HttpsParam, authKey:String, responseListener:HttpsSuccess?, errorListener:HttpsFailure?) -> DataRequest {
        let dataRequest = Session.default.request(requestURL, method: httpMethod, parameters: param, encoding: URLEncoding.default, headers: nil)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: { response in
                if response.error == nil {
                    if let responseDic = response.value as? [String:Any] {
                        responseListener?(responseDic)
                    } else {
                        errorListener?()
                    }
                } else {
                    errorListener?()
                }
            })
        dataRequest.resume()
        return dataRequest
    }
    
    func downloadImage(_ url: String) {
        guard let requestURL = URL(string: url) else { return }

    }
}

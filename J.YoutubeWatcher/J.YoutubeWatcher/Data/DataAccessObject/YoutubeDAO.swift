//
//  YoutubeDAO.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import Alamofire

class YoutubeDAO: BaseDAO {
    private final let youtubeAuthKey = Bundle.main.infoDictionary?["YoutubeAuthKey"] as! String
    private final let videoSnippet = "videos"
    private final let search = "search"
    private final let channel = "channels"
    
    func getPopularVideoSnippets(pageToken: String?, responseListener: HttpsSuccess?, errorListener: HttpsFailure?) -> DataRequest {
        var param = ["chart":"mostPopular", "part":"snippet", "key":youtubeAuthKey]
        if let token = pageToken {
            param["pageToken"] = token
        }
        return NetworkRequest().sendRequest(requestURL: baseURL+videoSnippet, httpMethod: HTTPMethod.get, param: param, authKey: youtubeAuthKey, responseListener: responseListener, errorListener: errorListener)
    }
    
    func getSearchVideoSnippets(keyword: String, pageToken: String? ,responseListener: HttpsSuccess?, errorListener: HttpsFailure?) -> DataRequest {
        var param = ["part":"snippet", "q":keyword, "key":youtubeAuthKey]
        if let token = pageToken {
            param["pageToken"] = token
        }
        return NetworkRequest().sendRequest(requestURL: baseURL+search, httpMethod: HTTPMethod.get, param: param, authKey: youtubeAuthKey, responseListener: responseListener, errorListener: errorListener)
    }
    
    func getChannelInfomation(_ id: String, responseListener: HttpsSuccess?, errorListener: HttpsFailure?) -> DataRequest {
        let param = ["part":"snippet", "id":id]
        return NetworkRequest().sendRequest(requestURL: baseURL+channel, httpMethod: HTTPMethod.get, param: param, authKey: youtubeAuthKey, responseListener: responseListener, errorListener: errorListener)
    }
}

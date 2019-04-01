//
//  YoutubeVideoFetcher.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class YoutubeVideoFetcher: ContentFetcher {
    private var searchKeyword: String = ""
    private var onLoadRequest: DataRequest?
    
    var SearchKeyWord:String = "" {
        willSet {
            searchKeyword = newValue
        }
    }
    
    override func loadModel() {
        guard !onLoading && !loadedAllDatas else {
            return
        }
        
        onLoadRequest?.cancel()
        onLoading = true
        if searchKeyword.isEmpty {
            onLoadRequest = YoutubeDAO().getPopularVideoSnippets(pageToken: nextPageToken, responseListener: { response in
                self.nextPageToken = response["nextPageToken"] as? String
                self.loadedAllDatas = !(self.nextPageToken != nil)
                if let arrayOfData = response["items"] as? [Any] {
                    for dat in arrayOfData {
                        if let jsonData = dat as? [String:Any?] {
                            if let videoData = JsonParsor().parseVideoData(data: jsonData) {
                                self.addData(videoData)
                            }
                        }
                    }
                    self.onLoadFinish()
                }
            }) {
                self.onLoadFail()
            }
        } else {
            startSearch()
        }
    }
    
    private func startSearch() {
        onLoadRequest = YoutubeDAO().getSearchVideoSnippets(keyword: searchKeyword, pageToken: nextPageToken, responseListener: { (response) in
            self.nextPageToken = response["nextPageToken"] as? String
            self.loadedAllDatas = !(self.nextPageToken != nil)
            if let arrayOfData = response["items"] as? [Any] {
                for dat in arrayOfData {
                    if let jsonData = dat as? [String:Any?] {
                        if let videoData = JsonParsor().parseSearchVideoData(data: jsonData) {
                            self.addData(videoData)
                        }
                    }
                }
                self.onLoadFinish()
            }
        }) {
            self.onLoadFail()
        }
    }
    
    func getDataCount() -> Int {
        return savedData.count
    }
}

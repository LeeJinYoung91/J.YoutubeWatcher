//
//  JsonParsor.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation

class JsonParsor {
    func parseVideoData(data:[String:Any?]) -> YoutubeVideoData? {
        let videoID: String = data["id"] as! String
        if let snippet = data["snippet"] as? [String:Any]{
            let videoTitle = snippet["title"] as! String
            let channelId = snippet["channelId"] as! String
            let channelTitle = snippet["channelTitle"] as! String
            let doc = snippet["description"] as! String
            let date = snippet["publishedAt"] as! String
            var thumbnail: String = ""
            if let value = snippet["thumbnails"] as? [String:Any] {
                if let standard = value["medium"] as? [String:Any] {
                    thumbnail = standard["url"] as! String
                }
            }
            
            if let cachedData = ContentManager.sharedInstance.getContent(id: videoID, type: .Video) as? YoutubeVideoData {
                return cachedData
            }
            
            let dataModel = YoutubeVideoData(videoId: videoID, channelId: channelId, channelTitle: channelTitle, videoTitle: videoTitle, doc: doc, thumbnailURL: thumbnail, publishDate: date)
            return dataModel
        }
        
        return nil
    }
    
    func parseSearchVideoData(data: [String:Any?]) -> YoutubeVideoData? {
        if let idField = data["id"] as? [String:Any] {
            if let videoID = idField["videoId"] as? String {
                if let snippet = data["snippet"] as? [String:Any]{
                    let videoTitle = snippet["title"] as! String
                    let channelId = snippet["channelId"] as! String
                    let channelTitle = snippet["channelTitle"] as! String
                    let doc = snippet["description"] as! String
                    let date = snippet["publishedAt"] as! String
                    var thumbnail: String = ""
                    if let value = snippet["thumbnails"] as? [String:Any] {
                        if let standard = value["medium"] as? [String:Any] {
                            thumbnail = standard["url"] as! String
                        }
                    }
                    
                    if let cachedData = ContentManager.sharedInstance.getContent(id: videoID, type: .Video) as? YoutubeVideoData {
                        return cachedData
                    }
                    
                    let dataModel = YoutubeVideoData(videoId: videoID, channelId: channelId, channelTitle: channelTitle, videoTitle: videoTitle, doc: doc, thumbnailURL: thumbnail, publishDate: date)
                    return dataModel
                }

            }
        }
        
        return nil
    }
}

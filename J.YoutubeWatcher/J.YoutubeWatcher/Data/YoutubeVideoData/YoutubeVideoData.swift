//
//  YoutubeVideoData.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation

class YoutubeVideoData: ContentData {
    private enum CodingKeys: String, CodingKey {
        case videoId
        case videoTitle
        case channelId
        case channelTitle
        case doc
        case thumbnailURL
        case publishDate
    }
    
    var videoTitle: String
    var channelId: String
    var channelTitle: String
    var doc: String
    var thumbnailURL: String
    var publishDate: String
    
    init(videoId:String, channelId:String, channelTitle:String, videoTitle:String, doc:String, thumbnailURL:String, publishDate:String) {
        self.channelId = channelId
        self.channelTitle = channelTitle
        self.videoTitle = videoTitle
        self.doc = doc
        self.thumbnailURL = thumbnailURL
        self.publishDate = publishDate
        super.init(id: videoId)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let obj = try? encoder.encode(self) {
            if let jsonString = String(data: obj, encoding: .utf8) {
                print(jsonString)
            }
        }
        ContentManager.sharedInstance.addContent(id: videoId, data: self, type: .Video)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(videoTitle, forKey: .videoTitle)
        try container.encode(channelId, forKey: .channelId)
        try container.encode(channelTitle, forKey: .channelTitle)
        try container.encode(doc, forKey: .doc)
        try container.encode(thumbnailURL, forKey: .thumbnailURL)
        try container.encode(publishDate, forKey: .publishDate)
        try super.encode(to:
            container.superEncoder(forKey: .videoId)
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

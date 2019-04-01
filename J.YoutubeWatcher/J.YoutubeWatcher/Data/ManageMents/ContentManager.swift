//
//  ContentManager.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation

enum ContentType {
    case Video
    case Channel
}

class ContentManager {
    
    private static let instance = ContentManager()
    static var sharedInstance: ContentManager {
        get {
            return instance
        }
    }
    
    private var contentHolder = [ContentType.Video:[String:ContentData]()]
    
    func addContent(id: String, data: YoutubeVideoData, type: ContentType) {
        if !hasData(id: id, type: type) {
            contentHolder[type]?[id] = data
        }
    }
    
    func getContent(id: String, type: ContentType) -> ContentData? {
        if hasData(id: id, type: type) {
            return contentHolder[type]?[id]
        }
        
        return nil
    }
    
    func hasData(id: String, type: ContentType) -> Bool {
        if let contain = contentHolder[type]?.contains(where: { res in
            return res.key == id
        }) {
            return contain
        }
        
        return false
    }
}

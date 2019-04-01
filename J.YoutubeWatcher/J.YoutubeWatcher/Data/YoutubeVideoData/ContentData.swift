//
//  ContentData.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 19/03/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation

class ContentData: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
    }
    
    private var id: String
    var ID: String {
        get {
            return id
        }
    }
    
    init(id: String) {
        self.id = id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}

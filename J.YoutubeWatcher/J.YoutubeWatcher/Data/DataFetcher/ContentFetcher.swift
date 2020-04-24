//
//  ContentFetcher.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 19/03/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class ContentFetcher {
    internal var savedData: [ContentData] = [ContentData]()
    internal var onLoading: Bool = false
    internal var loadedAllDatas: Bool = false
    internal var nextPageToken: String?
    internal var totalCount: Int = 0

    func loadModel(loadDataListener: (([ContentData]) -> Void)?) {}
    
    func addData(_ data: ContentData) {
        if self.savedData.contains(where: { (saveData) -> Bool in
            return data.ID == saveData.ID
        }) {} else {
            self.savedData.append(data)
        }
    }
    
    func onLoadFinish() {
        onLoading = false
    }
    
    func onLoadFail() {
        onLoading = false
    }
    
    func getModelIndex(_ data: ContentData) -> Int {
        let index = savedData.firstIndex(where: { $0.ID == data.ID })
        return Int(index!)
    }
    
    func getModelAt(_ index: Int) -> ContentData? {
        guard index < savedData.count else {
            return nil
        }
        
        return savedData[index]
    }
    
    func clearData() {
        savedData.removeAll()
        nextPageToken = nil
        loadedAllDatas = false
        onLoading = false
    }
}

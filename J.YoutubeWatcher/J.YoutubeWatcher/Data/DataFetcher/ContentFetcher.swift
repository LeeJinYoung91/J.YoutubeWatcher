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
    private var observeViewControllers = [UIViewController]()
    internal var loadedAllDatas: Bool = false
    internal var nextPageToken: String?

    func loadModel() {}
    
    func addData(_ data: ContentData) {
        if self.savedData.contains(where: { (saveData) -> Bool in
            return data.ID == saveData.ID
        }) {} else {
            self.savedData.append(data)
        }
    }
    
    func onLoadFinish() {
        onLoading = false
        for observer in observeViewControllers {
            (observer as? (DataFetchProtocol))?.loadSuccess?()
        }
    }
    
    func onLoadFail() {
        onLoading = false
        for observer in observeViewControllers {
            (observer as? (DataFetchProtocol))?.loadFailure?()
        }
    }
    
    func getModelAt(_ index: Int) -> ContentData? {
        guard index < savedData.count else {
            return nil
        }
        
        return savedData[index]
    }
    
    func bindObserver(_ observer: UIViewController) {
        if !observeViewControllers.contains(observer) {
            observeViewControllers.append(observer)
        }
    }
    
    func removeObserver(_ observer: UIViewController) {
        if let index = observeViewControllers.index(of: observer) {
            observeViewControllers.remove(at: index)
        }
    }
    
    func clearData() {
        savedData.removeAll()
        nextPageToken = nil
        loadedAllDatas = false
        onLoading = false
    }
}

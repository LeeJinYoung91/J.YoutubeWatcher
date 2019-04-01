//
//  DataFetchProtocol.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation

@objc protocol DataFetchProtocol {
    @objc optional func loadSuccess()
    @objc optional func loadFailure()
}

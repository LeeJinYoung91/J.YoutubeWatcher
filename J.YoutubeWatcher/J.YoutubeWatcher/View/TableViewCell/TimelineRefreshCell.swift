//
//  TimelineRefreshCell.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 24/04/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class TimelineRefreshCell: UITableViewCell {
    @IBOutlet weak var activityController: UIActivityIndicatorView!    
    override func awakeFromNib() {
        activityController.startAnimating()
    }
    
    func startAnimate() {
        activityController.startAnimating()
    }
}

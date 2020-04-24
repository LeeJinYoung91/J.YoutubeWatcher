//
//  TimelineViewController.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class TimelineVideoController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var timelineTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    private let videoFetcher:YoutubeVideoFetcher = YoutubeVideoFetcher()
    private final let PreLoadCount = 1
    private var whileLoadMore:Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        timelineTableView.rowHeight = UITableView.automaticDimension
        timelineTableView.estimatedRowHeight = UIScreen.main.bounds.height
        searchBar.delegate = self
        loadData()
        backgroundView.isHidden = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBackground)))
    }
    
    @objc private func onClickBackground() {
        if searchBar.canResignFirstResponder {
            searchBar.resignFirstResponder()
        }
        backgroundView.isHidden = true
    }
    
    private func startSearch(_ searchWord:String) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            if let videoPlayer = segue.destination as? VideoPlayerViewController {
                if let indexPath = timelineTableView.indexPath(for: cell) {
                    videoPlayer.setData(videoFetcher.getModelAt(indexPath.row) as! YoutubeVideoData)
                }
            }
        }
    }
}

extension TimelineVideoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoFetcher.getDataCount() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == videoFetcher.getDataCount() {
            if let refreshCell: TimelineRefreshCell = tableView.dequeueReusableCell(withIdentifier: "id_refreshCell", for: indexPath) as? TimelineRefreshCell {
                refreshCell.startAnimate()
                return refreshCell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_timelineVideoCell", for: indexPath) as! TimelineVideoCell
        if let data = videoFetcher.getModelAt(indexPath.row) as? YoutubeVideoData {
            cell.setData(data)
        }
                
        if indexPath.row == videoFetcher.getDataCount() - 1 {
            loadModelIfNeed()
        }
        
        return cell
    }
    
    private func loadModelIfNeed() {
        guard !whileLoadMore else {
            return
        }
        
        whileLoadMore = true
        loadData()
    }
    
    private func loadData() {
        videoFetcher.loadModel { [weak self](contentList) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.timelineTableView.reloadData()
            strongSelf.whileLoadMore = false
        }
    }
}

extension TimelineVideoController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 10 {
//            self.loadModelIfNeed()
//        }
    }
}

extension TimelineVideoController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        backgroundView.isHidden = false
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        backgroundView.isHidden = true
        searchBar.resignFirstResponder()
        if let searchKeyword = searchBar.text {
            guard !searchKeyword.isEmpty else {
                return
            }
            
            videoFetcher.SearchKeyWord = searchKeyword
            videoFetcher.clearData()
            timelineTableView.reloadData()
            loadData()
        }
    }    
}

extension UINavigationController {
    open override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? true
    }
}

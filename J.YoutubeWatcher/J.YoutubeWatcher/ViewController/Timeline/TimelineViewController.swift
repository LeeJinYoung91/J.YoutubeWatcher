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
    
    override func viewDidLoad() {
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        searchBar.delegate = self
        videoFetcher.loadModel()
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
        videoFetcher.bindObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        videoFetcher.removeObserver(self)
    }
}

extension TimelineVideoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoFetcher.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_timelineVideoCell", for: indexPath) as! TimelineVideoCell
        if let data = videoFetcher.getModelAt(indexPath.row) as? YoutubeVideoData {
            cell.setData(data)
        }
        loadModelIfNeed(indexPath.row)
        return cell
    }
    
    private func loadModelIfNeed(_ displayIndex:Int) {
        guard !whileLoadMore else {
            return
        }
        
        if (displayIndex == (videoFetcher.getDataCount() - PreLoadCount)) {
            whileLoadMore = true
            videoFetcher.loadModel()
        }
    }
}

extension TimelineVideoController: DataFetchProtocol {
    func loadSuccess() {
        timelineTableView.reloadData()
    }
    
    func loadFailure() {
        timelineTableView.reloadData()
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
            videoFetcher.loadModel()
        }
    }    
}

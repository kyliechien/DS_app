//
//  SearchVideoTableViewController.swift
//  simulation
//
//  Created by U10916003 on 2023/8/29.
//

import UIKit
import SideMenu

class SearchVideoViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MenuControllerDelegate {
    
    var sideMenu: SideMenuNavigationController?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var backButton: UIButton! {
        didSet {
            backButton.layer.cornerRadius = backButton.bounds.width/2
        }
    }
    
    
    
    let useSearchAPI = searchAPI()
    var searchVideoSort : String?
    var searchToken: String?
    var debouncedScrollAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let menu = MenuController(with: ["模擬","練習","相關程式碼","相關影片","回到排序選擇畫面"])
        
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        guard let searchKeyword = searchVideoSort else { return }

        var searchKeyword: String = ""
        
        if let tempKeyword = searchVideoSort {
            switch tempKeyword {
            case "insertionsort":
                searchKeyword = "插入排序"
            case "countingsort":
                searchKeyword = "countingsort"
            case "quicksort":
                searchKeyword = "快速排序"
            case "mergesort":
                searchKeyword = "合併排序"
            default:
                break
            }
        }
        
        useSearchAPI.searchYoutubeVideo(keyword: searchKeyword, pageToken: ""){ newVideo, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if let newVideo = newVideo {
                        
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return useSearchAPI.getVideo().count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "youtubeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchVideoTableViewCell

        // Configure the cell...
        cell.videoTitleLabel?.text = useSearchAPI.getVideo()[indexPath.row].title
        
        cell.videoChannelLabel?.text = "頻道﻿名稱﻿：\(useSearchAPI.getVideo()[indexPath.row].channelTitle)"
        

        
        URLSession.shared.dataTask(with: useSearchAPI.getVideo()[indexPath.row].thumbnailUrl) { data, response, error in
                   if let data = data {
                       DispatchQueue.main.async {
                           if let image = UIImage(data: data) {
                               cell.videoImage.image = image
                           }
                       }
                   }
               }.resume()
        
         
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoId = useSearchAPI.getVideo()[indexPath.row].videoId
        
        guard let youtubeUrl = URL(string: "youtube://\(videoId)") else {
            return
            
        }
        if UIApplication.shared.canOpenURL(youtubeUrl) {
            UIApplication.shared.open(youtubeUrl)
        } else {
            guard let videoUrl = URL(string: "https://www.youtube.com/watch?v=\(videoId)") else { return }
            UIApplication.shared.open(videoUrl)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
        if debouncedScrollAction == nil {
            debouncedScrollAction = debounce(interval: 1.0) { [weak self] in
                guard let self = self else { return }
                let position = scrollView.contentOffset.y
                if position > self.tableView.contentSize.height - 100 - scrollView.frame.size.height {
                    
                    
                    guard let searchKeyword = searchVideoSort else { return }
                    
                    useSearchAPI.searchYoutubeVideo(keyword: searchKeyword, pageToken: useSearchAPI.searchToken){ newVideo, error in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else {
                            if let newVideo = newVideo {
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }

        debouncedScrollAction?()
        
            
    }
//
    func debounce(interval: TimeInterval, block: @escaping () -> Void) -> () -> Void {
        var timer: Timer?
        return {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
                block()
            }
        }
    }
    
    @IBAction func turnBackMenu(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
        present(sideMenu!, animated: true)
    }

    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            if named == "模擬" {
                self?.goToDstSortv()
            }
            else if named == "練習" {
                let practiceVc = self?.storyboard?.instantiateViewController(withIdentifier: "PracticeViewController") as! Practice
                self?.navigationController?.pushViewController(practiceVc, animated: true)
                practiceVc.sort = self?.searchVideoSort
            }
            else if named == "相關程式碼" {
                let searchCodeVc = self?.storyboard?.instantiateViewController(withIdentifier: "SearchCodeViewController") as! SearchCodeViewController
                self?.navigationController?.pushViewController(searchCodeVc, animated: true)
                searchCodeVc.searchCodeSort = self?.searchVideoSort
            }
            else if named == "相關影片" {
            }
            else if named == "回到排序選擇畫面" {
                self?.navigationController?.popToRootViewController(animated: true)
                
            }
        })
    }
    
    func goToDstSortv() {
        //let dstSort
        
        switch(searchVideoSort){
        case "insertionsort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "InsertionSortSimulation") as! InsertionSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchVideoSort
            
        case "countingsort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "CountingSortSimulation") as! CountingSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchVideoSort
            
        case "quicksort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "QuickSortSimulation") as! QuickSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchVideoSort
            
        case "mergesort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "MergeSortSimulation") as! MergeSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchVideoSort
            
        default:
            break
        }
        
        
    }


}

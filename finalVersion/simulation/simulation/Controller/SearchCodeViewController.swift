//
//  SearchCodeViewController.swift
//  simulation
//
//  Created by U10916003 on 2023/9/15.
//

import UIKit
import FirebaseDatabase
import SideMenu



class SearchCodeViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MenuControllerDelegate {

    var sideMenu: SideMenuNavigationController?
    
    @IBOutlet var filter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var backButton: UIButton! {
        didSet {
            backButton.layer.cornerRadius = backButton.bounds.width/2
        }
    }
    
    
    var debouncedScrollAction: (() -> Void)?
    let useSearchAPI = searchAPI()
    var githubRepo : [Repository] = []
    var searchCodeSort : String?
    var ref: DatabaseReference!
    var page = 1
    var filterLanguage = ""
    var filterSort = ""
    
    
    
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
        
        //MARK: - pullDownButton set
        
        
        
        filter.showsMenuAsPrimaryAction = true
        filter.menu = UIMenu(children: 
                                [UIMenu(title: "程式語言", options: .singleSelection, children: [
                                    UIAction(title: "所有程式語言", state: .on, handler: { action in
                                        self.filterLanguage = ""
                                        self.firstCallRepo()
                                        
                                    }), UIAction(title: "C", handler: { action in
                                        self.filterLanguage = "C"
                                        self.firstCallRepo()
                                    }), UIAction(title: "C++", handler: { action in
                                        self.filterLanguage = "Cpp"
                                        self.firstCallRepo()
                                    }), UIAction(title: "Java", handler: { action in
                                        self.filterLanguage = "Java"
                                        self.firstCallRepo()
                                    }), UIAction(title: "Python", handler: { action in
                                        self.filterLanguage = "Python"
                                        self.firstCallRepo()
                                    })
                                ]),
                                 UIMenu(title: "排序方式", options: .singleSelection, children: [
                                    UIAction(title: "最相關結果", state: .on, handler: { action in
                                        self.filterSort = "best match"
                                        self.firstCallRepo()
                                    }),
                                    UIAction(title: "星數高到低", handler: { action in
                                        self.filterSort = "stars&order=desc"
                                        self.firstCallRepo()
                                    }),
                                    UIAction(title: "星數低到高", handler: { action in
                                        self.filterSort = "stars&order=asc"
                                        self.firstCallRepo()
                                    })
                                 ])
                                ])
    
        
        firstCallRepo()

        


    }

   
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return githubRepo.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchCodeTableViewCell

        // Configure the cell...
        cell.titleLabel?.text = githubRepo[indexPath.row].name
        cell.starsLabel?.text = String(githubRepo[indexPath.row].stars)
        cell.authorLabel?.text = githubRepo[indexPath.row].login
        cell.languageLabel.text = githubRepo[indexPath.row].language
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let html_url = githubRepo[indexPath.row].html_url
        
        if let url = URL(string: html_url){
            UIApplication.shared.open(url)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if debouncedScrollAction == nil {
            debouncedScrollAction = debounce(interval: 1.0) { [weak self] in
                guard let self = self else { return }
                let position = scrollView.contentOffset.y
                if position > self.tableView.contentSize.height - 100 - scrollView.frame.size.height {
                    self.page += 1
                    print(self.page)

                    guard let searchKeyword = self.searchCodeSort else { return }
                    useSearchAPI.searchGitHubRepositories(keyword: searchKeyword, pageNum: self.page, language: self.filterLanguage, sequence: self.filterSort) { repositories, error in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else {
                            if let repositories = repositories {
                                self.githubRepo = repositories

                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    self.spinner.stopAnimating()
                                    self.spinner.isHidden = true
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
//        self.navigationController?.popViewController(animated: true)
        present(sideMenu!, animated: true)
    }

    //@IBAction func languageChoose(_ sender:)
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            if named == "模擬" {
                self?.goToDstSortv()
            }
            else if named == "練習" {
                let practiceVc = self?.storyboard?.instantiateViewController(withIdentifier: "PracticeViewController") as! Practice
                self?.navigationController?.pushViewController(practiceVc, animated: true)
                practiceVc.sort = self?.searchCodeSort
            }
            else if named == "相關程式碼" {
                
            }
            else if named == "相關影片" {
                let searchVideoVc = self?.storyboard?.instantiateViewController(withIdentifier: "SearchVideoViewController") as! SearchVideoViewController
                self?.navigationController?.pushViewController(searchVideoVc, animated: true)
                searchVideoVc.searchVideoSort = self?.searchCodeSort
            }
            else if named == "回到排序選擇畫面" {
//                let sortMenuVc = self?.storyboard?.instantiateViewController(withIdentifier: "SortMenu") as! SortMenu
//                self?.navigationController?.pushViewController(sortMenuVc, animated: true)
//                self?.navigationController?.popViewController(animated: true)
//                self?.performSegue(withIdentifier: "toSortMenu", sender: self)
                self?.navigationController?.popToRootViewController(animated: true)
                
            }
        })
    }
    
    func goToDstSortv() {
        //let dstSort
        
        switch(searchCodeSort){
        case "insertionsort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "InsertionSortSimulation") as! InsertionSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchCodeSort
            
        case "countingsort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "CountingSortSimulation") as! CountingSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchCodeSort
            
        case "quicksort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "QuickSortSimulation") as! QuickSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchCodeSort
            
        case "mergesort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "MergeSortSimulation") as! MergeSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            dstSortVc.sort = searchCodeSort
            
        default:
            break
        }
        
        
    }
    
    
    
    func firstCallRepo(){
        self.useSearchAPI.initRepo()
        self.githubRepo = []
        self.tableView.reloadData()
        
        guard let searchKeyword = searchCodeSort else { return }
        useSearchAPI.searchGitHubRepositories(keyword: searchKeyword, pageNum: 1, language: self.filterLanguage, sequence: self.filterSort){ repositories, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if let repositories = repositories {

                    self.githubRepo = repositories

                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                    }
                }
            }
        }
    }
}

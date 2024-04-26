//
//  MenuListController.swift
//  simulation
//
//  Created by WanHsuan on 2023/11/24.
//
import UIKit
import SideMenu



protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}

class MenuController: UITableViewController{
    
    public var delegate: MenuControllerDelegate?
    private let menuItems: [String]
    
    init(with menuItems: [String]){
        self.menuItems = menuItems
        super.init(nibName: nil,bundle: nil)
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var items = ["First","Second","Third"]
//    var whichSort: String?
    
    let darkColor = UIColor(rgb: 0x363636)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(handleDataNotification(_:)), name: NSNotification.Name("DataNotification"), object: nil)
        

    }

//    @objc func handleDataNotification(_ notification: Notification) {
//        if let data = notification.object as? String? {
//            whichSort = data
//        }
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let pageSource = segue.destination as! Practice
//        pageSource.sort = whichSort
//        pageSource.previousVC = self
       
    }
    
    func goToVideoCode() {
        let searchVideoVc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVideoViewController") as! SearchVideoViewController
        self.navigationController?.pushViewController(searchVideoVc, animated: true)
            searchVideoVc.searchVideoSort = "insertionsort"
    
    }
}

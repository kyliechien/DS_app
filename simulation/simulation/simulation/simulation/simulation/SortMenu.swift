//
//  SortMenu.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/3.
//

//import Foundation
import UIKit


class SortMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToCountingSortSimulation(_ sender: UIButton) {
        performSegue(withIdentifier: "toCountingSortSimulation", sender: self)
    }
    
    @IBAction func goToInsertionSortSimulation(_ sender: UIButton) {
        performSegue(withIdentifier: "toInsertionSortSimulation", sender: self)
    }
    
    @IBAction func goToQuickSortSimulation(_ sender: UIButton) {
        performSegue(withIdentifier: "toQuickSortSimulation", sender: self)
    }
    
    
    @IBAction func goToCodeSearch(_ sender: UIButton) {
            self.performSegue(withIdentifier: "toSearchCode", sender: self)
        }

}

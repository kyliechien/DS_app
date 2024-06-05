//
//  SelectModeViewController.swift
//  simulation
//
//  Created by U10916003 on 2023/9/12.
//

import UIKit

class SelectModeViewController: UIViewController {
    
    var sort: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToDstSortv(_ sender: UIButton) {
        //let dstSort
        
        switch(sort){
        case "insertionsort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "InsertionSortSimulation") as! InsertionSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            
        case "countingsort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "CountingSortSimulation") as! CountingSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
        case "quicksort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "QuickSortSimulation") as! QuickSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            
        case "mergesort":
            let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "MergeSortSimulation") as! MergeSortSimulation
            self.navigationController?.pushViewController(dstSortVc, animated: true)
            
        default:
            break
        }
        
        
    }
    
    @IBAction func goToSearchCode(_ sender: UIButton) {
        let searchCodeVc = self.storyboard?.instantiateViewController(withIdentifier: "SearchCodeViewController") as! SearchCodeViewController
        self.navigationController?.pushViewController(searchCodeVc, animated: true)
        
        searchCodeVc.searchCodeSort = sort
    }
    
    @IBAction func goToVideoCode(_ sender: UIButton) {
        let searchVideoVc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVideoViewController") as! SearchVideoViewController
        self.navigationController?.pushViewController(searchVideoVc, animated: true)
        searchVideoVc.searchVideoSort = sort
    }
    
    
    @IBAction func goToPractice(_ sender: UIButton){
        performSegue(withIdentifier: "toPractice", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pageSource = segue.destination as! Practice
        pageSource.sort = sort
        pageSource.previousVC = self
       
    }
    
    
    @IBAction func backToHomepage(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

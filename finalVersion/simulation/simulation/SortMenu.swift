//
//  SortMenu.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/3.
//

//import Foundation
import UIKit



class SortMenu: UIViewController {
    
    @IBOutlet var homeButton_sort : UIButton!
    @IBOutlet var learnButton_sort : UIButton!
    @IBOutlet var testButton_sort : UIButton!

    
    var color = UIColor(rgb: 0x363636)
    //var chooseSort : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // MARK: - Learn button
        let learnSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let learnSymbolImage = UIImage(systemName: "book.fill", withConfiguration: learnSymbolConfig)
        let learnColoredSymbolImage = learnSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        learnButton_sort.setImage(learnColoredSymbolImage, for: .normal)
        
        // MARK: - Home button
        let homeSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let homeSymbolImage = UIImage(systemName: "house", withConfiguration: homeSymbolConfig)
        let homeColoredSymbolImage = homeSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        homeButton_sort.setImage(homeColoredSymbolImage, for: .normal)
        
        // MARK: - Test button
        let testSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let testSymbolImage = UIImage(systemName: "graduationcap", withConfiguration: testSymbolConfig)
        let testColoredSymbolImage = testSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        testButton_sort.setImage(testColoredSymbolImage, for: .normal)
        
        
    }

    
    
    @IBAction func goToCountingSortSimulation(_ sender: UIButton) {
        let countingSortSimulationVc = self.storyboard?.instantiateViewController(withIdentifier: "CountingSortSimulation") as! CountingSortSimulation
        self.navigationController?.pushViewController(countingSortSimulationVc, animated: true)
        countingSortSimulationVc.sort = "countingsort"
    }
    
    @IBAction func goToInsertionSortSimulation(_ sender: UIButton) {
           let insertionSortSimulationVc = self.storyboard?.instantiateViewController(withIdentifier: "InsertionSortSimulation") as! InsertionSortSimulation
           self.navigationController?.pushViewController(insertionSortSimulationVc, animated: true)
           
           
           insertionSortSimulationVc.sort = "insertionsort"
           
       }
    
    @IBAction func goToQuickSortSimulation(_ sender: UIButton) {
            let quickSortSimulationVc = self.storyboard?.instantiateViewController(withIdentifier: "QuickSortSimulation") as! QuickSortSimulation
            self.navigationController?.pushViewController(quickSortSimulationVc, animated: true)
            quickSortSimulationVc.sort = "quicksort"
        }
    
    
    @IBAction func goToMergeSortSimulation(_ sender: UIButton) {
           let mergeSortSimulationVc = self.storyboard?.instantiateViewController(withIdentifier: "MergeSortSimulation") as! MergeSortSimulation
           self.navigationController?.pushViewController(mergeSortSimulationVc, animated: true)
           mergeSortSimulationVc.sort = "mergesort"
       }

    @IBAction func backToHomepage(_ sender: UIButton){
   //        self.dismiss(animated: true,completion: nil)
           self.performSegue(withIdentifier: "toHome", sender: self)
   //        self.navigationController?.popToRootViewController(animated: true)
       }
       
       
       @IBAction func goToTest(_ sender: UIButton){
           self.performSegue(withIdentifier: "toTest", sender: self)
       }
}

//
//  TestMenu.swift
//  simulation
//
//  Created by WanHsuan on 2023/9/5.
//

import UIKit
import FirebaseAuth


class TestMenu: UIViewController {
    
    @IBOutlet var homeButton_sort : UIButton!
    @IBOutlet var learnButton_sort : UIButton!
    @IBOutlet var testButton_sort : UIButton!

    
    
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var myView: UIView!
    
    @IBOutlet var test1Star: UILabel!
    @IBOutlet var test2Star: UILabel!
    @IBOutlet var test3Star: UILabel!
    @IBOutlet var test4Star: UILabel!
    @IBOutlet var test5Star: UILabel!
    
    var test: String?
    
    var test1StarNum = 0
    var test2StarNum = 0
    var test3StarNum = 0
    var test4StarNum = 0
    var test5StarNum = 0
    
    var color = UIColor(rgb: 0x363636)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // MARK: - Learn button
        let learnSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let learnSymbolImage = UIImage(systemName: "book", withConfiguration: learnSymbolConfig)
        let learnColoredSymbolImage = learnSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        learnButton_sort.setImage(learnColoredSymbolImage, for: .normal)
        
        // MARK: - Home button
        let homeSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let homeSymbolImage = UIImage(systemName: "house", withConfiguration: homeSymbolConfig)
        let homeColoredSymbolImage = homeSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        homeButton_sort.setImage(homeColoredSymbolImage, for: .normal)
        
        // MARK: - Test button
        let testSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let testSymbolImage = UIImage(systemName: "graduationcap.fill", withConfiguration: testSymbolConfig)
        let testColoredSymbolImage = testSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        testButton_sort.setImage(testColoredSymbolImage, for: .normal)
        
       
        
        let myViewY = 0-myView.frame.origin.y
        myScrollView.contentSize.width = myView.frame.size.width
        myScrollView.contentSize.height = myView.frame.size.height+myView.frame.origin.y //1600-406
        myScrollView.contentInset = UIEdgeInsets(top: myViewY, left: 0, bottom: 0, right: 0)
        
        
        // MARK: - Load Stars
        
        
        // here comment are load data from database, when use it cancel it
        let user = Auth.auth().currentUser
        let uid = (user?.uid)!
        let dataProcess = DataProcess()
        

        dataProcess.loadUserFromData(UID: uid) { (user) in
            if let user = user {
                self.showStars(self.test1Star, 1, stars: user.getStars()[0])
                self.showStars(self.test2Star, 2, stars: user.getStars()[1])
                self.showStars(self.test3Star, 3, stars: user.getStars()[2])
                self.showStars(self.test4Star, 4, stars: user.getStars()[3])
                self.showStars(self.test5Star, 5, stars: user.getStars()[4])
                
            } else {
                
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countStarNum(test1Star,1)
        countStarNum(test2Star,2)
        countStarNum(test3Star,3)
        countStarNum(test4Star,4)
        countStarNum(test5Star,5)
    }
    
    

    @IBAction func backToHomepage(_ sender: UIButton){
//        self.dismiss(animated: true,completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)
        self.performSegue(withIdentifier: "toHome", sender: self)
    }
    
    @IBAction func goToLearn(_ sender: UIButton){
        self.performSegue(withIdentifier: "toLearn", sender: self)
    }
    
    @IBAction func goToTest1(_ sender: UIButton){
        test = "test1"
        self.performSegue(withIdentifier: "toTest", sender: self)
        
//        pageSource.lastTimeStarNum = test1StarNum
//        pageSource.previousVC = self
        
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            let pageSource = segue.destination as! Test
//            pageSource.test = "test1"
//            pageSource.previousVC = self
//                let pageSourceT1 = segue.destination as! Test1
//                pageSourceT1.lastTimeStarNum = test1StarNum
//                pageSourceT1.previousVC = self
//        }
        
    }
    
    @IBAction func goToTest2(_ sender: UIButton){
        test = "test2"
        self.performSegue(withIdentifier: "toTest", sender: self)
    }

    @IBAction func goToTest3(_ sender: UIButton){
        test = "test3"
        self.performSegue(withIdentifier: "toTest", sender: self)
    }

    @IBAction func goToTest4(_ sender: UIButton){
        test = "test4"
        self.performSegue(withIdentifier: "toTest", sender: self)
    }

    @IBAction func goToTest5(_ sender: UIButton){
        test = "test5"
        self.performSegue(withIdentifier: "toTest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTest" {
            let pageSource = segue.destination as! Test
            pageSource.test = test
            pageSource.previousVC = self
            switch(test){
            case "test1":
                pageSource.t1LastTimeStarNum = test1StarNum
            case "test2":
                pageSource.t2LastTimeStarNum = test2StarNum
            case "test3":
                pageSource.t3LastTimeStarNum = test3StarNum
            case "test4":
                pageSource.t4LastTimeStarNum = test4StarNum
            case "test5":
                pageSource.t5LastTimeStarNum = test5StarNum
            default:
                break
            }
        }else{
            
        }
    }
        
        
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let pageSourceT1 = segue.destination as! Test1
        //        pageSourceT1.lastTimeStarNum = test1StarNum
        //        pageSourceT1.previousVC = self
        //
        //        let pageSourceT2 = segue.destination as! Test2
        //        pageSourceT2.lastTimeStarNum = test2StarNum
        //        pageSourceT2.previousVC = self
        //
        //        let pageSourceT3 = segue.destination as! Test3
        //        pageSourceT3.lastTimeStarNum = test3StarNum
        //        pageSourceT3.previousVC = self
        //
        //        let pageSourceT4 = segue.destination as! Test4
        //        pageSourceT4.lastTimeStarNum = test4StarNum
        //        pageSourceT4.previousVC = self
        //
        //        let pageSourceT5 = segue.destination as! Test5
        //        pageSourceT5.lastTimeStarNum = test5StarNum
        //        pageSourceT5.previousVC = self
        //
        //    }
        
        //    @IBAction func goToTest1(_ sender: UIButton) {
        //        let testVc = self.storyboard?.instantiateViewController(withIdentifier: "test") as! Test
        //        self.navigationController?.pushViewController(testVc, animated: true)
        //        testVc.test = "test1"
        //    }
        //
        //    @IBAction func goToTest2(_ sender: UIButton) {
        //        let testVc = self.storyboard?.instantiateViewController(withIdentifier: "test") as! Test
        //        self.navigationController?.pushViewController(testVc, animated: true)
        //
        //        //selectModeVc.sort = "%E6%8F%92%E5%85%A5%E6%8E%92%E5%BA%8F"
        //        testVc.test = "test2"
        //
        //    }
        //
        //    @IBAction func goToTest3(_ sender: UIButton) {
        //        let testVc = self.storyboard?.instantiateViewController(withIdentifier: "test") as! Test
        //        self.navigationController?.pushViewController(testVc, animated: true)
        //        testVc.test = "test3"
        //    }
        //
        //
        //    @IBAction func goToTest4(_ sender: UIButton) {
        //        let testVc = self.storyboard?.instantiateViewController(withIdentifier: "test") as! Test
        //        self.navigationController?.pushViewController(testVc, animated: true)
        //        testVc.test = "test4"
        //    }
        //
        //    @IBAction func goToTest5(_ sender: UIButton) {
        //        let testVc = self.storyboard?.instantiateViewController(withIdentifier: "test") as! Test
        //        self.navigationController?.pushViewController(testVc, animated: true)
        //        testVc.test = "test5"
        //    }
        //
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let pageSource = segue.destination as! Test1
        //        pageSource.test = test
        //        pageSource.previousVC = self
        //    }
        
        
        
        
        func countStarNum(_ label: UILabel,_ whichTest: Int){
            switch whichTest
            {
            case 1:
                if label.text == "☆☆☆"{
                    test1StarNum = 0
                }else if label.text == "★☆☆"{
                    test1StarNum = 1
                }else if label.text == "★★☆"{
                    test1StarNum = 2
                }else if label.text == "★★★"{
                    test1StarNum = 3
                }else{
                    test1StarNum = 0
                }
            case 2:
                if label.text == "☆☆☆"{
                    test2StarNum = 0
                }else if label.text == "★☆☆"{
                    test2StarNum = 1
                }else if label.text == "★★☆"{
                    test2StarNum = 2
                }else if label.text == "★★★"{
                    test2StarNum = 3
                }else{
                    test2StarNum = 0
                }
            case 3:
                if label.text == "☆☆☆"{
                    test3StarNum = 0
                }else if label.text == "★☆☆"{
                    test3StarNum = 1
                }else if label.text == "★★☆"{
                    test3StarNum = 2
                }else if label.text == "★★★"{
                    test3StarNum = 3
                }else{
                    test3StarNum = 0
                }
            case 4:
                if label.text == "☆☆☆"{
                    test4StarNum = 0
                }else if label.text == "★☆☆"{
                    test4StarNum = 1
                }else if label.text == "★★☆"{
                    test4StarNum = 2
                }else if label.text == "★★★"{
                    test4StarNum = 3
                }else{
                    test4StarNum = 0
                }
            case 5:
                if label.text == "☆☆☆"{
                    test5StarNum = 0
                }else if label.text == "★☆☆"{
                    test5StarNum = 1
                }else if label.text == "★★☆"{
                    test5StarNum = 2
                }else if label.text == "★★★"{
                    test5StarNum = 3
                }else{
                    test5StarNum = 0
                }
            default:
                break
            }
            
        }
        
        
    func showStars(_ label: UILabel,_ whichTest: Int, stars: Int){
        switch whichTest
        {
        case 1:
            if stars == 0{
                label.text = "☆☆☆"
            }else if stars == 1{
                label.text = "★☆☆"
            }else if stars == 2{
                label.text = "★★☆"
            }else {
                label.text = "★★★"
            }
        case 2:
            if stars == 0{
                label.text = "☆☆☆"
            }else if stars == 1{
                label.text = "★☆☆"
            }else if stars == 2{
                label.text = "★★☆"
            }else {
                label.text = "★★★"
            }
        case 3:
            if stars == 0{
                label.text = "☆☆☆"
            }else if stars == 1{
                label.text = "★☆☆"
            }else if stars == 2{
                label.text = "★★☆"
            }else {
                label.text = "★★★"
            }
        case 4:
            if stars == 0{
                label.text = "☆☆☆"
            }else if stars == 1{
                label.text = "★☆☆"
            }else if stars == 2{
                label.text = "★★☆"
            }else {
                label.text = "★★★"
            }
        case 5:
            if stars == 0{
                label.text = "☆☆☆"
            }else if stars == 1{
                label.text = "★☆☆"
            }else if stars == 2{
                label.text = "★★☆"
            }else {
                label.text = "★★★"
            }
        default:
            break
        }
        
    }
    
    
    
}


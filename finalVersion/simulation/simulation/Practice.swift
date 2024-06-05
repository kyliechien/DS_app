//
//  Practice.swift
//  simulation
//
//  Created by WanHsuan on 2023/11/15.
//

import UIKit
import SideMenu
import FirebaseAuth


class Practice: UIViewController, MenuControllerDelegate {
    
    var sideMenu: SideMenuNavigationController?
    
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var myView: UIView!
    
    @IBOutlet var q1: UILabel!
    @IBOutlet var q2: UILabel!
    @IBOutlet var q3: UILabel!
    @IBOutlet var q4: UILabel!
    @IBOutlet var q5: UILabel!
    
    @IBOutlet var ans1: UILabel!
    @IBOutlet var ans2: UILabel!
    @IBOutlet var ans3: UILabel!
    @IBOutlet var ans4: UILabel!
    @IBOutlet var ans5: UILabel!
    
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!
    @IBOutlet var btn10: UIButton!
    @IBOutlet var btn11: UIButton!
    @IBOutlet var btn12: UIButton!
    @IBOutlet var btn13: UIButton!
    @IBOutlet var btn14: UIButton!
    @IBOutlet var btn15: UIButton!
    @IBOutlet var btn16: UIButton!
    @IBOutlet var btn17: UIButton!
    @IBOutlet var btn18: UIButton!
    @IBOutlet var btn19: UIButton!
    @IBOutlet var btn20: UIButton!

    @IBOutlet var sentAnsButton: UIButton!
    
    @IBOutlet var button1: UIButton! {
        didSet {
            button1.layer.cornerRadius = button1.bounds.width/2
        }
    }
    
    
    
    
    var q1Btns: [UIButton] = []
    var q2Btns: [UIButton] = []
    var q3Btns: [UIButton] = []
    var q4Btns: [UIButton] = []
    var q5Btns: [UIButton] = []
    
    var ansArr: [UILabel] = []
    
//    @IBOutlet var q1Btns: [UIButton]!
//    @IBOutlet var q2Btns: [UIButton]!
//    @IBOutlet var q3Btns: [UIButton]!
//    @IBOutlet var q4Btns: [UIButton]!
//    @IBOutlet var q5Btns: [UIButton]!
    
    
    var allBtns: [[UIButton]] = []
    
    var whichQ: [UIButton]?
    var isFinsih = false
    
    var correctAnsNum = 0
    var starNum = 0
    var lastTimeStarNum = 0
    
    var questionOrder = [Int]()
    var qtOpt1:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"] //改
    var qtOpt2:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt3:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt4:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt5:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    
    var questAndAns:[Int:String] = [1:"﻿一", 2:"﻿二", 3:"﻿三", 4:"﻿四", 5:"﻿四"]
    
    var previousVC: SelectModeViewController?
    var sort: String?
    
//    var previousVC: TestMenu?
    
    var color_unselected = UIColor(rgb: 0x8E8E93) //按鈕原色
    var color_selected = UIColor(rgb: 0x3891d1) //被選中的按鈕顏色
    
    
    @IBAction func turnBackMenu(_ sender: UIButton){
    //        self.navigationController?.popViewController(animated: true)
            present(sideMenu!, animated: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = MenuController(with: ["模擬","練習","相關程式碼","相關影片","回到排序選擇畫面"])
                
                menu.delegate = self
                
                sideMenu = SideMenuNavigationController(rootViewController: menu)
                sideMenu?.leftSide = true
                SideMenuManager.default.leftMenuNavigationController = sideMenu
                SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        myScrollView.contentSize.width = 834
        myScrollView.contentSize.height = 4000
        
        //        btn1.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        //        btn1.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        //        btn2.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        //        btn2.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        //        btn3.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        //        btn3.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        //        btn4.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        //        btn4.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        //        btnMale.isSelected = true
        
        q1Btns = [btn1, btn2, btn3, btn4]
        q2Btns = [btn5, btn6, btn7, btn8]
        q3Btns = [btn9, btn10, btn11, btn12]
        q4Btns = [btn13, btn14, btn15, btn16]
        q5Btns = [btn17, btn18, btn19, btn20]
        
        allBtns = [q1Btns, q2Btns, q3Btns, q4Btns, q5Btns]
        ansArr = [ans1, ans2, ans3, ans4, ans5]
        
        reset()
        setOptionAndAns()
        
        showQuestion()
        
        
    }
    
    
    

    //判斷被選擇的選項在哪一題，並將該選項設為選取狀態
    @IBAction func btnSelectAns(_ sender: UIButton) {
        if q1Btns.contains(sender) {
            whichQ = q1Btns
        } else if q2Btns.contains(sender){
            whichQ = q2Btns
        } else if q3Btns.contains(sender){
            whichQ = q3Btns
        } else if q4Btns.contains(sender){
            whichQ = q4Btns
        } else {
            whichQ = q5Btns
        }
        
        guard let questionButtons = whichQ else { return }
        
        for btn in questionButtons {
            if sender == btn {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
        }
        
        changeSelectStyle()
    }
        

    //被選擇的選項改變樣式
    func changeSelectStyle(){
        
        guard let questionButtons = whichQ else { return }

        for btn in questionButtons{
            btn.setTitleColor(color_unselected, for: .normal)
            btn.setTitleColor(color_selected, for: .selected)

            if btn.isSelected {
                btn.layer.borderColor = color_selected.cgColor
                btn.layer.borderWidth = 2
                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: (btn.titleLabel?.font.pointSize)!)
                
                
            } else {
                btn.layer.borderColor = color_unselected.cgColor
                btn.layer.borderWidth = 1
                btn.titleLabel?.font = UIFont.systemFont(ofSize: (btn.titleLabel?.font.pointSize)!)
            }
        }

    }
    
    
    
    @IBAction func sentAnswers(_ sender: UIButton) {
        
        isAllFinish()
        
        if isFinsih == false {
           let controller = UIAlertController(title: "還有題目尚未作答", message: "!!!!!", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "返回", style: .default, handler: nil)
           controller.addAction(okAction)
           present(controller, animated: true)
            
        }else{
            /*
            checkAns(questionOrder[0], q1Btns)
            checkAns(questionOrder[1], q2Btns)
            checkAns(questionOrder[2], q3Btns)
            checkAns(questionOrder[3], q4Btns)
            checkAns(questionOrder[4], q5Btns)*/
            
            for i in 0..<allBtns.count
            {
                checkAns(questionOrder[i], allBtns[i])
                if let ans = questAndAns[questionOrder[i]]
                {
                    ansArr[i].text = "﻿﻿答案﻿: \(ans)"
                }
            }
            
            
            
            if correctAnsNum == 5
            {
                starNum = 3
                
                var type : Int = 0
                
                switch(sort){
                case "insertionsort":
                    type = 0
                case "countingsort":
                    type = 1
                case "quicksort":
                    type = 2
                case "mergesort":
                    type = 3
                default:
                     break
                }
                
                
                let dataProcess = DataProcess()
                let currentUID = Auth.auth().currentUser?.uid
                dataProcess.updatePracticePass(UID: currentUID!, sortType: type)
                
            }
            else if correctAnsNum >= 3
            {
                starNum = 2
            }
            else if correctAnsNum >= 1
            {
                starNum = 1
            }
            else
            {
                starNum = 0
            }
                        
//            let customAlertVC = CustomAlertViewController()
//            customAlertVC.correctAnsNum = correctAnsNum
//            customAlertVC.starNum = starNum
//            customAlertVC.modalPresentationStyle = .overCurrentContext
//            customAlertVC.modalTransitionStyle = .crossDissolve
//            self.present(customAlertVC, animated: true, completion: nil)
            let controller = UIAlertController(title: "答對"+String(correctAnsNum)+"題", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回查看題目", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true)
            
            correctAnsNum = 0
            
            ans1.isHidden = false
            ans2.isHidden = false
            ans3.isHidden = false
            ans4.isHidden = false
            ans5.isHidden = false
            sentAnsButton.isEnabled = false
            
//            for qBtn in allBtns{
//                for btn in qBtn{
//                    btn.isEnabled = false
//                    btn.setTitleColor(color_selected, for: .disabled)
//                }
//            }
            
        }
        

        
        
    }

    
    func reset(){
        for qBtn in allBtns{
            for btn in qBtn{
                btn.isSelected = false
            }
        }
        
        ans1.isHidden = true
        ans2.isHidden = true
        ans3.isHidden = true
        ans4.isHidden = true
        ans5.isHidden = true
        sentAnsButton.isEnabled = true
        
    }
    
    
    func isAllFinish(){
        var isQ1Finish = false
        var isQ2Finish = false
        var isQ3Finish = false
        var isQ4Finish = false
        var isQ5Finish = false
        
        for btn in q1Btns{
            if btn.isSelected == true{
                isQ1Finish = true
            }
        }
        for btn in q2Btns{
            if btn.isSelected == true{
                isQ2Finish = true
            }
        }
        for btn in q3Btns{
            if btn.isSelected == true{
                isQ3Finish = true
            }
        }
        for btn in q4Btns{
            if btn.isSelected == true{
                isQ4Finish = true
            }
        }
        for btn in q5Btns{
            if btn.isSelected == true{
                isQ5Finish = true
            }
        }
        
        if isQ1Finish && isQ2Finish && isQ3Finish && isQ4Finish && isQ5Finish {
            isFinsih = true
        }
        
    }
    
    func showQuestion()
    {
        //var questionOrder = [Int]()
        
        while questionOrder.count < 5
        {
            let randomNumber = Int(arc4random_uniform(5)) + 1//1~5
            if !questionOrder.contains(randomNumber) {
                questionOrder.append(randomNumber)
            }
        }
        
        question(questionOrder[0], q1)
        showOption(questionOrder[0], q1Btns)
        question(questionOrder[1], q2)
        showOption(questionOrder[1], q2Btns)
        question(questionOrder[2], q3)
        showOption(questionOrder[2], q3Btns)
        question(questionOrder[3], q4)
        showOption(questionOrder[3], q4Btns)
        question(questionOrder[4], q5)
        showOption(questionOrder[4], q5Btns)
        
    }
    
    
    
    func showOption(_ num1: Int, _ buttonArr: Array<UIButton>)
    {
        /*
        var qtOpt1:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
        var qtOpt2:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
        var qtOpt3:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
        var qtOpt4:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
        var qtOpt5:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]*/
        
        var option = [Int]()
        
        while option.count < 4
        {
            let randomNumber = Int(arc4random_uniform(4))//0~3
            if !option.contains(randomNumber) {
                option.append(randomNumber)
            }
        }
        
        
        switch num1
        {
        case 1:
            for i in 0..<buttonArr.count
            {
                buttonArr[i].setTitle(qtOpt1[option[i]], for: .normal)
            }
        case 2:
            for i in 0..<buttonArr.count
            {
                buttonArr[i].setTitle(qtOpt2[option[i]], for: .normal)
            }
        case 3:
            for i in 0..<buttonArr.count
            {
                buttonArr[i].setTitle(qtOpt3[option[i]], for: .normal)
            }
        case 4:
            for i in 0..<buttonArr.count
            {
                buttonArr[i].setTitle(qtOpt4[option[i]], for: .normal)
            }
        case 5:
            for i in 0..<buttonArr.count
            {
                buttonArr[i].setTitle(qtOpt5[option[i]], for: .normal)
            }
        default:
            for i in 0..<buttonArr.count
            {
                buttonArr[i].setTitle("﻿沒有", for: .normal)
            }
        }
        
    }
    
    func checkAns(_ num: Int, _ buttonArr: Array<UIButton>)
    {
        for btn in buttonArr
        {
            if btn.isSelected == true
            {
                if btn.currentTitle == questAndAns[num]
                {
                    correctAnsNum += 1
                    
                }else{
                    
                }
            }
        }
    }
    
    
    func question(_ num1: Int, _ textLabel: UILabel){
        
        switch(sort){
        case "insertionsort":
            switch num1
            {
            case 1:
                textLabel.text = "﻿在一次迭代中，插入排序最多交換幾次元素？"
            case 2:
                textLabel.text = "﻿在插入排序中，哪一步驟會進行元素的比較？"
            case 3:
                textLabel.text = "﻿在插入排序過程中，哪部分的數列始終保持排序？"
            case 4:
                textLabel.text = "﻿在插入排序的每一步中，將一個元素插入到已排序部分時，它與已排序部分的哪個元素進行比較？"
            case 5:
                textLabel.text = "﻿插入排序中的哪一步可能導致算法的不穩定？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "countingsort":
            switch num1
            {
            case 1:
                textLabel.text = "﻿在計數排序中，哪個陣列用於存儲每個元素的出現次數？"
            case 2:
                textLabel.text = "﻿如果要對一組負整數進行排序，是否仍然可以使用計數排序？"
            case 3:
                textLabel.text = "﻿在計數排序中，輔助陣列的大小取決於什麼？"
            case 4:
                textLabel.text = "﻿計數排序中，當所有數據都相同時，輔助陣列的大小是多少？"
            case 5:
                textLabel.text = "﻿在計數排序中，對於給定的輸入序列，哪個陣列可以幫助我們確定每個數字的位置？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "quicksort":
            switch num1
            {
            case 1:
                textLabel.text = "﻿在快速排序中，元素比基準元素小的會被放在哪一側？"
            case 2:
                textLabel.text = "﻿對於快速排序，如果所有元素都相等，是否需要執行任何交換操作？"
            case 3:
                textLabel.text = "﻿在快速排序中，基準元素的作用是什麼？"
            case 4:
                textLabel.text = "﻿快速排序通常是通過遞迴實現的。在每一次遞迴中，它對哪一部分數據進行排序？"
            case 5:
                textLabel.text = "﻿當我們選擇一個非常不幸的基準時，什麼可能發生？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "mergesort":
            switch num1
            {
            case 1:
                textLabel.text = "﻿一個數列的大小為8。在完整的合併排序中，約有多少次的「合併」操作？"
            case 2:
                textLabel.text = "﻿合併排序適用於哪種數據類型？"
            case 3:
                textLabel.text = "﻿在合併排序中，將陣列分成多少個子陣列？"
            case 4:
                textLabel.text = "﻿在合併排序中，分割陣列的過程是如何完成的？"
            case 5:
                textLabel.text = "﻿在合併排序中，當兩個有序子列表合併時，如何確保它們仍然保持有序？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        default:
            break
        }
        
    }
    
    
    func setOptionAndAns(){
        switch(sort){
        case "insertionsort":
            qtOpt1 = ["﻿0次", "﻿1次", "﻿n次", "﻿n-1次"]
            qtOpt2 = ["﻿選擇下一個元素", "﻿將元素插入正確的位置", "﻿交換兩個元素的位置", "﻿確定數列已排序"]
            qtOpt3 = ["﻿左側", "﻿右側", "﻿中間", "﻿數列的任意部分"]
            qtOpt4 = ["﻿第一個元素", "﻿最後一個元素", "﻿所有已排序元素", "﻿中間的元素"]
            qtOpt5 = ["﻿比較", "﻿移動", "﻿插入", "﻿插入排序是穩定的"]
            questAndAns = [1:"﻿n-1次", 2:"﻿將元素插入正確的位置", 3:"﻿左側", 4:"﻿所有已排序元素", 5:"﻿插入排序是穩定的"]
        case "countingsort":
            qtOpt1 = ["﻿輸入陣列", "﻿輸出陣列", "﻿計數陣列", "﻿中間陣列"]
            qtOpt2 = ["﻿可以，但需要進行一些調整", "﻿可以，直接使用即可", "﻿不可以，計數排序不支持負數", "﻿只有在負數範圍較小時可以使用"]
            qtOpt3 = ["﻿數據的個數", "﻿數據的範圍", "﻿數據的平均值", "﻿數據的中位數"]
            qtOpt4 = ["﻿0", "﻿1", "﻿n", "﻿n-1"]
            qtOpt5 = ["﻿計數陣列", "﻿輸入陣列", "﻿輸出陣列", "﻿中間陣列"]
            questAndAns = [1:"﻿計數陣列", 2:"﻿可以，但需要進行一些調整", 3:"﻿數據的範圍", 4:"﻿1", 5:"﻿計數陣列"]
        case "quicksort":
            qtOpt1 = ["﻿左側", "﻿右側", "﻿這是不確定的", "﻿這是隨機的"]
            qtOpt2 = ["﻿是，必須進行多次交換", "﻿否，不需要進行任何交換", "﻿只需要一次交換", "﻿取決於基準值的選擇"]
            qtOpt3 = ["﻿用來交換的元素", "﻿用來比較的元素", "﻿最大的元素", "﻿最小的元素"]
            qtOpt4 = ["﻿整個數組", "﻿左半部分", "﻿右半部分", "﻿隨機部分"]
            qtOpt5 = ["﻿排序立即完成", "﻿分割非常均衡", "﻿分割非常不均衡", "﻿所有元素都移至基準的左側"]
            questAndAns = [1:"﻿左側", 2:"﻿否，不需要進行任何交換", 3:"﻿用來比較的元素", 4:"﻿左半部分", 5:"﻿分割非常不均衡"]
        case "mergesort":
            qtOpt1 = ["﻿3", "﻿4", "﻿7", "﻿8"]
            qtOpt2 = ["﻿整數和浮點數", "﻿字串和字符", "﻿任何可比較的數據類型", "﻿僅限整數"]
            qtOpt3 = ["﻿1", "﻿2", "﻿3", "﻿可變數量"]
            qtOpt4 = ["﻿隨機選擇一個元素進行分割", "﻿將陣列一分為二", "﻿比較相鄰元素並進行分割", "﻿根據元素值的大小進行分割"]
            qtOpt5 = ["﻿隨機排列元素", "﻿使用插入排序算法", "﻿通過比較元素來合併它們", "﻿無法保證有序性"]
            questAndAns = [1:"﻿7", 2:"﻿任何可比較的數據類型", 3:"﻿2", 4:"﻿將陣列一分為二", 5:"﻿通過比較元素來合併它們"]
        default:
            break
        }
    }

    func didSelectMenuItem(named: String) {
           sideMenu?.dismiss(animated: true, completion: { [weak self] in
               if named == "模擬" {
                   self?.goToDstSortv()
               }
               else if named == "練習" {
               }
               else if named == "相關程式碼" {
                   let searchCodeVc = self?.storyboard?.instantiateViewController(withIdentifier: "SearchCodeViewController") as! SearchCodeViewController
                   self?.navigationController?.pushViewController(searchCodeVc, animated: true)
                   searchCodeVc.searchCodeSort = self?.sort
               }
               else if named == "相關影片" {
                   let searchVideoVc = self?.storyboard?.instantiateViewController(withIdentifier: "SearchVideoViewController") as! SearchVideoViewController
                   self?.navigationController?.pushViewController(searchVideoVc, animated: true)
                   searchVideoVc.searchVideoSort = self?.sort
               }
               else if named == "回到排序選擇畫面" {
                   self?.navigationController?.popToRootViewController(animated: true)
               }
           })
       }
       
       func goToDstSortv() {
           //let dstSort
           
           switch(sort){
           case "insertionsort":
               let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "InsertionSortSimulation") as! InsertionSortSimulation
               self.navigationController?.pushViewController(dstSortVc, animated: true)
               dstSortVc.sort = sort
               
           case "countingsort":
               let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "CountingSortSimulation") as! CountingSortSimulation
               self.navigationController?.pushViewController(dstSortVc, animated: true)
               dstSortVc.sort = sort
               
           case "quicksort":
               let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "QuickSortSimulation") as! QuickSortSimulation
               self.navigationController?.pushViewController(dstSortVc, animated: true)
               dstSortVc.sort = sort
               
           case "mergesort":
               let dstSortVc = self.storyboard?.instantiateViewController(withIdentifier: "MergeSortSimulation") as! MergeSortSimulation
               self.navigationController?.pushViewController(dstSortVc, animated: true)
               dstSortVc.sort = sort
               
           default:
               break
           }
           
           
       }
    
}


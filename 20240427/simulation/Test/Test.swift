//
//  Test1.swift
//  simulation
//
//  Created by WanHsuan on 2023/9/5.
//

import UIKit
import FirebaseAuth


class Test: UIViewController {
    
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
    
    @IBOutlet var backButton: UIButton! {
        didSet {
            backButton.layer.cornerRadius = backButton.bounds.width/2
        }
    }
    
    
    var allBtns: [[UIButton]] = []
    
    var whichQ: [UIButton]?
    var isFinsih = false
    
    var correctAnsNum = 0
    var starNum = 0
    var lastTimeStarNum = 0
    
    
    var t1Star = 0
    var t2Star = 0
    var t3Star = 0
    var t4Star = 0
    var t5Star = 0
    
    var t1LastTimeStarNum = 0
    var t2LastTimeStarNum = 0
    var t3LastTimeStarNum = 0
    var t4LastTimeStarNum = 0
    var t5LastTimeStarNum = 0
    
    var questionOrder = [Int]()
    var qtOpt1:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt2:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt3:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt4:[String] = ["﻿一", "﻿二", "﻿三", "﻿四"]
    var qtOpt5:[String] = ["﻿﻿一", "﻿﻿二", "﻿﻿三", "﻿﻿﻿﻿四"]
    
    var questAndAns:[Int:String] = [1:"﻿一", 2:"﻿二", 3:"﻿三", 4:"﻿四", 5:"﻿四"]
    
    var previousVC: TestMenu?
    var test: String?
    
    
    var color_unselected = UIColor(rgb: 0x8E8E93) //按鈕原色
    var color_selected = UIColor(rgb: 0x3891d1) //被選中的按鈕顏色
    
    
    @IBAction func backToTestMenu(_ sender: UIButton){ 
        sentDataBack()
        self.dismiss(animated: true,completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    func sentDataBack(){
        if previousVC != nil {
//            previousVC!.test1Star.text = String(starNum)
            showMenuStar()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            whichTestStar()
                        
            let customAlertVC = CustomAlertViewController()
            customAlertVC.correctAnsNum = correctAnsNum
            customAlertVC.starNum = starNum
            customAlertVC.modalPresentationStyle = .overCurrentContext
            customAlertVC.modalTransitionStyle = .crossDissolve
            self.present(customAlertVC, animated: true, completion: nil)
            
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
    
    func showMenuStar(){
        switch(test){
        case "test1":
            if t1Star > t1LastTimeStarNum{
                if t1Star == 0{
                    previousVC!.test1Star.text = "☆☆☆"
                }else if t1Star == 1{
                    previousVC!.test1Star.text = "★☆☆"
                }else if t1Star == 2{
                    previousVC!.test1Star.text = "★★☆"
                }else if t1Star == 3{
                    previousVC!.test1Star.text = "★★★"
                }else{
                    previousVC!.test1Star.text = ""
                }
            }else{
                
            }
        case "test2":
            if t2Star > t2LastTimeStarNum{
                if t2Star == 0{
                    previousVC!.test2Star.text = "☆☆☆"
                }else if t2Star == 1{
                    previousVC!.test2Star.text = "★☆☆"
                }else if t2Star == 2{
                    previousVC!.test2Star.text = "★★☆"
                }else if t2Star == 3{
                    previousVC!.test2Star.text = "★★★"
                }else{
                    previousVC!.test2Star.text = ""
                }
            }else{
                
            }
        case "test3":
            if t3Star > t3LastTimeStarNum{
                if t3Star == 0{
                    previousVC!.test3Star.text = "☆☆☆"
                }else if t3Star == 1{
                    previousVC!.test3Star.text = "★☆☆"
                }else if t3Star == 2{
                    previousVC!.test3Star.text = "★★☆"
                }else if t3Star == 3{
                    previousVC!.test3Star.text = "★★★"
                }else{
                    previousVC!.test3Star.text = ""
                }
            }else{
                
            }
        case "test4":
            if t4Star > t4LastTimeStarNum{
                if t4Star == 0{
                    previousVC!.test4Star.text = "☆☆☆"
                }else if t4Star == 1{
                    previousVC!.test4Star.text = "★☆☆"
                }else if t4Star == 2{
                    previousVC!.test4Star.text = "★★☆"
                }else if t4Star == 3{
                    previousVC!.test4Star.text = "★★★"
                }else{
                    previousVC!.test4Star.text = ""
                }
            }else{
                
            }
        case "test5":
            if t5Star > t5LastTimeStarNum{
                if t5Star == 0{
                    previousVC!.test5Star.text = "☆☆☆"
                }else if t5Star == 1{
                    previousVC!.test5Star.text = "★☆☆"
                }else if t5Star == 2{
                    previousVC!.test5Star.text = "★★☆"
                }else if t5Star == 3{
                    previousVC!.test5Star.text = "★★★"
                }else{
                    previousVC!.test5Star.text = ""
                }
            }else{
                
            }
        default:
            break
        }
    }
    
    func question(_ num1: Int, _ textLabel: UILabel) //改
    {
        switch(test){
        case "test1":
            switch num1
            {
            case 1:
                textLabel.text = "﻿哪種排序算法的主要思想是將數據分成小的子數組，然後對每個子數組進行排序，最後將它們合併成一個整體有序數組？"
            case 2:
                textLabel.text = "﻿哪種排序算法的分割過程可以通過多種方式實現，例如選擇第一個元素、最後一個元素或隨機元素作為基準值？"
            case 3:
                textLabel.text = "﻿合併排序是否是穩定的排序算法？"
            case 4:
                textLabel.text = "﻿在計數排序中，輔助陣列的大小取決於什麼？"
            case 5:
                textLabel.text = "﻿在﻿插入﻿排序﻿的﻿過程中﻿，﻿哪﻿﻿側﻿的﻿﻿序列﻿始終﻿保持﻿排序？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "test2":
            switch num1
            {
            case 1:
                textLabel.text = "﻿哪種排序算法的分割過程，通常是基於選擇一個基準值來執行的？"
            case 2:
                textLabel.text = "﻿哪種排序算法可以用於對整數數據進行非比較排序，但不適用於具有負數的數據集？"
            case 3:
                textLabel.text = "﻿一個數列的大小為16。在完整的合併排序中，約有多少次的「合併」操作？"
            case 4:
                textLabel.text = "﻿插入排序是穩定排序算法還是不穩定排序算法？"
            case 5:
                textLabel.text = "﻿合併排序適用於哪種數據類型？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "test3":
            switch num1
            {
            case 1:
                textLabel.text = "﻿哪種排序算法不需比較元素，因此在某些情況下速度非常快？"
            case 2:
                textLabel.text = "﻿哪種排序算法的核心思想是通過比較和交換元素來實現排序？"
            case 3:
                textLabel.text = "﻿在一次迭代中，插入排序最多交換幾次元素？"
            case 4:
                textLabel.text = "﻿在計數排序中，哪個陣列用於存儲每個元素的出現次數？"
            case 5:
                textLabel.text = "﻿一個數列的大小為20。在完整的合併排序中，約有多少次的「合併」操作？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "test4":
            switch num1
            {
            case 1:
                textLabel.text = "﻿哪種排序算法的核心思想是計算每個元素之前有多少個元素比它小？"
            case 2:
                textLabel.text = "﻿哪種排序法選一個元素作基準，將所有小於基準的元素放在左邊，所有大於基準的元素放在右邊，獨立對兩側的數組排序？"
            case 3:
                textLabel.text = "﻿一個數列的大小為10。在完整的合併排序中，約有多少次的「合併」操作？"
            case 4:
                textLabel.text = "﻿在快速排序中，元素比基準元素小的會被放在哪一側？"
            case 5:
                textLabel.text = "﻿在插入排序中，哪一步驟會進行元素的比較？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        case "test5":
            switch num1
            {
            case 1:
                textLabel.text = "﻿哪種排序算法的核心思想是不斷將最小的元素移到已排序部分的末尾？"
            case 2:
                textLabel.text = "﻿哪種排序算法適用於小範圍的整數排序，並且它的效率與數據分布獨立，因為它不進行比較操作？"
            case 3:
                textLabel.text = "﻿在合併排序中，當兩個有序子列表合併時，如何確保它們仍然保持有序？"
            case 4:
                textLabel.text = "﻿在計數排序中，所有數據都相同時，輔助陣列的大小是多少？"
            case 5:
                textLabel.text = "﻿在快速排序中，基準元素的作用是什麼？"
            default:
                textLabel.text = "﻿﻿沒有"
            }
        default:
            break
        }
        
    }
    
    func whichTestStar(){
        let dataProcess = DataProcess()
        let currentUID = Auth.auth().currentUser?.uid
        print(currentUID)
        
        switch(test){
        case "test1":
            t1Star = starNum
            dataProcess.updateStar(UID: currentUID!, stage: 0, stars: starNum)
        case "test2":
            t2Star = starNum
            dataProcess.updateStar(UID: currentUID!, stage: 1, stars: starNum)
        case "test3":
            t3Star = starNum
            dataProcess.updateStar(UID: currentUID!, stage: 2, stars: starNum)
        case "test4":
            t4Star = starNum
            dataProcess.updateStar(UID: currentUID!, stage: 3, stars: starNum)
        case "test5":
            t5Star = starNum
            dataProcess.updateStar(UID: currentUID!, stage: 4, stars: starNum)
        default:
            break
        }
    }
    
    func setOptionAndAns(){ //改
        switch(test){
        case "test1":
            qtOpt1 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt2 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt3 = ["﻿是", "﻿否", "﻿取決於實現方式", "﻿取決於輸入數列"]
            qtOpt4 = ["﻿數據的個數", "﻿數據的範圍", "﻿數據的平均值", "﻿數據的中位數"]
            qtOpt5 = ["﻿﻿左側", "﻿﻿右側", "﻿﻿中間", "﻿﻿﻿﻿數列﻿的任意﻿部分"]
            questAndAns = [1:"﻿合併排序", 2:"﻿快速排序", 3:"﻿是", 4:"﻿數據的範圍", 5:"﻿左側"]
        case "test2":
            qtOpt1 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt2 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt3 = ["﻿8", "﻿15", "﻿16", "﻿20"]
            qtOpt4 = ["﻿穩定", "﻿不穩定", "﻿既穩定又不穩定", "﻿取決於輸入數據"]
            qtOpt5 = ["﻿整數和浮點數", "﻿字串和字符", "﻿任何可比較的數據類型", "﻿僅限整數"]
            questAndAns = [1:"﻿快速排序", 2:"﻿計數排序", 3:"﻿15", 4:"﻿穩定", 5:"﻿任何可比較的數據類型"]
        case "test3":
            qtOpt1 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt2 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt3 = ["﻿0次", "﻿1次", "﻿n次", "﻿n-1次"]
            qtOpt4 = ["﻿輸入陣列", "﻿輸出陣列", "﻿計數陣列", "﻿中間陣列"]
            qtOpt5 = ["﻿5", "﻿10", "﻿19", "﻿20"]
            questAndAns = [1:"﻿計數排序", 2:"﻿快速排序", 3:"﻿n-1次", 4:"﻿計數陣列", 5:"﻿19"]
        case "test4":
            qtOpt1 = ["﻿合併排序", "﻿計數排序", "﻿快速排序", "﻿插入排序"]
            qtOpt2 = ["﻿合併排序", "﻿計數排序", "﻿快速排序", "﻿插入排序"]
            qtOpt3 = ["﻿5", "﻿9", "﻿10", "﻿15"]
            qtOpt4 = ["﻿左側", "﻿右側", "﻿這是不確定的", "﻿這是隨機的"]
            qtOpt5 = ["﻿選擇下一個元素", "﻿將元素插入正確的位置", "﻿交換兩個元素的位置", "﻿確定數列已排序"]
            questAndAns = [1:"﻿計數排序", 2:"﻿快速排序", 3:"﻿9", 4:"﻿左側", 5:"﻿將元素插入正確的位置"]
        case "test5":
            qtOpt1 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt2 = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
            qtOpt3 = ["﻿隨機排列元素", "﻿使用插入排序算法", "﻿通過比較元素來合併它們", "﻿無法保證有序性"]
            qtOpt4 = ["﻿0", "﻿1", "﻿n", "﻿n-1"]
            qtOpt5 = ["﻿用來交換的元素", "﻿用來比較的元素", "﻿最大的元素", "﻿最小的元素"]
            questAndAns = [1:"﻿插入排序", 2:"﻿計數排序", 3:"﻿通過比較元素來合併它們", 4:"﻿1", 5:"﻿用來比較的元素"]
        default:
            break
        }
    }

    


    
    
}

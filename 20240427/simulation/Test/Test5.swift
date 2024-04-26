//
//  Test5.swift
//  simulation
//
//  Created by WanHsuan on 2023/9/19.
//

import UIKit

class Test5: UIViewController {
    
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
    
    var allBtns: [[UIButton]] = []
    
    var whichQ: [UIButton]?
    var isFinsih = false
    
    var correctAnsNum = 0
    var starNum = 0
    var lastTimeStarNum = 0
    
    var questionOrder = [Int]()
    var qtOpt1:[String] = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
    var qtOpt2:[String] = ["﻿插入排序", "﻿合併排序", "﻿計數排序", "﻿快速排序"]
    var qtOpt3:[String] = ["﻿隨機排列元素", "﻿使用插入排序算法", "﻿通過比較元素來合併它們", "﻿無法保證有序性"]
    var qtOpt4:[String] = ["﻿0", "﻿1", "﻿n", "﻿n-1"]
    var qtOpt5:[String] = ["﻿用來交換的元素", "﻿用來比較的元素", "﻿最大的元素", "﻿最小的元素"]
    
    var questAndAns:[Int:String] = [1:"﻿插入排序", 2:"﻿計數排序", 3:"﻿通過比較元素來合併它們", 4:"﻿1", 5:"﻿用來比較的元素"]
    
    var previousVC: TestMenu?
    
    var color_unselected = UIColor(rgb: 0x8E8E93) //按鈕原色
    var color_selected = UIColor(rgb: 0x0077ff) //被選中的按鈕顏色
    
    @IBAction func backToTestMenu(_ sender: UIButton){
        sentDataBack()
        self.dismiss(animated: true,completion: nil)
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
    
    func question(_ num1: Int, _ textLabel: UILabel)
    {
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
        if starNum > lastTimeStarNum{
            if starNum == 0{
                previousVC!.test5Star.text = "☆☆☆"
            }else if starNum == 1{
                previousVC!.test5Star.text = "★☆☆"
            }else if starNum == 2{
                previousVC!.test5Star.text = "★★☆"
            }else if starNum == 3{
                previousVC!.test5Star.text = "★★★"
            }else{
                previousVC!.test5Star.text = ""
            }
        }else{
            
        }
    }
}

//
//  CountingSortSourceCode.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/4.
//

//import Foundation
import UIKit

class CountingSortSourceCode: UIViewController {
    
//    let CountingSortSim = CountingSortSimulation()
    
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!

    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    
    var previousVC: CountingSortSimulation?
    var arr = [Int]()
    var changeArr = [Int]() //?
    var currentStep = 1
    var everyStep = [Int: Array<Int>]()
    var totalStep = 1
    var maxValue = 0
    
    var color_bg_highlighter = UIColor(rgb: 0xf5f36c) //螢光筆顏色(底)
    var color_text_highlighter = UIColor(rgb: 0xe31212)
    var color_array_bg = UIColor(rgb: 0xffffff) //陣列底色
    var color_array_text = UIColor(rgb: 0x2B2D42) //陣列數字顏色
    
    @IBOutlet var button1: UIButton! {
        didSet {
            button1.layer.cornerRadius = button1.bounds.width/2
        }
    }
    @IBOutlet var button2: UIButton! {
        didSet {
            button2.layer.cornerRadius = button2.bounds.width/2
        }
    }
    
    @IBOutlet var buttonRandom: UIButton! {
        didSet {
            buttonRandom.layer.cornerRadius = 7
        }
    }
    @IBOutlet var buttonReset: UIButton! {
        didSet {
            buttonReset.layer.cornerRadius = 7
            
        }
    }
    
    @IBOutlet var buttonTurnPage: UIButton! {
        didSet {
            buttonTurnPage.layer.cornerRadius = 7
        }
    }
    
    

    
    @IBAction func turnToCountingSort(_ sender: UIButton) {
        sentDataBack()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToSortＭenu(_ sender: UIButton) {
        performSegue(withIdentifier: "toSortMenu", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if previousVC!.everyStep.isEmpty {
            stepNum.text = "/"
            nextStep.isEnabled = false
            preStep.isEnabled = false

        } else {
            // 傳值
            showArr()
            changeBG(everyStep[currentStep]!)
            changeLabelBG(everyStep[currentStep]!)
            stepNum.text = "\(currentStep) / \(everyStep.count)"

            if(currentStep >= everyStep.count)
            {
                nextStep.isEnabled = false
            }else{
                nextStep.isEnabled = true
            }
            if(currentStep <= 1)
            {
                preStep.isEnabled = false
            }else{
                preStep.isEnabled = true
            }
        }
    }
    
    func sentDataBack() {
        if previousVC != nil {
            previousVC!.currentStep = currentStep
            previousVC!.everyStep = everyStep
            checkButton()
            previousVC!.totalStep = totalStep
            if everyStep.isEmpty {
                turnBackClear()
                previousVC!.nextStep.isEnabled = false
                previousVC!.preStep.isEnabled = false

            } else {
                previousVC!.everyStep = everyStep
                previousVC!.arr = arr
                previousVC!.changeArr = changeArr
                turnBackShowArr()
//                turnBackChange()
                turnBackChangeBArr(everyStep[currentStep]!)
                turnBackChangeCountArr(everyStep[currentStep]!)
                turnBackChangeBG(everyStep[currentStep]!)
                turnBackChangeCountingBG(everyStep[currentStep]!)
                turnBackChangeBTextColor(everyStep[currentStep]!)
                turnBackChangeCountingTextColor(everyStep[currentStep]!)
                turnBackIntroduceStep(everyStep[currentStep]!)
//                turnBackChangeBG(everyStep[currentStep]!)
//                turnBackChangeTextColor(everyStep[currentStep]!)
//                turnBackIntroduceStep(everyStep[currentStep]!)
//                turnBackShowIJKey(everyStep[currentStep]!)
                previousVC!.stepNum.text = "\(currentStep) / \(everyStep.count)"

                if(currentStep >= everyStep.count)
                {
                    previousVC!.nextStep.isEnabled = false
                }else{
                    previousVC!.nextStep.isEnabled = true
                }
                if(currentStep <= 1)
                {
                    previousVC!.preStep.isEnabled = false
                }else{
                    previousVC!.preStep.isEnabled = true
                }
                if(currentStep == 1)
                {
//                    previousVC!.iLabel.text = "j = "
//                    previousVC!.jLabel.text = "i = "
//                    previousVC!.keyLabel.text = "key = "
                    previousVC!.countText1.text = ""
                    previousVC!.countText2.text = ""
                    previousVC!.countText3.text = ""
                    previousVC!.countText4.text = ""
                    previousVC!.countText5.text = ""
                    previousVC!.countText6.text = ""
                    previousVC!.countText7.text = ""
                    previousVC!.countText8.text = ""
                    previousVC!.countText9.text = ""
//                    previousVC!.countText10.text = ""

                }
                if(currentStep < 37)
                {
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
            }


        }
    }

    func checkButton() {
        if(currentStep >= everyStep.count)
        {
            previousVC!.nextStep.isEnabled = false
        }
        if(currentStep <= 1)
        {
            previousVC!.preStep.isEnabled = false
        }
    }

    @IBAction func showNumber(sender: UIButton)
    {
        arr.removeAll()
        while arr.count < 7 {
            let randomNumber = Int(arc4random_uniform(9)) + 1//1~9
            arr.append(randomNumber)
            /*
             if !arr.contains(randomNumber) {
             arr.append(randomNumber)
             }*/
        }
        reset()
        showArr()
        countingToFinal()
        maxValue = getMaxValue(arr)
        show_B_CArrLength(maxValue)
        
        nextStep.isEnabled = true
        stepNum.text = "\(currentStep) / \(everyStep.count)"
    }
    
    @IBAction func clearText(sender: UIButton)
    {
        text1.text = ""
        text2.text = ""
        text3.text = ""
        text4.text = ""
        text5.text = ""
        text6.text = ""
        text7.text = ""
        reset()
        
    }
    
    func reset()
    {
        preStep.isEnabled = false
        nextStep.isEnabled = false
        
        show_B_CArrLength(-1)
        totalStep = 1
        everyStep.removeAll()
        currentStep = 1
        
        stepNum.text = "/"
        
        text1.backgroundColor = color_array_bg
        text2.backgroundColor = color_array_bg
        text3.backgroundColor = color_array_bg
        text4.backgroundColor = color_array_bg
        text5.backgroundColor = color_array_bg
        text6.backgroundColor = color_array_bg
        text7.backgroundColor = color_array_bg
        
        text1.textColor = color_array_text
        text2.textColor = color_array_text
        text3.textColor = color_array_text
        text4.textColor = color_array_text
        text5.textColor = color_array_text
        text6.textColor = color_array_text
        text7.textColor = color_array_text
        
        label1.backgroundColor = UIColor.white
        label2.backgroundColor = UIColor.white
        label3.backgroundColor = UIColor.white
        label4.backgroundColor = UIColor.white
        label5.backgroundColor = UIColor.white
        label6.backgroundColor = UIColor.white
        label7.backgroundColor = UIColor.white
        label8.backgroundColor = UIColor.white
        label9.backgroundColor = UIColor.white
        
        
        
        
    }
    
    @IBAction func nextStep(sender: UIButton)
    {
        //currentLabelStep += 1
        
        currentStep += 1

        preStep.isEnabled = true
        /*
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        introduceStep(everyStep[currentStep]!)*/
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        //showIJKey(everyStep[currentStep]!)
        changeLabelBG(everyStep[currentStep]!)
        
        if currentStep < changeArr[0]
        {
            changeBG(everyStep[currentStep]!)
            
           
            //changeBucketTextColor(everyStep[currentStep]!)
            
        }
        else if currentStep < changeArr[1]
        {
            
            
            //introduceStep(everyStep[currentStep]!)
            
            //showCurrBArr(everyStep[currentStep]!)
            
        }
        else
        {
//            print(everyStep[currentStep]!.count)
//            print(everyStep[currentStep])
            

        
            changeBG(everyStep[currentStep]!)
           

            
//            if everyStep[currentStep]!.count == 7 + 5
//            {
//                
//
//            }
//            else
//            {
//                
//
//            }
            
            
        }
        
        if(currentStep >= everyStep.count)
        {
            nextStep.isEnabled = false
        }
        

    }
    @IBAction func preStep(sender: UIButton)
    {
        currentStep -= 1
        nextStep.isEnabled = true
        /*
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        introduceStep(everyStep[currentStep]!)*/
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        //showIJKey(everyStep[currentStep]!)
        changeLabelBG(everyStep[currentStep]!)
        
        if currentStep < changeArr[0]
        {
            changeBG(everyStep[currentStep]!)
            

            
        }
        else if currentStep < changeArr[1]
        {
            

            
        }
        else
        {
//            print(everyStep[currentStep]!.count)
//            print(everyStep[currentStep])
            
            
            changeBG(everyStep[currentStep]!)
            

            
        }
        
        if(currentStep <= 1)
        {
            preStep.isEnabled = false
        }


    }
    
    func addInformationTodict(_ arr: Array<Int>, _ B: Array<Int>, _ arrIndex: Int, _ countingIndex: Int, _ step: Int, _ countingBG: Int, _ bTextColor: Int)
    {
        var information = [Int](repeating: 0, count: arr.count + B.count + 5)
        
        var index = 0
        while index < arr.count
        {
            information[index] = arr[index]
            index += 1
        }
        
        for i in 0..<B.count
        {
            information[index] = B[i]
            index += 1
        }
        
        
        information[information.count - 5] = arrIndex
        information[information.count - 4] = countingIndex
        information[information.count - 3] = step
        information[information.count - 2] = countingBG
        information[information.count - 1] = bTextColor
        everyStep[totalStep] = information
        totalStep += 1
        
    }
    
    func getMaxValue(_ arr: Array<Int>) -> Int
    {
        var maxValue = arr[0];
        for value in arr
        {
            if maxValue < value
            {
                maxValue = value
            }
        }
        return maxValue
    }
    
    func countingToFinal()
    {
        var B = [Int](repeating: 0, count: 7)
        
        let maxValue = getMaxValue(arr)
        //﻿範圍﻿ 0 ~﻿ max
        var counting = [Int](repeating: 0, count: 9)// 9 是﻿因為﻿ 1 ~ 9
        //var counting = [Int](repeating: 0, count: maxValue + 1)
        addInformationTodict(counting, B, -1, -1, -1, -1, -1)//﻿初始
        addInformationTodict(counting, B, -1, -1, 0, -1, -1)//﻿﻿放0
        
        for i in 0..<arr.count
        {
            addInformationTodict(counting, B, -1, -1, 1, -1, -1)//﻿﻿比較for
            counting[arr[i] - 1] += 1
            addInformationTodict(counting, B, i, arr[i] - 1, 2, -1, -1)
            
        }
        addInformationTodict(counting, B, -1, -1, 1, -1, -1)//比較﻿﻿for﻿結束
        changeArr.append(totalStep)
        
        for i in 1..<counting.count
        {
            addInformationTodict(counting, B, -1, -1, 3, -1, -1)//﻿﻿比較for
            counting[i] += counting[i - 1]
            addInformationTodict(counting, B, -1, i, 4, -1, -1)
            //﻿﻿文字﻿變紅﻿而已
        }
        addInformationTodict(counting, B, -1, -1, 3, -1, -1)//比較﻿﻿for﻿結束
        changeArr.append(totalStep)
        
        
        var i = B.count - 1
        while i >= 0
        {
            addInformationTodict(counting, B, -1, -1, 5, -1, -1)//﻿﻿比較for
            
            B[counting[arr[i] - 1] - 1] = arr[i]
            addInformationTodict(counting, B, i, -1, 6, arr[i] - 1, counting[arr[i] - 1] - 1)

            counting[arr[i] - 1] -= 1
            addInformationTodict(counting, B, i, arr[i] - 1, 7, -1, -1)
            i -= 1
        }
        addInformationTodict(counting, B, -1, -1, 5, -1, -1)//比較﻿﻿for﻿結束
        addInformationTodict(counting, B, -1, -1, -1, -1, -1)//結束
        
    }
    
    func showArr()
    {
        text1.text = String(arr[0])
        text2.text = String(arr[1])
        text3.text = String(arr[2])
        text4.text = String(arr[3])
        text5.text = String(arr[4])
        text6.text = String(arr[5])
        text7.text = String(arr[6])
    }
    
    func changeBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 5] as! Int
        switch num1
        {
        case 0:
            text1.backgroundColor = color_bg_highlighter
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 1:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_bg_highlighter
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 2:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_bg_highlighter
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 3:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_bg_highlighter
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 4:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_bg_highlighter
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 5:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_bg_highlighter
            text7.backgroundColor = color_array_bg
        case 6:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_bg_highlighter
        default:
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        }
        
    }
    
    func changeLabelBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            label1.backgroundColor = color_bg_highlighter
            label2.backgroundColor = color_bg_highlighter
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        case 1:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = color_bg_highlighter
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        case 2:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = color_bg_highlighter
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        case 3:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = color_bg_highlighter
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        case 4:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = color_bg_highlighter
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        case 5:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = color_bg_highlighter
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        case 6:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = color_bg_highlighter
            label9.backgroundColor = UIColor.white
        case 7:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = color_bg_highlighter
        default:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
            label8.backgroundColor = UIColor.white
            label9.backgroundColor = UIColor.white
        }
    }
    
    func turnBackClear ()
    {
        previousVC!.introduce.text = ""
        previousVC!.text1.text = ""
        previousVC!.text2.text = ""
        previousVC!.text3.text = ""
        previousVC!.text4.text = ""
        previousVC!.text5.text = ""
        previousVC!.text6.text = ""
        previousVC!.text7.text = ""
        
        previousVC!.countText1.text = ""
        previousVC!.countText2.text = ""
        previousVC!.countText3.text = ""
        previousVC!.countText4.text = ""
        previousVC!.countText5.text = ""
        previousVC!.countText6.text = ""
        previousVC!.countText7.text = ""
        previousVC!.countText8.text = ""
        previousVC!.countText9.text = ""
//        previousVC!.countText10.text = ""
        previousVC!.Btext1.text = ""
        previousVC!.Btext2.text = ""
        previousVC!.Btext3.text = ""
        previousVC!.Btext4.text = ""
        previousVC!.Btext5.text = ""
        previousVC!.Btext6.text = ""
        previousVC!.Btext7.text = ""
        
//        previousVC!.iLabel.text = "j = "
//        previousVC!.jLabel.text = "i = "
//        previousVC!.keyLabel.text = "key = "
        
        previousVC!.text1.backgroundColor = color_array_bg
        previousVC!.text2.backgroundColor = color_array_bg
        previousVC!.text3.backgroundColor = color_array_bg
        previousVC!.text4.backgroundColor = color_array_bg
        previousVC!.text5.backgroundColor = color_array_bg
        previousVC!.text6.backgroundColor = color_array_bg
        previousVC!.text7.backgroundColor = color_array_bg
        
        previousVC!.text1.textColor = color_array_text
        previousVC!.text2.textColor = color_array_text
        previousVC!.text3.textColor = color_array_text
        previousVC!.text4.textColor = color_array_text
        previousVC!.text5.textColor = color_array_text
        previousVC!.text6.textColor = color_array_text
        previousVC!.text7.textColor = color_array_text
        
//        previousVC!.countStack1.isHidden = true
//        previousVC!.countStack2.isHidden = true
//        previousVC!.countStack3.isHidden = true
//        previousVC!.countStack4.isHidden = true
//        previousVC!.countStack5.isHidden = true
//        previousVC!.countStack6.isHidden = true
//        previousVC!.countStack7.isHidden = true
//        previousVC!.countStack8.isHidden = true
//        previousVC!.countStack9.isHidden = true
//
//        previousVC!.BStack.isHidden = true
        
        previousVC!.stepNum.text = "/"
    }
    
    func turnBackShowArr()
    {
        previousVC!.text1.text = String(arr[0])
        previousVC!.text2.text = String(arr[1])
        previousVC!.text3.text = String(arr[2])
        previousVC!.text4.text = String(arr[3])
        previousVC!.text5.text = String(arr[4])
        previousVC!.text6.text = String(arr[5])
        previousVC!.text7.text = String(arr[6])
    }
    
    func turnBackChangeBArr(_ arr: Array<Int>)
    {
        previousVC!.Btext1.text = "\(arr[10])"
        previousVC!.Btext2.text = "\(arr[11])"
        previousVC!.Btext3.text = "\(arr[12])"
        previousVC!.Btext4.text = "\(arr[13])"
        previousVC!.Btext5.text = "\(arr[14])"
        previousVC!.Btext6.text = "\(arr[15])"
        previousVC!.Btext7.text = "\(arr[16])"
        
        
        
    }
    
    func turnBackChangeCountArr(_ arr: Array<Int>)
    {
        previousVC!.countText1.text = "\(arr[0])"
        previousVC!.countText2.text = "\(arr[1])"
        previousVC!.countText3.text = "\(arr[2])"
        previousVC!.countText4.text = "\(arr[3])"
        previousVC!.countText5.text = "\(arr[4])"
        previousVC!.countText6.text = "\(arr[5])"
        previousVC!.countText7.text = "\(arr[6])"
        previousVC!.countText8.text = "\(arr[7])"
        previousVC!.countText9.text = "\(arr[8])"
//        previousVC!.countText10.text = "\(arr[9])"
        
    }
    
    func turnBackChangeBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 5] as! Int
        switch num1
        {
        case 0:
            previousVC!.text1.backgroundColor = color_bg_highlighter
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 1:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_bg_highlighter
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 2:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_bg_highlighter
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 3:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_bg_highlighter
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 4:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_bg_highlighter
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 5:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_bg_highlighter
            previousVC!.text7.backgroundColor = color_array_bg
        case 6:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_bg_highlighter
        default:
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        }
        
    }
    
    func turnBackChangeCountingBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 2] as! Int
        switch num1
        {
        case 0:
            previousVC!.countText1.backgroundColor = color_bg_highlighter
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 1:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_bg_highlighter
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 2:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_bg_highlighter
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 3:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_bg_highlighter
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 4:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_bg_highlighter
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 5:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_bg_highlighter
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 6:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_bg_highlighter
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 7:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_bg_highlighter
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 8:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_bg_highlighter
//            previousVC!.countText10.backgroundColor = color_array_bg
        case 9:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_bg_highlighter
        default:
            previousVC!.countText1.backgroundColor = color_array_bg
            previousVC!.countText2.backgroundColor = color_array_bg
            previousVC!.countText3.backgroundColor = color_array_bg
            previousVC!.countText4.backgroundColor = color_array_bg
            previousVC!.countText5.backgroundColor = color_array_bg
            previousVC!.countText6.backgroundColor = color_array_bg
            previousVC!.countText7.backgroundColor = color_array_bg
            previousVC!.countText8.backgroundColor = color_array_bg
            previousVC!.countText9.backgroundColor = color_array_bg
//            previousVC!.countText10.backgroundColor = color_array_bg
        }
        
    }
    
    
    func turnBackChangeBTextColor(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            previousVC!.Btext1.textColor = color_text_highlighter
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_array_text
        case 1:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_text_highlighter
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_array_text
        case 2:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_text_highlighter
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_array_text
        case 3:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_text_highlighter
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_array_text
        case 4:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_text_highlighter
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_array_text
        case 5:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_text_highlighter
            previousVC!.Btext7.textColor = color_array_text
        case 6:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_text_highlighter
        default:
            previousVC!.Btext1.textColor = color_array_text
            previousVC!.Btext2.textColor = color_array_text
            previousVC!.Btext3.textColor = color_array_text
            previousVC!.Btext4.textColor = color_array_text
            previousVC!.Btext5.textColor = color_array_text
            previousVC!.Btext6.textColor = color_array_text
            previousVC!.Btext7.textColor = color_array_text
        }
    }
    
    func turnBackChangeCountingTextColor(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 4] as! Int
        switch num1
        {
        case 0:
            previousVC!.countText1.textColor = color_text_highlighter
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 1:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_text_highlighter
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 2:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_text_highlighter
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 3:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_text_highlighter
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 4:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_text_highlighter
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 5:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_text_highlighter
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 6:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_text_highlighter
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 7:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_text_highlighter
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        case 8:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_text_highlighter
//            previousVC!.countText10.textColor = color_array_text
        case 9:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_text_highlighter
        default:
            previousVC!.countText1.textColor = color_array_text
            previousVC!.countText2.textColor = color_array_text
            previousVC!.countText3.textColor = color_array_text
            previousVC!.countText4.textColor = color_array_text
            previousVC!.countText5.textColor = color_array_text
            previousVC!.countText6.textColor = color_array_text
            previousVC!.countText7.textColor = color_array_text
            previousVC!.countText8.textColor = color_array_text
            previousVC!.countText9.textColor = color_array_text
//            previousVC!.countText10.textColor = color_array_text
        }
    }
    
    
    func turnBackIntroduceStep(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            previousVC!.introduce.text = "﻿把﻿C陣列﻿﻿﻿中的﻿﻿值全部﻿放﻿0"
        case 1:
            previousVC!.introduce.text = "﻿判斷i目前﻿是否﻿小於﻿﻿等於A﻿陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 2:
            previousVC!.introduce.text = "﻿將C[A[i]]﻿的值﻿﻿﻿加1"
        case 3:
            previousVC!.introduce.text = "﻿﻿判斷i目前﻿是否﻿小於﻿等於陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 4:
            previousVC!.introduce.text = "﻿將C﻿[﻿i]﻿與前﻿一﻿個﻿元素﻿的值﻿相加"
        case 5:
            previousVC!.introduce.text = "判斷i目前﻿是否﻿﻿大於﻿等於1，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 6:
            previousVC!.introduce.text = "﻿將﻿A﻿[i]的值給B[C[A[i]]]"
        case 7:
            previousVC!.introduce.text = "將C[A[i]]﻿的值﻿﻿﻿﻿減1"
        default:
            previousVC!.introduce.text = ""
        }
        
    }
    
    func show_B_CArrLength(_ maxValue: Int)
    {
        
        previousVC!.BStack.isHidden = false
        
        switch maxValue
        {
        case 1:
            previousVC!.countStack1.isHidden = false
        case 2:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
        case 3:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
        case 4:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
            previousVC!.countStack4.isHidden = false
        case 5:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
            previousVC!.countStack4.isHidden = false
            previousVC!.countStack5.isHidden = false
        case 6:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
            previousVC!.countStack4.isHidden = false
            previousVC!.countStack5.isHidden = false
            previousVC!.countStack6.isHidden = false
        case 7:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
            previousVC!.countStack4.isHidden = false
            previousVC!.countStack5.isHidden = false
            previousVC!.countStack6.isHidden = false
            previousVC!.countStack7.isHidden = false
        case 8:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
            previousVC!.countStack4.isHidden = false
            previousVC!.countStack5.isHidden = false
            previousVC!.countStack6.isHidden = false
            previousVC!.countStack7.isHidden = false
            previousVC!.countStack8.isHidden = false
        case 9:
            previousVC!.countStack1.isHidden = false
            previousVC!.countStack2.isHidden = false
            previousVC!.countStack3.isHidden = false
            previousVC!.countStack4.isHidden = false
            previousVC!.countStack5.isHidden = false
            previousVC!.countStack6.isHidden = false
            previousVC!.countStack7.isHidden = false
            previousVC!.countStack8.isHidden = false
            previousVC!.countStack9.isHidden = false
        default:
            previousVC!.countStack1.isHidden = true
            previousVC!.countStack2.isHidden = true
            previousVC!.countStack3.isHidden = true
            previousVC!.countStack4.isHidden = true
            previousVC!.countStack5.isHidden = true
            previousVC!.countStack6.isHidden = true
            previousVC!.countStack7.isHidden = true
            previousVC!.countStack8.isHidden = true
            previousVC!.countStack9.isHidden = true
            
            previousVC!.BStack.isHidden = true
        }
    }
    
    

}

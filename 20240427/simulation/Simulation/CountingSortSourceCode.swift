//
//  CountingSortSourceCode.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/4.
//

//import Foundation
import UIKit
import SideMenu

class CountingSortSourceCode: UIViewController, MenuControllerDelegate {
    
    var sideMenu: SideMenuNavigationController?
//    let CountingSortSim = CountingSortSimulation()
    
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!
    var textFields: [UITextField] = []

    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    var labels: [UILabel] = []
    
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    
    var previousVC: CountingSortSimulation?
    var arr = [Int]()
    var changeArr = [Int]()
    var totalStep = 1
    var everyStep = [Int: Array<Int>]()
    var currentStep = 0
    
    var maxValue = 0
    
    var sort: String?
    var sendRandomArr = [String](repeating: "", count: 7)
    
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
    
    @IBAction func goInstruction(_ sender: UIButton) {
            let instructionVc = self.storyboard?.instantiateViewController(withIdentifier: "instruction") as! InstructionViewController
            self.navigationController?.pushViewController(instructionVc, animated: true)
        }

    
    @IBAction func turnToCountingSort(_ sender: UIButton) {
        sentDataBack()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToModeMenu(_ sender: UIButton) {
   //        let count = self.navigationController!.viewControllers.count
   //        if let preController = self.navigationController?.viewControllers[count-3]{
   //            self.navigationController?.popToViewController(preController, animated: true)
   //        }
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
        
        if previousVC!.everyStep.isEmpty {
            stepNum.text = "/"
            //nextStep.isEnabled = true//改過
            preStep.isEnabled = false
            
            textFields = [text1, text2, text3, text4, text5, text6, text7]
            for i in 0..<textFields.count
            {
                textFields[i].text = previousVC!.sendRandomArr[i]
            }

        } else {
            // 傳值
            
            //showArr()
            if let stepArr = everyStep[currentStep]
            {
                showArr(arr)
                changeBG(stepArr[stepArr.count - 5])
                changeLabelBG(stepArr[stepArr.count - 3])
                stepNum.text = "\(currentStep) / \(everyStep.count)"
            }
                
            if(currentStep >= everyStep.count)
            {
                nextStep.isEnabled = false
            }
            else
            {
                nextStep.isEnabled = true
            }
            if(currentStep <= 1)
            {
                preStep.isEnabled = false
            }
            else
            {
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
            previousVC!.maxValue = maxValue
            if everyStep.isEmpty {
                turnBackClear()
                previousVC!.nextStep.isEnabled = true
                previousVC!.preStep.isEnabled = false
                previousVC!.principle.isHidden = false//﻿改過
            } else {
                previousVC!.everyStep = everyStep
                previousVC!.arr = arr
                previousVC!.changeArr = changeArr
                turnBackShowArr()
//                turnBackChange()
//                turnBackChangeBArr(everyStep[currentStep]!)
//                turnBackChangeCountArr(everyStep[currentStep]!)
//                turnBackChangeBG(everyStep[currentStep]!)
//                turnBackChangeCountingBG(everyStep[currentStep]!)
//                turnBackChangeBTextColor(everyStep[currentStep]!)
//                turnBackChangeCountingTextColor(everyStep[currentStep]!)
//                turnBackChangeBG(everyStep[currentStep]!)
//                turnBackChangeTextColor(everyStep[currentStep]!)
//                turnBackIntroduceStep(everyStep[currentStep]!)
//                turnBackShowIJKey(everyStep[currentStep]!)
                previousVC!.stepNum.text = "\(currentStep) / \(everyStep.count)"
                
                if let stepArr = everyStep[currentStep]
                {
                    turnBackIntroduceStep(stepArr[stepArr.count - 3])
                    turnBackShowI(stepArr[stepArr.count - 6])
                    
                    if currentStep < changeArr[0]
                    {
                        turnBackChangeBG(stepArr[stepArr.count - 5])
                        turnBackChangeCountingTextColor(stepArr[stepArr.count - 4])
                        turnBackChangeCountArr(stepArr)
                        //changeBucketTextColor(everyStep[currentStep]!)
                        
                    }
                    else if currentStep < changeArr[1]
                    {
                        turnBackChangeCountArr(stepArr)
                        turnBackChangeCountingTextColor(stepArr[stepArr.count - 4])
                        
                    }
                    else
                    {
                        turnBackChangeBArr(stepArr)
                        turnBackChangeBG(stepArr[stepArr.count - 5])
                        turnBackChangeCountingBG(stepArr[stepArr.count - 2])
                        turnBackChangeBTextColor(stepArr[stepArr.count - 1])
                        
                        turnBackChangeCountingTextColor(stepArr[stepArr.count - 4])
                        turnBackChangeCountArr(everyStep[currentStep]!)
                        
                    }
                }
                    
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
                previousVC!.principle.isHidden = true//﻿改過
                if(currentStep == 0)//﻿改過
                {
                    previousVC!.iLabel.text = "i = "
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
                    //previousVC!.principle.isHidden = false//﻿改過

                }
                
                if(maxValue==1 && currentStep < 26){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==2 && currentStep < 27){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==3 && currentStep < 28){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==4 && currentStep < 29){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==5 && currentStep < 30){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==6 && currentStep < 31){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==7 && currentStep < 32){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                if(maxValue==8 && currentStep < 33){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
               
                if(maxValue==9 && currentStep < 35){
                    previousVC!.Btext1.text = ""
                    previousVC!.Btext2.text = ""
                    previousVC!.Btext3.text = ""
                    previousVC!.Btext4.text = ""
                    previousVC!.Btext5.text = ""
                    previousVC!.Btext6.text = ""
                    previousVC!.Btext7.text = ""
                }
                
//                if(currentStep < 35)
//                {
//                    previousVC!.Btext1.text = ""
//                    previousVC!.Btext2.text = ""
//                    previousVC!.Btext3.text = ""
//                    previousVC!.Btext4.text = ""
//                    previousVC!.Btext5.text = ""
//                    previousVC!.Btext6.text = ""
//                    previousVC!.Btext7.text = ""
//                }
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
    
    @IBAction func randomNum(sender: UIButton)
    {
        //arr.removeAll()
        var randArr = [Int]()
        
        while randArr.count < 7 {
            let randomNumber = Int(arc4random_uniform(9)) + 1//1~9
            randArr.append(randomNumber)
            /*
            if !randArr.contains(randomNumber) {
                randArr.append(randomNumber)
            }*/
        }
        reset()
        showArr(randArr)
        //insertToFinal()
        //firstNext = false
        //nextStep.isEnabled = true
        //stepNum.text = "\(currentStep) / \(everyStep.count)"
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
    
    @IBAction func nextStep(sender: UIButton)
    {
        if currentStep == 0
        {
            if userInput()
            {
                currentStep += 1
                //preStep.isEnabled = true
                
                stepNum.text = "\(currentStep) / \(everyStep.count)"
                
                if let stepArr = everyStep[currentStep]
                {
                    //introduceStep(stepArr[stepArr.count - 3])
                    //showI(stepArr[stepArr.count - 6])
                    changeLabelBG(stepArr[stepArr.count - 3])
                    
                    if currentStep < changeArr[0]
                    {
                        changeBG(stepArr[stepArr.count - 5])
                        //changeCountingTextColor(stepArr[stepArr.count - 4])
                        //showCurrCountArr(stepArr)
                        //changeBucketTextColor(everyStep[currentStep]!)
                        
                    }
                    /*else if currentStep < changeArr[1]
                    {
                        showCurrCountArr(stepArr)
                        changeCountingTextColor(stepArr[stepArr.count - 4])
                        
                    }*/
                    else
                    {
                        //showCurrBArr(everyStep[currentStep]!)
                        changeBG(stepArr[stepArr.count - 5])
                        //changeCountingBG(stepArr[stepArr.count - 2])
                        //changeBTextColor(stepArr[stepArr.count - 1])
                        
                        //changeCountingTextColor(stepArr[stepArr.count - 4])
                        //showCurrCountArr(stepArr)
                        
                    }
                }
                    
                if(currentStep >= everyStep.count)
                {
                    nextStep.isEnabled = false
                }
            }
            
        }
        else
        {
            currentStep += 1
            preStep.isEnabled = true
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            
            if let stepArr = everyStep[currentStep]
            {
                changeLabelBG(stepArr[stepArr.count - 3])
                //introduceStep(stepArr[stepArr.count - 3])
                //showI(stepArr[stepArr.count - 6])
                
                if currentStep < changeArr[0]
                {
                    changeBG(stepArr[stepArr.count - 5])
                    //changeCountingTextColor(stepArr[stepArr.count - 4])
                    //showCurrCountArr(stepArr)
                    //changeBucketTextColor(everyStep[currentStep]!)
                    
                }
                /*else if currentStep < changeArr[1]
                {
                    showCurrCountArr(stepArr)
                    changeCountingTextColor(stepArr[stepArr.count - 4])
                    
                }*/
                else
                {
                    //showCurrBArr(everyStep[currentStep]!)
                    changeBG(stepArr[stepArr.count - 5])
                    //changeCountingBG(stepArr[stepArr.count - 2])
                    //changeBTextColor(stepArr[stepArr.count - 1])
                    
                    //changeCountingTextColor(stepArr[stepArr.count - 4])
                    //showCurrCountArr(stepArr)
                    
                }
            }
                
            if(currentStep >= everyStep.count)
            {
                nextStep.isEnabled = false
            }
        }
    }
    
    @IBAction func preStep(sender: UIButton)
    {
        currentStep -= 1
        nextStep.isEnabled = true
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        
        if let stepArr = everyStep[currentStep]
        {
            changeLabelBG(stepArr[stepArr.count - 3])
            
            if currentStep < changeArr[0]
            {
                changeBG(stepArr[stepArr.count - 5])
                //changeCountingTextColor(stepArr[stepArr.count - 4])
                //showCurrCountArr(stepArr)
                //changeBucketTextColor(everyStep[currentStep]!)
                
            }
            else if currentStep < changeArr[1]
            {
                //showCurrCountArr(stepArr)
                //changeCountingTextColor(stepArr[stepArr.count - 4])
                
            }
            else
            {
                //showCurrBArr(everyStep[currentStep]!)
                changeBG(stepArr[stepArr.count - 5])
                //changeCountingBG(stepArr[stepArr.count - 2])
                //changeBTextColor(stepArr[stepArr.count - 1])
                
                //changeCountingTextColor(stepArr[stepArr.count - 4])
                //showCurrCountArr(stepArr)
                
            }
        }
        
        if(currentStep <= 1)
        {
            preStep.isEnabled = false
        }


    }
    
    func addInformationTodict(_ arr: Array<Int>, _ B: Array<Int>, _ i: Int, _ arrIndex: Int, _ countingIndex: Int, _ step: Int, _ countingBG: Int, _ bTextColor: Int)
    {
        var information = [Int](repeating: 0, count: arr.count + B.count + 6)
        
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
        
        information[information.count - 6] = i
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
        
        //let maxValue = getMaxValue(arr)
        //﻿範圍﻿ 0 ~﻿ max
        var counting = [Int](repeating: 0, count: maxValue)
        //var counting = [Int](repeating: 0, count: maxValue + 1)
        //addInformationTodict(counting, B, -2, -1, -1, -1, -1, -1)//﻿初始//﻿改過﻿﻿
        addInformationTodict(counting, B, -2, -1, -1, 0, -1, -1)//﻿﻿放0
        
        for i in 0..<arr.count
        {
            addInformationTodict(counting, B, i, -1, -1, 1, -1, -1)//﻿﻿比較for
            counting[arr[i] - 1] += 1
            addInformationTodict(counting, B, i, i, arr[i] - 1, 2, -1, -1)
            
        }
        addInformationTodict(counting, B, arr.count, -1, -1, 1, -1, -1)//比較﻿﻿for﻿結束
        changeArr.append(totalStep)
        
        for i in 1..<counting.count
        {
            addInformationTodict(counting, B, i, -1, -1, 3, -1, -1)//﻿﻿比較for
            counting[i] += counting[i - 1]
            addInformationTodict(counting, B, i, -1, i, 4, -1, -1)
            //﻿﻿文字﻿變紅﻿而已
        }
        addInformationTodict(counting, B, counting.count, -1, -1, 3, -1, -1)//比較﻿﻿for﻿結束
        changeArr.append(totalStep)
        
        
        var i = B.count - 1
        while i >= 0
        {
            addInformationTodict(counting, B, i, -1, -1, 5, -1, -1)//﻿﻿比較for
            
            B[counting[arr[i] - 1] - 1] = arr[i]
            addInformationTodict(counting, B, i, i, -1, 6, arr[i] - 1, counting[arr[i] - 1] - 1)

            counting[arr[i] - 1] -= 1
            addInformationTodict(counting, B, i, i, arr[i] - 1, 7, -1, -1)
            i -= 1
        }
        addInformationTodict(counting, B, -1, -1, -1, 5, -1, -1)//比較﻿﻿for﻿結束
        addInformationTodict(counting, B, -2, -1, -1, -1, -1, -1)//結束
        
    }
    
    func showArr(_ inputArr: Array<Int>)
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
            //textFields[i].text = inputArr[i]
            textFields[i].text = "\(inputArr[i])"
        }
        
    }
    
    func userInput() -> Bool
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        arr.removeAll()
        
        for i in 0..<textFields.count
        {
            if let num = textFields[i].text
            {
                
                if !checkNumeric(num)
                {
                    let controller = UIAlertController(title: "﻿請﻿﻿完整填﻿好﻿數字", message: "!!!!!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default, handler: nil)
                    controller.addAction(okAction)
                    present(controller, animated: true)
                    
                    return false
                }
                arr.append(Int(num)!)
            }
        }
        maxValue = getMaxValue(arr)
        show_B_CArrLength(maxValue)
        countingToFinal()
        
        return true
    }
    
    func checkNumeric(_ s: String) -> Bool
    {
       return Int(s) != nil
    }
    
    func reset()
    {
        preStep.isEnabled = false
        nextStep.isEnabled = true
        
        show_B_CArrLength(-1)
        totalStep = 1
        everyStep.removeAll()
        currentStep = 0
        
        stepNum.text = "/"
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
            textFields[i].backgroundColor = color_array_bg
            textFields[i].textColor = color_array_text
        }
        
        labels = [label1, label2, label3, label4, label5, label6, label7, label8, label9]
        for i in 0..<labels.count
        {
            labels[i].backgroundColor = UIColor.white
            //textFields[i].textColor = color_array_text
        }
        
    }
    
    func changeBG(_ num1: Int)
    {
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        if num1 >= 0 && num1 < 7
        {
            for i in 0..<textFields.count
            {
                if i == num1
                {
                    textFields[i].backgroundColor = color_bg_highlighter
                }
                else
                {
                    textFields[i].backgroundColor = color_array_bg
                }
                
            }
        }
        else
        {
            for i in 0..<textFields.count
            {
                textFields[i].backgroundColor = color_array_bg
            }
        }
        
    }
    
    func changeLabelBG(_ num1: Int)
    {
        labels = [label1, label2, label3, label4, label5, label6, label7, label8, label9]
        if num1 > 0 && num1 < 8
        {
            for i in 0..<labels.count
            {
                if i == num1+1
                {
                    labels[i].backgroundColor = color_bg_highlighter
                }
                else
                {
                    labels[i].backgroundColor = UIColor.white
                }
                
            }
        }
        else if num1 == 0
        {
            for i in 0..<labels.count
            {
                if i == num1 || i == num1+1
                {
                    labels[i].backgroundColor = color_bg_highlighter
                }
                else
                {
                    labels[i].backgroundColor = UIColor.white
                }
                
            }
        }
        else
        {
            for i in 0..<labels.count
            {
                labels[i].backgroundColor = UIColor.white
            }
        }
        
    }
    
    func turnBackClear ()
    {
        previousVC!.iLabel.text = "i = "
        previousVC!.introduce.text = ""
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
            previousVC!.textFields[i].text = textFields[i].text ?? ""
        }
        /*
        previousVC!.text1.text = ""
        previousVC!.text2.text = ""
        previousVC!.text3.text = ""
        previousVC!.text4.text = ""
        previousVC!.text5.text = ""
        previousVC!.text6.text = ""
        previousVC!.text7.text = ""*/
        
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
//        previousVC!.Btext1.text = "\(arr[10])"
//        previousVC!.Btext2.text = "\(arr[11])"
//        previousVC!.Btext3.text = "\(arr[12])"
//        previousVC!.Btext4.text = "\(arr[13])"
//        previousVC!.Btext5.text = "\(arr[14])"
//        previousVC!.Btext6.text = "\(arr[15])"
//        previousVC!.Btext7.text = "\(arr[16])"
        
        previousVC!.Btext1.text = "\(arr[maxValue])"
        previousVC!.Btext2.text = "\(arr[maxValue + 1])"
        previousVC!.Btext3.text = "\(arr[maxValue + 2])"
        previousVC!.Btext4.text = "\(arr[maxValue + 3])"
        previousVC!.Btext5.text = "\(arr[maxValue + 4])"
        previousVC!.Btext6.text = "\(arr[maxValue + 5])"
        previousVC!.Btext7.text = "\(arr[maxValue + 6])"
        
        
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
    
    func turnBackChangeBG(_ num1: Int)
    {
        //var num1 = arr[arr.count - 5] as! Int
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
    
    func turnBackChangeCountingBG(_ num1: Int)
    {
        //var num1 = arr[arr.count - 2] as! Int
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
    
    
    func turnBackChangeBTextColor(_ num1: Int)
    {
        //var num1 = arr[arr.count - 1] as! Int
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
    
    func turnBackChangeCountingTextColor(_ num1: Int)
    {
        //var num1 = arr[arr.count - 4] as! Int
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
    
    
    func turnBackIntroduceStep(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
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
    
    func turnBackShowI(_ num1: Int)
    {
        //var num1 = arr[arr.count - 6] as! Int
        
        if num1 != -2
        {
            previousVC!.iLabel.text  = "i = \(num1 + 1)"
        }
        else
        {
            previousVC!.iLabel.text = "i = ?"
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
    
 
    func didSelectMenuItem(named: String) {
           sideMenu?.dismiss(animated: true, completion: { [weak self] in
               if named == "模擬" {
               }
               else if named == "練習" {
                   let practiceVc = self?.storyboard?.instantiateViewController(withIdentifier: "PracticeViewController") as! Practice
                   self?.navigationController?.pushViewController(practiceVc, animated: true)
                   practiceVc.sort = self?.sort
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
       
    

}

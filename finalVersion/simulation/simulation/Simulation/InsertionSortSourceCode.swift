//
//  InsertionSortSourceCode.swift
//  simulation
//
//  Created by WanHsuan on 2023/7/24.
//

//import Foundation
import UIKit
import SideMenu
                                                
class InsertionSortSourceCode: UIViewController, MenuControllerDelegate {
    
    var sideMenu: SideMenuNavigationController?
    
    
    
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
    var textLabels: [UILabel] = []
    
    @IBOutlet var stepNum: UILabel!
    
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    
    var previousVC: InsertionSortSimulation?
    var currentStep = 0//﻿改過
    var everyStep = [Int: Array<Int>]()
    var arr = [Int]()
    var totalStep = 1
    
    var color_bg_highlighter = UIColor(rgb: 0xf5f36c) //螢光筆顏色(底)
    var color_text_highlighter = UIColor(rgb: 0xe31212)
    var color_array_bg = UIColor(rgb: 0xFFFFFF) //陣列底色
    var color_array_text = UIColor(rgb: 0x2B2D42) //陣列數字顏色

    var sort: String?
    var sendRandomArr = [String](repeating: "", count: 7)
    
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
    
    // 頁面跳轉
    @IBAction func turnToInsertionSort(_ sender: UIButton) {
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
            //showArr(previousVC!.sendRandomArr)
            
            textFields = [text1, text2, text3, text4, text5, text6, text7]
                
            for i in 0..<textFields.count
            {
                textFields[i].text = previousVC!.sendRandomArr[i]
            }
            
        } else {
            // 傳值
            
            if let stepArr = everyStep[currentStep]
            {
                showArr(stepArr)
                changeBG(stepArr[stepArr.count - 2])
                changeTextColor(stepArr[stepArr.count - 1])
                changeLabelBG(stepArr[stepArr.count - 3])
                stepNum.text = "\(currentStep) / \(everyStep.count)"
            }

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
    
    // 資料傳回去
    func sentDataBack() {
        if previousVC != nil {
            previousVC!.currentStep = currentStep
            
            checkButton()
            previousVC!.totalStep = totalStep
            previousVC!.everyStep = everyStep
            if everyStep.isEmpty {
                turnBackClear()
                previousVC!.nextStep.isEnabled = true
                previousVC!.preStep.isEnabled = false
                previousVC!.principle.isHidden = false//﻿改過
                
            } else {
                //previousVC!.everyStep = everyStep
                previousVC!.arr = arr
                turnBackChange()
                
                if let stepArr = everyStep[currentStep]
                {
                    turnBackChangeBG(stepArr[stepArr.count - 2])
                    turnBackChangeTextColor(stepArr[stepArr.count - 1])
                    turnBackIntroduceStep(stepArr[stepArr.count - 3])
                    turnBackShowIJKey(stepArr[stepArr.count - 5], stepArr[stepArr.count - 4], stepArr[stepArr.count - 3], stepArr)
                }
                
                previousVC!.stepNum.text = "\(currentStep) / \(everyStep.count)"
                
                if(currentStep >= everyStep.count)
                {
                    previousVC!.nextStep.isEnabled = false
                }
                else
                {
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
                    previousVC!.iLabel.text = "j = "
                    previousVC!.jLabel.text = "i = "
                    previousVC!.keyLabel.text = "key = "
                    //previousVC!.principle.isHidden = false//﻿改過

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
    
    
    @IBAction func randomNum(sender: UIButton)
    {
        //arr.removeAll()
        var randArr = [Int]()
        
        while randArr.count < 7 {
            let randomNumber = Int(arc4random_uniform(10)) + 1
            if !randArr.contains(randomNumber) {
                randArr.append(randomNumber)
            }
        }
        reset()
        showArr(randArr)
    }
    
    @IBAction func nextStep(sender: UIButton)
    {
        if currentStep == 0
        {
            if userInput()
            {
                currentStep += 1
                //preStep.isEnabled = true//﻿改過
                
                if let stepArr = everyStep[currentStep]
                {
                    showArr(stepArr)
                    changeBG(stepArr[stepArr.count - 2])
                    changeTextColor(stepArr[stepArr.count - 1])
                    changeLabelBG(stepArr[stepArr.count - 3])
                    stepNum.text = "\(currentStep) / \(everyStep.count)"
                    
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
            
            if let stepArr = everyStep[currentStep]
            {
                showArr(stepArr)
                changeBG(stepArr[stepArr.count - 2])
                changeTextColor(stepArr[stepArr.count - 1])
                changeLabelBG(stepArr[stepArr.count - 3])
                stepNum.text = "\(currentStep) / \(everyStep.count)"
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
        
        if let stepArr = everyStep[currentStep]
        {
            showArr(stepArr)
            changeBG(stepArr[stepArr.count - 2])
            changeTextColor(stepArr[stepArr.count - 1])
            changeLabelBG(stepArr[stepArr.count - 3])
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            
        }
        
        if(currentStep <= 1)
        {
            preStep.isEnabled = false
        }

    }
    
    func addInformationTodict(_ i: Int, _ j: Int, _ step: Int, _ textBGColor: Int, _ textColor: Int)
    {
        var information = [Int](repeating: 0, count: 12)
        for index in 0..<arr.count
        {
            information[index] = arr[index]
        }
        information[information.count - 5] = i
        information[information.count - 4] = j
        information[information.count - 3] = step
        information[information.count - 2] = textBGColor
        information[information.count - 1] = textColor
        everyStep[totalStep] = information
        totalStep += 1
        
    }
    
    func insertToFinal()
    {
        //addInformationTodict(-1, -2, -1, -1, -1)//﻿改過﻿﻿
        
        for i in 1..<arr.count
        {
            addInformationTodict(i, -2, 0, -1, -1)
            
            let key = arr[i]
            addInformationTodict(i, -2, 1, -1, -1)
            
            var j = i - 1
            addInformationTodict(i, j, 2, -1, -1)
        
            addInformationTodict(i, j, 3, j + 1, -1)
            
            while j >= 0 && arr[j] > key
            {
                
                arr[j + 1] = arr[j]
                addInformationTodict(i, j, 4, -1, j + 1)
                
                j -= 1
                addInformationTodict(i, j, 5, -1, -1)
          
                addInformationTodict(i, j, 3, j + 1, -1)
                
            }
            
            arr[j + 1] = key
            addInformationTodict(i, j, 6, 0, j + 1)
        }
       
        addInformationTodict(-1, -2, 0, -1, -1)
        addInformationTodict(-1, -2, -1, -1, -1)
        
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
        insertToFinal()
        return true
    }
    
    func checkNumeric(_ s: String) -> Bool
    {
       return Int(s) != nil
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
        nextStep.isEnabled = true
        
        totalStep = 1
        everyStep.removeAll()
        currentStep = 0
        stepNum.text = "/"
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        textLabels = [label1, label2, label3, label4, label5, label6, label7]
        
        for i in 0..<textFields.count
        {
            textFields[i].backgroundColor = color_array_bg
            textFields[i].textColor = color_array_text
            textLabels[i].backgroundColor = UIColor.white
        }
        
        /*
        label1.backgroundColor = UIColor.white
        label2.backgroundColor = UIColor.white
        label3.backgroundColor = UIColor.white
        label4.backgroundColor = UIColor.white
        label5.backgroundColor = UIColor.white
        label6.backgroundColor = UIColor.white
        label7.backgroundColor = UIColor.white*/
        
    }
    
    func changeBG(_ num1: Int)
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        if num1 > 0 && num1 < 7
        {
            for i in 0..<textFields.count
            {
                if i + 1 == num1 || i + 1 == num1 + 1
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
    
    func changeTextColor(_ num1: Int)
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        if num1 >= 0 && num1 < 7
        {
            for i in 0..<textFields.count
            {
                if i == num1
                {
                    textFields[i].textColor = color_text_highlighter
                }
                else
                {
                    textFields[i].textColor = color_array_text
                }
                
            }
        }
        else
        {
            for i in 0..<textFields.count
            {
                textFields[i].textColor = color_array_text
            }
        }
    }
    
    func changeLabelBG(_ num1: Int)
    {
        textLabels = [label1, label2, label3, label4, label5, label6, label7]
        
        if num1 >= 0 && num1 < 7
        {
            for i in 0..<textFields.count
            {
                if i == num1
                {
                    textLabels[i].backgroundColor = color_bg_highlighter
                }
                else
                {
                    textLabels[i].backgroundColor = UIColor.white
                }
                
            }
        }
        else
        {
            for i in 0..<textFields.count
            {
                textLabels[i].backgroundColor = UIColor.white
            }
        }
        
        //var num1 = arr[arr.count - 3] as! Int
        /*switch num1
        {
        case 0:
            label1.backgroundColor = color_bg_highlighter
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
        case 1:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = color_bg_highlighter
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
        case 2:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = color_bg_highlighter
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
        case 3:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = color_bg_highlighter
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
        case 4:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = color_bg_highlighter
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
        case 5:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = color_bg_highlighter
            label7.backgroundColor = UIColor.white
        case 6:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = color_bg_highlighter
            
        default:
            label1.backgroundColor = UIColor.white
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            label7.backgroundColor = UIColor.white
        }*/
    }
    
    func turnBackChange() {
        previousVC!.text1.text = "\(everyStep[currentStep]![0])"
        previousVC!.text2.text = "\(everyStep[currentStep]![1])"
        previousVC!.text3.text = "\(everyStep[currentStep]![2])"
        previousVC!.text4.text = "\(everyStep[currentStep]![3])"
        previousVC!.text5.text = "\(everyStep[currentStep]![4])"
        previousVC!.text6.text = "\(everyStep[currentStep]![5])"
        previousVC!.text7.text = "\(everyStep[currentStep]![6])"
    }
    
    func turnBackChangeBG(_ num1: Int)
    {
        //var num1 = arr[arr.count - 2] as! Int
        switch num1
        {
        case 1:
            previousVC!.text1.backgroundColor = color_bg_highlighter
            previousVC!.text2.backgroundColor = color_bg_highlighter
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 2:
            previousVC!.text2.backgroundColor = color_bg_highlighter
            previousVC!.text3.backgroundColor = color_bg_highlighter
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 3:
            previousVC!.text3.backgroundColor = color_bg_highlighter
            previousVC!.text4.backgroundColor = color_bg_highlighter
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 4:
            previousVC!.text4.backgroundColor = color_bg_highlighter
            previousVC!.text5.backgroundColor = color_bg_highlighter
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text6.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 5:
            previousVC!.text5.backgroundColor = color_bg_highlighter
            previousVC!.text6.backgroundColor = color_bg_highlighter
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text7.backgroundColor = color_array_bg
        case 6:
            previousVC!.text6.backgroundColor = color_bg_highlighter
            previousVC!.text7.backgroundColor = color_bg_highlighter
            previousVC!.text1.backgroundColor = color_array_bg
            previousVC!.text2.backgroundColor = color_array_bg
            previousVC!.text3.backgroundColor = color_array_bg
            previousVC!.text4.backgroundColor = color_array_bg
            previousVC!.text5.backgroundColor = color_array_bg
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
    
    func turnBackChangeTextColor(_ num1: Int)
    {
        //var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            previousVC!.text1.textColor = color_text_highlighter
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        case 1:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_text_highlighter
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        case 2:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_text_highlighter
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        case 3:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_text_highlighter
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        case 4:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_text_highlighter
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        case 5:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_text_highlighter
            previousVC!.text7.textColor = color_array_text
        case 6:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_text_highlighter
            
        default:
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        }
    }
    
    func turnBackIntroduceStep(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            previousVC!.introduce.text = "判斷j﻿目前﻿是否﻿小於﻿A﻿陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 1:
            previousVC!.introduce.text = "﻿將A[j]的值給key"
        case 2:
            previousVC!.introduce.text = "﻿將j-1的值給i"
        case 3:
            previousVC!.introduce.text = "﻿﻿判斷﻿i是否﻿大於0﻿，﻿且A[i]﻿的﻿值﻿﻿大於key，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 4:
            previousVC!.introduce.text = "﻿將A[i]的值給A[i+1]"
        case 5:
            previousVC!.introduce.text = "將i-1的值給i"
        case 6:
            previousVC!.introduce.text = "﻿將key的值給A[i+1]"
        default:
            previousVC!.introduce.text = ""
        }
        
    }
    
    func turnBackClear ()
    {
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
        
        previousVC!.iLabel.text = "j = "
        previousVC!.jLabel.text = "i = "
        previousVC!.keyLabel.text = "key = "
        
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
        
        previousVC!.stepNum.text = "/"
    }
    
    func turnBackShowIJKey(_ num1: Int, _ num2: Int, _ num3: Int, _ arr2: Array<Int>)
    {
        if num1 != -1
        {
            previousVC!.iLabel.text = "j = \(num1 + 1)"
        }
        else
        {
            previousVC!.iLabel.text = "j = ?"
        }
        
        if num2 != -2//改成-1變-2
        {
            previousVC!.jLabel.text = "i = \(num2 + 1)"
        }
        else
        {
            previousVC!.jLabel.text = "i = ?"
        }
        
        switch num3//﻿也改
        {
        case 0:
            previousVC!.keyLabel.text = "key = ?"
        case 1:
            previousVC!.keyLabel.text = "key = \(arr[num1])"
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        default:
            previousVC!.keyLabel.text = "key = ?"
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

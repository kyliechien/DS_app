//
//  QuickSortSourceCode.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/19.
//

import UIKit
import SideMenu

class QuickSortSourceCode: UIViewController, MenuControllerDelegate {
    
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
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    @IBOutlet var label10: UILabel!
    @IBOutlet var label11: UILabel!
    @IBOutlet var label12: UILabel!
    @IBOutlet var label13: UILabel!
    @IBOutlet var label14: UILabel!
    @IBOutlet var label15: UILabel!
    @IBOutlet var label16: UILabel!
    @IBOutlet var label17: UILabel!
    var textLabels: [UILabel] = []
    
    
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    
    var previousVC: QuickSortSimulation?
    var arr = [Int]()
    var currentStep = 0
    var everyStep = [Int: Array<Int>]()
    var totalStep = 1
    
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
    
    @IBAction func turnToQuickSort(_ sender: UIButton) {
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
       
       @IBAction func goInstruction(_ sender: UIButton) {
           let instructionVc = self.storyboard?.instantiateViewController(withIdentifier: "instruction") as! InstructionViewController
           self.navigationController?.pushViewController(instructionVc, animated: true)
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
            if let stepArr = everyStep[currentStep]
            {
                showArr(stepArr)
                changeBG(stepArr[stepArr.count - 2])
                changeTextColor(stepArr[stepArr.count - 1])
                changeLabelBG(stepArr[stepArr.count - 3])
            }
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
            
            if let whichStep = everyStep[currentStep]
            {
                if whichStep[whichStep.count - 3] == 13
                {
                    changeTextColor2(whichStep[whichStep.count - 5])
                    
                }
                else if whichStep[whichStep.count - 3] == 14
                {
                    changeTextColor2(whichStep[whichStep.count - 7])
                    
                }
                
            }
        }

    }
    
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
                    turnBackShowIJKey(stepArr[stepArr.count - 5],stepArr[stepArr.count - 4],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6])
                }
                previousVC!.stepNum.text = "\(currentStep) / \(everyStep.count)"
                
                if let whichStep = everyStep[currentStep]
                {
                    if whichStep[whichStep.count - 3] == 13
                    {
                        turnBackChangeTextColor2(whichStep[whichStep.count - 5])
                        
                    }
                    else if whichStep[whichStep.count - 3] == 14
                    {
                        turnBackChangeTextColor2(whichStep[whichStep.count - 7])
                        
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
                    previousVC!.jLabel.text = "j = "
                    previousVC!.lLabel.text = "l = "
                    previousVC!.rLabel.text = "r = "
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
    /*
    @IBAction func showNumber(sender: UIButton)
    {
        arr.removeAll()
        while arr.count < 7 {
            let randomNumber = Int(arc4random_uniform(10)) + 1
            if !arr.contains(randomNumber) {
                arr.append(randomNumber)
            }
        }
        reset()
        showArr()
        addInformationTodict(arr,-1, -1, -1, -1, -1, -1, -1)
        addInformationTodict(arr,-1, -1, -1, -1, 0, -1, -1)
        quickSort(0, arr.count - 1)
        nextStep.isEnabled = true
        stepNum.text = "\(currentStep) / \(everyStep.count)"
    }*/
    
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
            //let correctInput = userInput()
            
            if userInput()
            {
                currentStep += 1
                //preStep.isEnabled = true
                
                if let stepArr = everyStep[currentStep]
                {
                    showArr(stepArr)
                    changeBG(stepArr[stepArr.count - 2])
                    changeTextColor(stepArr[stepArr.count - 1])
                    changeLabelBG(stepArr[stepArr.count - 3])
                    stepNum.text = "\(currentStep) / \(everyStep.count)"
                    
                    if stepArr[stepArr.count - 3] == 13
                    {
                        changeTextColor2(stepArr[stepArr.count - 5])
                        
                    }
                    else if stepArr[stepArr.count - 3] == 14
                    {
                        changeTextColor2(stepArr[stepArr.count - 7])
                        
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
            
            if let stepArr = everyStep[currentStep]
            {
                showArr(stepArr)
                changeBG(stepArr[stepArr.count - 2])
                changeTextColor(stepArr[stepArr.count - 1])
                changeLabelBG(stepArr[stepArr.count - 3])
                stepNum.text = "\(currentStep) / \(everyStep.count)"
                
                if stepArr[stepArr.count - 3] == 13
                {
                    changeTextColor2(stepArr[stepArr.count - 5])
                    
                }
                else if stepArr[stepArr.count - 3] == 14
                {
                    changeTextColor2(stepArr[stepArr.count - 7])
                    
                }
            }
            
            if(currentStep >= everyStep.count)
            {
                nextStep.isEnabled = false
            }
        }
        
        
        //currentLabelStep += 1
        /*
        currentStep += 1
        preStep.isEnabled = true
        
        if let stepArr = everyStep[currentStep]
        {
            showArr(stepArr)
            changeBG(stepArr[stepArr.count - 2])
            changeTextColor(stepArr[stepArr.count - 1])
            changeLabelBG(stepArr[stepArr.count - 3])
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            
            if stepArr[stepArr.count - 3] == 13
            {
                changeTextColor2(stepArr[stepArr.count - 5])
                
            }
            else if stepArr[stepArr.count - 3] == 14
            {
                changeTextColor2(stepArr[stepArr.count - 7])
                
            }
            
        }
        
        if(currentStep >= everyStep.count)
        {
            nextStep.isEnabled = false
        }*/
        

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
            
            if stepArr[stepArr.count - 3] == 13
            {
                changeTextColor2(stepArr[stepArr.count - 5])
                
            }
            else if stepArr[stepArr.count - 3] == 14
            {
                changeTextColor2(stepArr[stepArr.count - 7])
                
            }
            
        }
        
        if(currentStep <= 1)
        {
            preStep.isEnabled = false
        }


    }
    
    func addInformationTodict(_ arr: Array<Int>, _ l: Int, _ r: Int, _ i: Int, _ j: Int, _ step: Int, _ textBGColor: Int, _ textColor: Int)
    {
        var information = [Int](repeating: 0, count: arr.count + 7)
        for index in 0..<arr.count
        {
            information[index] = arr[index]
        }
        information[information.count - 7] = l
        information[information.count - 6] = r
        information[information.count - 5] = i
        information[information.count - 4] = j
        information[information.count - 3] = step
        information[information.count - 2] = textBGColor
        information[information.count - 1] = textColor
        everyStep[totalStep] = information
        totalStep += 1
    }
    
    func quickSort(_ l: Int, _ r: Int)
    {
        //addInformationTodict(arr, -1, -1, 1, -1, -1)
        
        addInformationTodict(arr, l, r, -1, -1, 2, -1, -1)
        if l < r
        {
            var i = l
            addInformationTodict(arr, l, r, i, -1, 3, -1, -1)
            var j = r + 1
            //var x = arr[i]
            addInformationTodict(arr, l, r, i, j, 4, -1, -1)
            
            while i < j
            {
                addInformationTodict(arr, l, r, i, j, 5, -1, -1)
                
                
                var jFirst = true
                repeat
                {
                    if jFirst
                    {
                        jFirst = false
                    }
                    else
                    {
                        addInformationTodict(arr, l, r, i, j, 8, j, -1)
                    }
                    
                    j -= 1 // 从右向左找第一个小于x的数
                    addInformationTodict(arr, l, r, i, j, 7, -1, -1)
                    
                    
                } while i < j && arr[j] > arr[l]
                addInformationTodict(arr, l, r, i, j, 8, j, -1)
                
                var iFirst = true
                repeat
                {
                    if iFirst
                    {
                        iFirst = false
                    }
                    else
                    {
                        addInformationTodict(arr, l, r, i, j, 11, i, -1)
                    }
                    
                    i += 1 // 从右向左找第一个小于x的数
                    addInformationTodict(arr, l, r, i, j, 10, -1, -1)
                    
                } while i < j && arr[i] < arr[l]
                addInformationTodict(arr, l, r, i, j, 11, i, -1)
                            
                
                addInformationTodict(arr, l, r, i, j, 12, -1, -1)
                if i < j
                {
                    let temp = arr[i]
                    arr[i] = arr[j]
                    arr[j] = temp
                    addInformationTodict(arr, l, r, i, j, 13, -1, j)
                    
                }
            }
            addInformationTodict(arr, l, r, i, j, 5, -1, -1)
            
            let tmp = arr[l]
            arr[l] = arr[j]
            arr[j] = tmp
            addInformationTodict(arr, l, r, i, j, 14, -1, j)
            
            

            addInformationTodict(arr, l, r, -1, -1, 15, -1, -1)
            quickSort(l, j - 1)
            addInformationTodict(arr, l, r, -1, -1, 16, -1, -1)
            quickSort(j + 1, r)
            
            addInformationTodict(arr, l, r, -1, -1, 17, -1, -1)
        }
    
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
        //addInformationTodict(arr, -1, -1, -1, -1, -1, -1, -1)//﻿改過﻿﻿
        addInformationTodict(arr, -1, -1, -1, -1, 0, -1, -1)
        quickSort(0, arr.count - 1)
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
        
        totalStep = 1
        everyStep.removeAll()
        currentStep = 0
        
        stepNum.text = "/"
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        textLabels = [label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17]
        
        for i in 0..<textFields.count
        {
            textFields[i].backgroundColor = color_array_bg
            textFields[i].textColor = color_array_text
            //textLabels[i].backgroundColor = UIColor.white
        }
        for i in 0..<textLabels.count
        {
            textLabels[i].backgroundColor = UIColor.white
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
    
    func changeTextColor2(_ num1: Int)
    {
        //var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            text1.textColor = color_text_highlighter
        case 1:
            text2.textColor = color_text_highlighter
        case 2:
            text3.textColor = color_text_highlighter
        case 3:
            text4.textColor = color_text_highlighter
        case 4:
            text5.textColor = color_text_highlighter
        case 5:
            text6.textColor = color_text_highlighter
        case 6:
            text7.textColor = color_text_highlighter
        default:
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
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
        
        previousVC!.iLabel.text = "i = "
        previousVC!.jLabel.text = "j = "
        previousVC!.lLabel.text = "l = "
        previousVC!.rLabel.text = "r = "
        
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
    
    func changeLabelBG(_ num1: Int)
    {
        textLabels = [label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17]
        if num1 >= 0 && num1 < 17 && num1 != 1 && num1 != 6 && num1 != 9
        {
            for i in 0..<textLabels.count
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
            for i in 0..<textLabels.count
            {
                textLabels[i].backgroundColor = UIColor.white
            }
        }
        
        
        
    }
    
    func turnBackShowIJKey(_ num1: Int, _ num2: Int, _ num3: Int,_ num4: Int)
    {
        //var num1 = arr[arr.count - 5] as! Int
        
        if num1 != -1
        {
            previousVC!.iLabel.text  = "i = \(num1 + 1)"
        }
        else
        {
            previousVC!.iLabel.text = "i = ?"
        }
        
        //var num2 = arr[arr.count - 4] as! Int
        
        if num2 != -1
        {
            previousVC!.jLabel.text = "j = \(num2 + 1)"
        }
        else
        {
            previousVC!.jLabel.text = "j = ?"
        }
        
        //var num3 = arr[arr.count - 7] as! Int
        
        if num3 != -1
        {
            previousVC!.lLabel.text = "l = \(num3 + 1)"
        }
        else
        {
            previousVC!.lLabel.text = "l = ?"
        }
        
        
        //var num4 = arr[arr.count - 6] as! Int
        
        if num4 != -1
        {
            previousVC!.rLabel.text = "r = \(num4 + 1)"
        }
        else
        {
            previousVC!.rLabel.text = "r = ?"
        }
        
    }
    
    
    
//
//    func turnBackIntroduceStep(_ arr: Array<Int>)
//    {
//        var num1 = arr[arr.count - 3] as! Int
//        switch num1
//        {
//        case 0:
//            previousVC!.introduce.text = "判斷j﻿目前﻿是否﻿小於﻿等於陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
//        case 1:
//            previousVC!.introduce.text = "﻿將A[j]的值給key"
//        case 2:
//            previousVC!.introduce.text = "﻿將j-1的值給i"
//        case 3:
//            previousVC!.introduce.text = "﻿﻿判斷﻿i是否﻿大於0﻿，﻿且A[i]﻿的﻿值﻿﻿大於key，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
//        case 4:
//            previousVC!.introduce.text = "﻿將A[i]的值給A[i+1]"
//        case 5:
//            previousVC!.introduce.text = "將i-1的值給i"
//        case 6:
//            previousVC!.introduce.text = "﻿將key的值給A[i+1]"
//        default:
//            previousVC!.introduce.text = ""
//        }
//
//    }
    
    func turnBackIntroduceStep(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            previousVC!.introduce.text = "﻿呼叫quickSort﻿﻿函式﻿，﻿並﻿將0﻿和﻿A﻿陣列﻿長度﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 2:
            previousVC!.introduce.text = "﻿﻿比較l﻿是否﻿﻿小於r"
        case 3:
            previousVC!.introduce.text = "﻿將l的值給i"
        case 4:
            previousVC!.introduce.text = "﻿﻿將r + 1的值給j"
        case 5:
            previousVC!.introduce.text = "﻿判斷i目前﻿是否﻿小於﻿j﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 7:
            previousVC!.introduce.text = "將j的值﻿﻿減1"
        case 8:
            previousVC!.introduce.text = "﻿判斷目前﻿i是否﻿小於﻿j﻿﻿，﻿且﻿A﻿[﻿j]﻿大於A[l]，﻿是則﻿繼續﻿執行迴圈﻿，﻿否則﻿離開"
        case 10:
            previousVC!.introduce.text = "﻿將i的值﻿﻿加1"
        case 11:
            previousVC!.introduce.text = "判斷目前﻿i是否﻿小於﻿j﻿﻿，﻿且﻿A﻿[﻿j]﻿﻿小於A[l]，﻿是則﻿繼續﻿執行迴圈﻿，﻿否則﻿離開"
        case 12:
            previousVC!.introduce.text = "﻿比較i是否﻿﻿小於j"
        case 13:
            previousVC!.introduce.text = "﻿﻿交換﻿A﻿[﻿i]﻿與A[j]"
        case 14:
            previousVC!.introduce.text = "交換﻿A﻿[﻿l]﻿與A[j]"
        case 15:
            previousVC!.introduce.text = "﻿﻿再次呼叫quickSort﻿﻿函式﻿，﻿並﻿將l和﻿j - 1﻿分﻿別﻿做為l﻿和r"
        case 16:
            previousVC!.introduce.text = "﻿﻿再次呼叫quickSort﻿﻿函式﻿，﻿並﻿將j + 1和﻿r﻿分﻿別﻿做為l﻿和r"
        case 17:
            previousVC!.introduce.text = "﻿﻿﻿結束﻿A﻿[l﻿]~﻿A﻿[r﻿]﻿的﻿排序"
        default:
            previousVC!.introduce.text = ""
        }
        
    }
    
    func turnBackChangeTextColor2(_ num1: Int)
    {
        //var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            previousVC!.text1.textColor = color_text_highlighter
        case 1:
            previousVC!.text2.textColor = color_text_highlighter
        case 2:
            previousVC!.text3.textColor = color_text_highlighter
        case 3:
            previousVC!.text4.textColor = color_text_highlighter
        case 4:
            previousVC!.text5.textColor = color_text_highlighter
        case 5:
            previousVC!.text6.textColor = color_text_highlighter
        case 6:
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

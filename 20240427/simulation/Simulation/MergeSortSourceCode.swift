//
//  MergeSortSourceCode.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/23.
//

import UIKit
import SideMenu


class MergeSortSourceCode: UIViewController, MenuControllerDelegate {
    
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
    @IBOutlet var label18: UILabel!
    @IBOutlet var label19: UILabel!
    @IBOutlet var label20: UILabel!
    @IBOutlet var label21: UILabel!
    @IBOutlet var label22: UILabel!
    @IBOutlet var label23: UILabel!
    @IBOutlet var label24: UILabel!
    @IBOutlet var label25: UILabel!
    @IBOutlet var label26: UILabel!
    @IBOutlet var label27: UILabel!
    @IBOutlet var label28: UILabel!
    @IBOutlet var label29: UILabel!
    @IBOutlet var label30: UILabel!
    @IBOutlet var label31: UILabel!
    
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    
    var previousVC: MergeSortSimulation?
    var arr = [Int]()
    var currentStep = 0
    var everyStep = [Int: Array<Int>]()
    var totalStep = 1
    var controlStack = 0
    
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
    
    @IBAction func turnToMergeSort(_ sender: UIButton) {
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
            showArr(everyStep[currentStep]!)
            //            changeBGColor(everyStep[currentStep]!)
            //            changeTextColor(everyStep[currentStep]!)
            //            changeLabelBG(everyStep[currentStep]!)
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            
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
            
            changeBGColor(-1)
            
            if let stepArr = everyStep[currentStep]
            {
                //                showVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
                //                introduceStep(stepArr[stepArr.count - 3])
                changeTempArrColor(-1, stepArr)
                changeLabelBG(-1)
                changeLabelBG(stepArr[stepArr.count - 3])
                
                if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
                {
                    //                    show_tempArr(false, stepArr)
//                    controlStack += 1
                    
                }
                else if stepArr[stepArr.count - 3] > 8
                {
                    //                    show_tempArrNum(controlStack - 1, stepArr)
                    
                    if stepArr[stepArr.count - 3] == 14
                    {
                        changeBGColor(stepArr[stepArr.count - 6])
                        changeBGColor(stepArr[stepArr.count - 5])
                    }
                    else if stepArr[stepArr.count - 3] == 15 || stepArr[stepArr.count - 3] == 18 || stepArr[stepArr.count - 3] == 22 || stepArr[stepArr.count - 3] == 26 || stepArr[stepArr.count - 3] == 29
                    {
                        changeTempArrColor(controlStack - 1, stepArr)
                        
                    }
                    
                }
            }
            
        }
        
    }
    
    func sentDataBack() {
        if previousVC != nil {
            previousVC!.currentStep = currentStep
            previousVC!.controlStack = controlStack
            
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
                turnBackShowCurrArr(everyStep[currentStep]!)
//                turnBackChangeTempArrColor
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
                previousVC!.principle.isHidden = true//﻿改過
                if(currentStep == 0)//﻿改過
                {
                    previousVC!.iLabel.text = "j = "
                    previousVC!.jLabel.text = "i = "
                    previousVC!.kLabel.text = "k = "
                    previousVC!.lLabel.text = "l = "
                    previousVC!.mLabel.text = "middle = "
                    previousVC!.rLabel.text = "r = "
                    //previousVC!.principle.isHidden = false//﻿改過
                    
                }
                
//                if let stepArr = everyStep[currentStep]
//                {
//                    turnBackShowVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])//ok
//                    turnBackIntroduceStep(stepArr[stepArr.count - 3])//ok
//                    turnBackChangeTempArrColor(-1, stepArr)
//
//                    if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
//                    {
//                        turnBackShow_tempArr(false, stepArr)
////                        controlStack += 1
//
//                    }
//                    else if stepArr[stepArr.count - 3] > 8
//                    {
//                        turnBackShow_tempArrNum(controlStack - 1, stepArr)
//
//                        if stepArr[stepArr.count - 3] == 14
//                        {
//                            turnBackChangeBGColor(stepArr[stepArr.count - 6])
//                            turnBackChangeBGColor(stepArr[stepArr.count - 5])
//                        }
//                        else if stepArr[stepArr.count - 3] == 15 || stepArr[stepArr.count - 3] == 18 || stepArr[stepArr.count - 3] == 22 || stepArr[stepArr.count - 3] == 26 || stepArr[stepArr.count - 3] == 29
//                        {
//                            turnBackChangeTempArrColor(controlStack - 1, stepArr)
//
//                        }
//
//                    }
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
                //preStep.isEnabled = true
                
                showArr(everyStep[currentStep]!)
                stepNum.text = "\(currentStep) / \(everyStep.count)"
                changeBGColor(-1)
                turnBackChangeBGColor(-1) //+
                
                if let stepArr = everyStep[currentStep]
                {
                    turnBackShowVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
                    turnBackIntroduceStep(stepArr[stepArr.count - 3])//+
                    changeTempArrColor(-1, stepArr)
                    turnBackChangeTempArrColor(-1, stepArr)//+
                    
                    changeLabelBG(-1)
                    changeLabelBG(stepArr[stepArr.count - 3])
                    
                    if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
                    {
                        turnBackShow_tempArr(false, stepArr)//+
                        controlStack += 1
                        
                    }
                    else if stepArr[stepArr.count - 3] > 8
                    {
                        turnBackShow_tempArrNum(controlStack - 1, stepArr)//+
                        
                        if stepArr[stepArr.count - 3] == 14
                        {
                            changeBGColor(stepArr[stepArr.count - 6])
                            changeBGColor(stepArr[stepArr.count - 5])
                            turnBackChangeBGColor(stepArr[stepArr.count - 6])//+
                            turnBackChangeBGColor(stepArr[stepArr.count - 5])//+
                            
                        }else if stepArr[stepArr.count - 3] == 15 || stepArr[stepArr.count - 3] == 18 || stepArr[stepArr.count - 3] == 22 || stepArr[stepArr.count - 3] == 26 || stepArr[stepArr.count - 3] == 29
                        {
                            changeTempArrColor(controlStack - 1, stepArr)
                            turnBackChangeTempArrColor(controlStack - 1, stepArr)
                            
                        }
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
            //print(currentStep)
            showArr(everyStep[currentStep]!)
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            
            changeBGColor(-1)
            turnBackChangeBGColor(-1) //+
            
            if let stepArr = everyStep[currentStep]
            {
                turnBackShowVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
                turnBackIntroduceStep(stepArr[stepArr.count - 3])//+
                changeTempArrColor(-1, stepArr)
                turnBackChangeTempArrColor(-1, stepArr)//+
                
                changeLabelBG(-1)
                changeLabelBG(stepArr[stepArr.count - 3])
                
                if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
                {
                    turnBackShow_tempArr(false, stepArr)//+
                    controlStack += 1
                    
                }
                else if stepArr[stepArr.count - 3] > 8
                {
                    turnBackShow_tempArrNum(controlStack - 1, stepArr)//+
                    
                    if stepArr[stepArr.count - 3] == 14
                    {
                        changeBGColor(stepArr[stepArr.count - 6])
                        changeBGColor(stepArr[stepArr.count - 5])
                        turnBackChangeBGColor(stepArr[stepArr.count - 6])//+
                        turnBackChangeBGColor(stepArr[stepArr.count - 5])//+
                        
                    }else if stepArr[stepArr.count - 3] == 15 || stepArr[stepArr.count - 3] == 18 || stepArr[stepArr.count - 3] == 22 || stepArr[stepArr.count - 3] == 26 || stepArr[stepArr.count - 3] == 29
                    {
                        changeTempArrColor(controlStack - 1, stepArr)
                        turnBackChangeTempArrColor(controlStack - 1, stepArr)
                        
                    }
                }
            }
            
            if(currentStep >= everyStep.count)
            {
                nextStep.isEnabled = false
            }
        }
        
        /*
        currentStep += 1
        preStep.isEnabled = true
        
        showArr(everyStep[currentStep]!)
        //changeBG(everyStep[currentStep]!)
        //changeTextColor(everyStep[currentStep]!)
        //introduceStep(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        //showIJKey(everyStep[currentStep]!)
        
        changeBGColor(-1)
        turnBackChangeBGColor(-1) //+
        
        if let stepArr = everyStep[currentStep]
        {
            turnBackShowVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
            turnBackIntroduceStep(stepArr[stepArr.count - 3])//+
            changeTempArrColor(-1, stepArr)
            turnBackChangeTempArrColor(-1, stepArr)//+
            
            changeLabelBG(-1)
            changeLabelBG(stepArr[stepArr.count - 3])
            
            if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
            {
                turnBackShow_tempArr(false, stepArr)//+
                controlStack += 1
                
            }
            else if stepArr[stepArr.count - 3] > 8
            {
                turnBackShow_tempArrNum(controlStack - 1, stepArr)//+
                
                if stepArr[stepArr.count - 3] == 14
                {
                    changeBGColor(stepArr[stepArr.count - 6])
                    changeBGColor(stepArr[stepArr.count - 5])
                    turnBackChangeBGColor(stepArr[stepArr.count - 6])//+
                    turnBackChangeBGColor(stepArr[stepArr.count - 5])//+
                    
                }else if stepArr[stepArr.count - 3] == 15 || stepArr[stepArr.count - 3] == 18 || stepArr[stepArr.count - 3] == 22 || stepArr[stepArr.count - 3] == 26 || stepArr[stepArr.count - 3] == 29
                {
                    changeTempArrColor(controlStack - 1, stepArr)
                    turnBackChangeTempArrColor(controlStack - 1, stepArr)
                    
                }
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
        
        showArr(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        
        changeBGColor(-1)
        turnBackChangeBGColor(-1) //+
        
        if let stepArr = everyStep[currentStep + 1]
        {
            if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
            {
                controlStack -= 1
                turnBackShow_tempArr(true, everyStep[currentStep]!)
                
                
            }/*
              else if stepArr[stepArr.count - 3] > 8
              {
              show_tempArrNum(control - 1, everyStep[currentStep]!)
              }*/
            
        }
        
        if let stepArr = everyStep[currentStep]
        {
            turnBackShowVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
            turnBackIntroduceStep(stepArr[stepArr.count - 3])
            changeTempArrColor(-1, stepArr)
            turnBackChangeTempArrColor(-1, stepArr)//+
            
            changeLabelBG(-1)
            changeLabelBG(stepArr[stepArr.count - 3])
            
            if stepArr[stepArr.count - 3] > 8
            {
                turnBackShow_tempArrNum(controlStack - 1, stepArr)
            }
            
            if stepArr[stepArr.count - 3] == 14
            {
                changeBGColor(stepArr[stepArr.count - 6])
                changeBGColor(stepArr[stepArr.count - 5])
                turnBackChangeBGColor(stepArr[stepArr.count - 6])//+
                turnBackChangeBGColor(stepArr[stepArr.count - 5])//+
            }else if stepArr[stepArr.count - 3] == 15 || stepArr[stepArr.count - 3] == 18 || stepArr[stepArr.count - 3] == 22 || stepArr[stepArr.count - 3] == 26 || stepArr[stepArr.count - 3] == 29
            {
                changeTempArrColor(controlStack - 1, stepArr)
                turnBackChangeTempArrColor(controlStack - 1, stepArr)
                
            }
            
        }
        
        
        
        if(currentStep <= 1)
        {
            preStep.isEnabled = false
        }
    }
    
    
    
    func addInformationTodict(_ arr: Array<Int>, _ tempArr: Array<Int>, _ l: Int, _ middle: Int, _ r: Int, _ i: Int, _ j: Int, _ k: Int, _ step: Int, _ textBGColor: Int, _ textColor: Int)
    {
        var information = [Int](repeating: 0, count: arr.count + tempArr.count + 9)
        
        var index = 0
        while index < arr.count
        {
            information[index] = arr[index]
            index += 1
        }
        
        for i in 0..<tempArr.count
        {
            information[index] = tempArr[i]
            index += 1
        }
        
        information[information.count - 9] = l
        information[information.count - 8] = middle
        information[information.count - 7] = r
        information[information.count - 6] = i
        information[information.count - 5] = j
        information[information.count - 4] = k
        information[information.count - 3] = step
        information[information.count - 2] = textBGColor
        information[information.count - 1] = textColor
        everyStep[totalStep] = information
        totalStep += 1
    }
    
    func mergeSort(_ l: Int, _ r: Int)
    {
        //addInformationTodict(arr, -1, -1, 1, -1, -1)
        let temp = [Int](repeating: -1, count: 1)//﻿﻿為了﻿﻿傳﻿﻿﻿而傳的array﻿，﻿沒有﻿用途
        
        
        let middle = (l + r) / 2
        addInformationTodict(arr, temp, l, middle, r, -1, -1, -1, 2, -1, -1)
        
        addInformationTodict(arr, temp, l, middle, r, -1, -1, -1, 3, -1, -1)
        if l < r
        {
            addInformationTodict(arr, temp, l, middle, r, -1, -1, -1, 4, -1, -1)
            mergeSort(l, middle)
            addInformationTodict(arr, temp, l, middle, r, -1, -1, -1, 5, -1, -1)
            mergeSort(middle + 1, r)
            addInformationTodict(arr, temp, l, middle, r, -1, -1, -1, 6, -1, -1)
            merge(l, middle, r)
            //addInformationTodict(arr, l, middle, r, -1, -1, -1, 7, -1, -1)
            
            
        }
    }
    
    func merge(_ l: Int, _ middle: Int, _ r: Int)
    {
        var tempArr = [Int](repeating: 0, count: r - l + 1)
        addInformationTodict(arr, tempArr, l, middle, r, -1, -1, -1, 8, -1, -1)
        var i = l
        addInformationTodict(arr, tempArr, l, middle, r, i, -1, -1, 10, -1, -1)
        var j = middle + 1
        addInformationTodict(arr, tempArr, l, middle, r, i, j, -1, 11, -1, -1)
        var k = 0
        addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 12, -1, -1)
        
        while i <= middle && j <= r
        {
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 13, -1, -1)
            
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 14, -1, -1)
            if arr[i] < arr[j]
            {
                tempArr[k] = arr[i]
                addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 15, -1, -1)
                i += 1
                addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 16, -1, -1)
            }
            else
            {
                tempArr[k] = arr[j]
                addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 18, -1, -1)
                j += 1
                addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 19, -1, -1)
            }
            k += 1
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 20, -1, -1)
        }
        addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 13, -1, -1)
        
        while i <= middle
        {
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 21, -1, -1)
            
            tempArr[k] = arr[i]
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 22, -1, -1)
            k += 1
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 23, -1, -1)
            i += 1
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 24, -1, -1)
        }
        addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 21, -1, -1)
        
        while j <= r
        {
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 25, -1, -1)
            
            tempArr[k] = arr[j]
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 26, -1, -1)
            k += 1
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 27, -1, -1)
            j += 1
            addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 28, -1, -1)
        }
        addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 25, -1, -1)
        
        
        for index in 0..<tempArr.count
        {
            arr[index + l] = tempArr[index]
        }
        addInformationTodict(arr, tempArr, l, middle, r, i, j, k, 29, -1, -1)
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
        let temp = [Int](repeating: 0, count: 1)//﻿﻿為了﻿﻿傳﻿﻿﻿而傳的array﻿，﻿沒有﻿用途
        //addInformationTodict(arr, temp, -1, -1, -1, -1, -1, -1, -1, -1, -1)//﻿改過﻿﻿
        addInformationTodict(arr, temp, -1, -1, -1, -1, -1, -1, 0, -1, -1)
        mergeSort(0, arr.count - 1)
        return true
    }
    
    func checkNumeric(_ s: String) -> Bool
    {
       return Int(s) != nil
    }
    
    /*
    func showCurrArr(_ arr: Array<Int>)
    {
        text1.text = "\(arr[0])"
        text2.text = "\(arr[1])"
        text3.text = "\(arr[2])"
        text4.text = "\(arr[3])"
        text5.text = "\(arr[4])"
        text6.text = "\(arr[5])"
        text7.text = "\(arr[6])"
    }*/
    
    func showArr(_ inputArr: Array<Int>)
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
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
        controlStack = -1
        
        stepNum.text = "/"
        
        controlStack = 0
        
//        arr.removeAll()
        
        label1.backgroundColor = UIColor.white
        label2.backgroundColor = UIColor.white
        label3.backgroundColor = UIColor.white
        label4.backgroundColor = UIColor.white
        label5.backgroundColor = UIColor.white
        label6.backgroundColor = UIColor.white
        label7.backgroundColor = UIColor.white
        label8.backgroundColor = UIColor.white
        label9.backgroundColor = UIColor.white
        label10.backgroundColor = UIColor.white
        label11.backgroundColor = UIColor.white
        label12.backgroundColor = UIColor.white
        label13.backgroundColor = UIColor.white
        label14.backgroundColor = UIColor.white
        label15.backgroundColor = UIColor.white
        label16.backgroundColor = UIColor.white
        label17.backgroundColor = UIColor.white
        label18.backgroundColor = UIColor.white
        label19.backgroundColor = UIColor.white
        label20.backgroundColor = UIColor.white
        label21.backgroundColor = UIColor.white
        label22.backgroundColor = UIColor.white
        label23.backgroundColor = UIColor.white
        label24.backgroundColor = UIColor.white
        label25.backgroundColor = UIColor.white
        label26.backgroundColor = UIColor.white
        label27.backgroundColor = UIColor.white
        label28.backgroundColor = UIColor.white
        label29.backgroundColor = UIColor.white
        label30.backgroundColor = UIColor.white
        label31.backgroundColor = UIColor.white
        
        text1.textColor = color_array_text
        text2.textColor = color_array_text
        text3.textColor = color_array_text
        text4.textColor = color_array_text
        text5.textColor = color_array_text
        text6.textColor = color_array_text
        text7.textColor = color_array_text
        text1.backgroundColor = color_array_bg
        text2.backgroundColor = color_array_bg
        text3.backgroundColor = color_array_bg
        text4.backgroundColor = color_array_bg
        text5.backgroundColor = color_array_bg
        text6.backgroundColor = color_array_bg
        text7.backgroundColor = color_array_bg
    }
    
    
    func changeTempArrColor(_ control: Int, _ arr: Array<Int>)
    {
        let k = arr[arr.count - 4]
        
        switch control
        {
        case 4:
            //text41.text = "\(arr[7])"
            //text42.text = "\(arr[8])"
            switch k
            {
            case 0:
                break
                //                text41.textColor = color_text_highlighter
            case 1:
                break
                //                text42.textColor = color_text_highlighter
            default:
                //text41.textColor = color_array_text
                //text42.textColor = color_array_text
                text1.textColor = color_text_highlighter
                text2.textColor = color_text_highlighter
            }
        case 8:
            //text43.text = "\(arr[7])"
            //text44.text = "\(arr[8])"
            switch k
            {
            case 0:
                break
                //                text43.textColor = color_text_highlighter
            case 1:
                break
                //                text44.textColor = color_text_highlighter
            default:
                //text43.textColor = color_array_text
                //text44.textColor = color_array_text
                text3.textColor = color_text_highlighter
                text4.textColor = color_text_highlighter
            }
        case 9:
            /*text51.text = "\(arr[7])"
             text52.text = "\(arr[8])"
             text53.text = "\(arr[9])"
             text54.text = "\(arr[10])"*/
            switch k
            {
            case 0:
                break
                //                text51.textColor = color_text_highlighter
            case 1:
                break
                //                text52.textColor = color_text_highlighter
            case 2:
                break
                //                text53.textColor = color_text_highlighter
            case 3:
                break
                //                text54.textColor = color_text_highlighter
            default:
                //text51.textColor = color_array_text
                //text52.textColor = color_array_text
                //text53.textColor = color_array_text
                //text54.textColor = color_array_text
                text1.textColor = color_text_highlighter
                text2.textColor = color_text_highlighter
                text3.textColor = color_text_highlighter
                text4.textColor = color_text_highlighter
            }
        case 14:
            //text45.text = "\(arr[7])"
            //text46.text = "\(arr[8])"
            switch k
            {
            case 0:
                break
                //                text45.textColor = color_text_highlighter
            case 1:
                break
                //                text46.textColor = color_text_highlighter
            default:
                //text45.textColor = color_array_text
                //text46.textColor = color_array_text
                text5.textColor = color_text_highlighter
                text6.textColor = color_text_highlighter
            }
        case 16:
            //text55.text = "\(arr[7])"
            //text56.text = "\(arr[8])"
            //text57.text = "\(arr[9])"
            switch k
            {
            case 0:
                break
                //                text55.textColor = color_text_highlighter
            case 1:
                break
                //                text56.textColor = color_text_highlighter
            case 2:
                break
                //                text57.textColor = color_text_highlighter
            default:
                //text55.textColor = color_array_text
                //text56.textColor = color_array_text
                //text57.textColor = color_array_text
                text5.textColor = color_text_highlighter
                text6.textColor = color_text_highlighter
                text7.textColor = color_text_highlighter
            }
        case 17:
            /*text61.text = "\(arr[7])"
             text62.text = "\(arr[8])"
             text63.text = "\(arr[9])"
             text64.text = "\(arr[10])"
             text65.text = "\(arr[11])"
             text66.text = "\(arr[12])"
             text67.text = "\(arr[13])"*/
            switch k
            {
            case 0:
                break
                //                text61.textColor = color_text_highlighter
            case 1:
                break
                //                text62.textColor = color_text_highlighter
            case 2:
                break
                //                text63.textColor = color_text_highlighter
            case 3:
                break
                //                text64.textColor = color_text_highlighter
            case 4:
                break
                //                text65.textColor = color_text_highlighter
            case 5:
                break
                //                text66.textColor = color_text_highlighter
            case 6:
                break
                //                text67.textColor = color_text_highlighter
            default:
                /*text61.textColor = color_array_text
                 text62.textColor = color_array_text
                 text63.textColor = color_array_text
                 text64.textColor = color_array_text
                 text65.textColor = color_array_text
                 text66.textColor = color_array_text
                 text67.textColor = color_array_text*/
                text1.textColor = color_text_highlighter
                text2.textColor = color_text_highlighter
                text3.textColor = color_text_highlighter
                text4.textColor = color_text_highlighter
                text4.textColor = color_text_highlighter
                text5.textColor = color_text_highlighter
                text6.textColor = color_text_highlighter
                text7.textColor = color_text_highlighter
            }
        default:
            //            text41.textColor = color_array_text
            //            text42.textColor = color_array_text
            //            text43.textColor = color_array_text
            //            text44.textColor = color_array_text
            //            text51.textColor = color_array_text
            //            text52.textColor = color_array_text
            //            text53.textColor = color_array_text
            //            text54.textColor = color_array_text
            //            text45.textColor = color_array_text
            //            text46.textColor = color_array_text
            //            text55.textColor = color_array_text
            //            text56.textColor = color_array_text
            //            text57.textColor = color_array_text
            //            text61.textColor = color_array_text
            //            text62.textColor = color_array_text
            //            text63.textColor = color_array_text
            //            text64.textColor = color_array_text
            //            text65.textColor = color_array_text
            //            text66.textColor = color_array_text
            //            text67.textColor = color_array_text
            
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        }
        
    }
    
    func changeBGColor(_ num1: Int)
    {
        //var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            text1.backgroundColor = color_bg_highlighter
        case 1:
            text2.backgroundColor = color_bg_highlighter
        case 2:
            text3.backgroundColor = color_bg_highlighter
        case 3:
            text4.backgroundColor = color_bg_highlighter
        case 4:
            text5.backgroundColor = color_bg_highlighter
        case 5:
            text6.backgroundColor = color_bg_highlighter
        case 6:
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
    
    func changeLabelBG(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            label1.backgroundColor = color_bg_highlighter
        case 2:
            label3.backgroundColor = color_bg_highlighter
        case 3:
            label4.backgroundColor = color_bg_highlighter
        case 4:
            label5.backgroundColor = color_bg_highlighter
        case 5:
            label6.backgroundColor = color_bg_highlighter
        case 6:
            label7.backgroundColor = color_bg_highlighter
        case 8:
            label9.backgroundColor = color_bg_highlighter
            label10.backgroundColor = color_bg_highlighter
        case 10:
            label11.backgroundColor = color_bg_highlighter
        case 11:
            label12.backgroundColor = color_bg_highlighter
        case 12:
            label13.backgroundColor = color_bg_highlighter
        case 13:
            label14.backgroundColor = color_bg_highlighter
        case 14:
            label15.backgroundColor = color_bg_highlighter
        case 15:
            label16.backgroundColor = color_bg_highlighter
        case 16:
            label17.backgroundColor = color_bg_highlighter
        case 18:
            label19.backgroundColor = color_bg_highlighter
        case 19:
            label20.backgroundColor = color_bg_highlighter
        case 20:
            label21.backgroundColor = color_bg_highlighter
        case 21:
            label22.backgroundColor = color_bg_highlighter
        case 22:
            label23.backgroundColor = color_bg_highlighter
        case 23:
            label24.backgroundColor = color_bg_highlighter
        case 24:
            label25.backgroundColor = color_bg_highlighter
        case 25:
            label26.backgroundColor = color_bg_highlighter
        case 26:
            label27.backgroundColor = color_bg_highlighter
        case 27:
            label28.backgroundColor = color_bg_highlighter
        case 28:
            label29.backgroundColor = color_bg_highlighter
        case 29:
            label30.backgroundColor = color_bg_highlighter
            label31.backgroundColor = color_bg_highlighter
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
            label10.backgroundColor = UIColor.white
            label11.backgroundColor = UIColor.white
            label12.backgroundColor = UIColor.white
            label13.backgroundColor = UIColor.white
            label14.backgroundColor = UIColor.white
            label15.backgroundColor = UIColor.white
            label16.backgroundColor = UIColor.white
            label17.backgroundColor = UIColor.white
            label18.backgroundColor = UIColor.white
            label19.backgroundColor = UIColor.white
            label20.backgroundColor = UIColor.white
            label21.backgroundColor = UIColor.white
            label22.backgroundColor = UIColor.white
            label23.backgroundColor = UIColor.white
            label24.backgroundColor = UIColor.white
            label25.backgroundColor = UIColor.white
            label26.backgroundColor = UIColor.white
            label27.backgroundColor = UIColor.white
            label28.backgroundColor = UIColor.white
            label29.backgroundColor = UIColor.white
            label30.backgroundColor = UIColor.white
            label31.backgroundColor = UIColor.white
        }
    }
    
    
    func turnBackResetArr(){
        previousVC!.stack11.isHidden = true
        previousVC!.stack21.isHidden = true
        previousVC!.stack31.isHidden = true
        previousVC!.stack32.isHidden = true
        previousVC!.stack41.isHidden = true
        previousVC!.stack22.isHidden = true
        previousVC!.stack33.isHidden = true
        previousVC!.stack34.isHidden = true
        previousVC!.stack42.isHidden = true
        previousVC!.stack51.isHidden = true
        previousVC!.stack12.isHidden = true
        previousVC!.stack23.isHidden = true
        previousVC!.stack35.isHidden = true
        previousVC!.stack36.isHidden = true
        previousVC!.stack43.isHidden = true
        previousVC!.stack24.isHidden = true
        previousVC!.stack52.isHidden = true
        previousVC!.stack6.isHidden = true
        
        previousVC!.text41.text = "0"
        previousVC!.text42.text = "0"
        previousVC!.text43.text = "0"
        previousVC!.text44.text = "0"
        previousVC!.text51.text = "0"
        previousVC!.text52.text = "0"
        previousVC!.text53.text = "0"
        previousVC!.text54.text = "0"
        previousVC!.text45.text = "0"
        previousVC!.text46.text = "0"
        previousVC!.text55.text = "0"
        previousVC!.text56.text = "0"
        previousVC!.text57.text = "0"
        previousVC!.text61.text = "0"
        previousVC!.text62.text = "0"
        previousVC!.text63.text = "0"
        previousVC!.text64.text = "0"
        previousVC!.text65.text = "0"
        previousVC!.text66.text = "0"
        previousVC!.text67.text = "0"
        
        previousVC!.text1.textColor = color_array_text
        previousVC!.text2.textColor = color_array_text
        previousVC!.text3.textColor = color_array_text
        previousVC!.text4.textColor = color_array_text
        previousVC!.text5.textColor = color_array_text
        previousVC!.text6.textColor = color_array_text
        previousVC!.text7.textColor = color_array_text
        previousVC!.text1.backgroundColor = color_array_bg
        previousVC!.text2.backgroundColor = color_array_bg
        previousVC!.text3.backgroundColor = color_array_bg
        previousVC!.text4.backgroundColor = color_array_bg
        previousVC!.text5.backgroundColor = color_array_bg
        previousVC!.text6.backgroundColor = color_array_bg
        previousVC!.text7.backgroundColor = color_array_bg
    }
    
    
    
    
    
    func turnBackClear (){
        previousVC!.totalStep = 1
        previousVC!.everyStep.removeAll()
        previousVC!.currentStep = 0
        previousVC!.controlStack = -1
//        previousVC!.arr.removeAll()
        
        
        previousVC!.introduce.text = ""
        previousVC!.stepNum.text = "/"
        previousVC!.iLabel.text = "i = "
        previousVC!.jLabel.text = "j = "
        previousVC!.kLabel.text = "k = "
        previousVC!.lLabel.text = "l = "
        previousVC!.mLabel.text = "middle = "
        previousVC!.rLabel.text = "r = "
        
        turnBackChangeBGColor(-1)
        turnBackChangeTempArrColor(-1, [-1, -1, -1, -1])//﻿因為﻿函﻿﻿式﻿有.count - 4
//        turnBackShow_tempArr(true, [-1])
        
        previousVC!.controlStack = 0
        
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
        
        previousVC!.stack11.isHidden = true
        previousVC!.stack21.isHidden = true
        previousVC!.stack31.isHidden = true
        previousVC!.stack32.isHidden = true
        previousVC!.stack41.isHidden = true
        previousVC!.stack22.isHidden = true
        previousVC!.stack33.isHidden = true
        previousVC!.stack34.isHidden = true
        previousVC!.stack42.isHidden = true
        previousVC!.stack51.isHidden = true
        previousVC!.stack12.isHidden = true
        previousVC!.stack23.isHidden = true
        previousVC!.stack35.isHidden = true
        previousVC!.stack36.isHidden = true
        previousVC!.stack43.isHidden = true
        previousVC!.stack24.isHidden = true
        previousVC!.stack52.isHidden = true
        previousVC!.stack6.isHidden = true
        
        previousVC!.text41.text = "0"
        previousVC!.text42.text = "0"
        previousVC!.text43.text = "0"
        previousVC!.text44.text = "0"
        previousVC!.text51.text = "0"
        previousVC!.text52.text = "0"
        previousVC!.text53.text = "0"
        previousVC!.text54.text = "0"
        previousVC!.text45.text = "0"
        previousVC!.text46.text = "0"
        previousVC!.text55.text = "0"
        previousVC!.text56.text = "0"
        previousVC!.text57.text = "0"
        previousVC!.text61.text = "0"
        previousVC!.text62.text = "0"
        previousVC!.text63.text = "0"
        previousVC!.text64.text = "0"
        previousVC!.text65.text = "0"
        previousVC!.text66.text = "0"
        previousVC!.text67.text = "0"
        
        previousVC!.text1.textColor = color_array_text
        previousVC!.text2.textColor = color_array_text
        previousVC!.text3.textColor = color_array_text
        previousVC!.text4.textColor = color_array_text
        previousVC!.text5.textColor = color_array_text
        previousVC!.text6.textColor = color_array_text
        previousVC!.text7.textColor = color_array_text
        previousVC!.text1.backgroundColor = color_array_bg
        previousVC!.text2.backgroundColor = color_array_bg
        previousVC!.text3.backgroundColor = color_array_bg
        previousVC!.text4.backgroundColor = color_array_bg
        previousVC!.text5.backgroundColor = color_array_bg
        previousVC!.text6.backgroundColor = color_array_bg
        previousVC!.text7.backgroundColor = color_array_bg
        


    }
    
    func turnBackChangeTempArrColor(_ control: Int, _ arr: Array<Int>)
    {
        let k = arr[arr.count - 4]
        
        switch control
        {
        case 4:
            //text41.text = "\(arr[7])"
            //text42.text = "\(arr[8])"
            switch k
            {
            case 0:
                previousVC!.text41.textColor = color_text_highlighter
            case 1:
                previousVC!.text42.textColor = color_text_highlighter
            default:
                //text41.textColor = color_array_text
                //text42.textColor = color_array_text
                previousVC!.text1.textColor = color_text_highlighter
                previousVC!.text2.textColor = color_text_highlighter
            }
        case 8:
            //text43.text = "\(arr[7])"
            //text44.text = "\(arr[8])"
            switch k
            {
            case 0:
                previousVC!.text43.textColor = color_text_highlighter
            case 1:
                previousVC!.text44.textColor = color_text_highlighter
            default:
                //text43.textColor = color_array_text
                //text44.textColor = color_array_text
                previousVC!.text3.textColor = color_text_highlighter
                previousVC!.text4.textColor = color_text_highlighter
            }
        case 9:
            /*text51.text = "\(arr[7])"
            text52.text = "\(arr[8])"
            text53.text = "\(arr[9])"
            text54.text = "\(arr[10])"*/
            switch k
            {
            case 0:
                previousVC!.text51.textColor = color_text_highlighter
            case 1:
                previousVC!.text52.textColor = color_text_highlighter
            case 2:
                previousVC!.text53.textColor = color_text_highlighter
            case 3:
                previousVC!.text54.textColor = color_text_highlighter
            default:
                //text51.textColor = color_array_text
                //text52.textColor = color_array_text
                //text53.textColor = color_array_text
                //text54.textColor = color_array_text
                previousVC!.text1.textColor = color_text_highlighter
                previousVC!.text2.textColor = color_text_highlighter
                previousVC!.text3.textColor = color_text_highlighter
                previousVC!.text4.textColor = color_text_highlighter
            }
        case 14:
            //text45.text = "\(arr[7])"
            //text46.text = "\(arr[8])"
            switch k
            {
            case 0:
                previousVC!.text45.textColor = color_text_highlighter
            case 1:
                previousVC!.text46.textColor = color_text_highlighter
            default:
                //text45.textColor = color_array_text
                //text46.textColor = color_array_text
                previousVC!.text5.textColor = color_text_highlighter
                previousVC!.text6.textColor = color_text_highlighter
            }
        case 16:
            //text55.text = "\(arr[7])"
            //text56.text = "\(arr[8])"
            //text57.text = "\(arr[9])"
            switch k
            {
            case 0:
                previousVC!.text55.textColor = color_text_highlighter
            case 1:
                previousVC!.text56.textColor = color_text_highlighter
            case 2:
                previousVC!.text57.textColor = color_text_highlighter
            default:
                //text55.textColor = color_array_text
                //text56.textColor = color_array_text
                //text57.textColor = color_array_text
                previousVC!.text5.textColor = color_text_highlighter
                previousVC!.text6.textColor = color_text_highlighter
                previousVC!.text7.textColor = color_text_highlighter
            }
        case 17:
            /*text61.text = "\(arr[7])"
            text62.text = "\(arr[8])"
            text63.text = "\(arr[9])"
            text64.text = "\(arr[10])"
            text65.text = "\(arr[11])"
            text66.text = "\(arr[12])"
            text67.text = "\(arr[13])"*/
            switch k
            {
            case 0:
                previousVC!.text61.textColor = color_text_highlighter
            case 1:
                previousVC!.text62.textColor = color_text_highlighter
            case 2:
                previousVC!.text63.textColor = color_text_highlighter
            case 3:
                previousVC!.text64.textColor = color_text_highlighter
            case 4:
                previousVC!.text65.textColor = color_text_highlighter
            case 5:
                previousVC!.text66.textColor = color_text_highlighter
            case 6:
                previousVC!.text67.textColor = color_text_highlighter
            default:
                /*text61.textColor = color_array_text
                text62.textColor = color_array_text
                text63.textColor = color_array_text
                text64.textColor = color_array_text
                text65.textColor = color_array_text
                text66.textColor = color_array_text
                text67.textColor = color_array_text*/
                previousVC!.text1.textColor = color_text_highlighter
                previousVC!.text2.textColor = color_text_highlighter
                previousVC!.text3.textColor = color_text_highlighter
                previousVC!.text4.textColor = color_text_highlighter
                previousVC!.text4.textColor = color_text_highlighter
                previousVC!.text5.textColor = color_text_highlighter
                previousVC!.text6.textColor = color_text_highlighter
                previousVC!.text7.textColor = color_text_highlighter
            }
        default:
            previousVC!.text41.textColor = color_array_text
            previousVC!.text42.textColor = color_array_text
            previousVC!.text43.textColor = color_array_text
            previousVC!.text44.textColor = color_array_text
            previousVC!.text51.textColor = color_array_text
            previousVC!.text52.textColor = color_array_text
            previousVC!.text53.textColor = color_array_text
            previousVC!.text54.textColor = color_array_text
            previousVC!.text45.textColor = color_array_text
            previousVC!.text46.textColor = color_array_text
            previousVC!.text55.textColor = color_array_text
            previousVC!.text56.textColor = color_array_text
            previousVC!.text57.textColor = color_array_text
            previousVC!.text61.textColor = color_array_text
            previousVC!.text62.textColor = color_array_text
            previousVC!.text63.textColor = color_array_text
            previousVC!.text64.textColor = color_array_text
            previousVC!.text65.textColor = color_array_text
            previousVC!.text66.textColor = color_array_text
            previousVC!.text67.textColor = color_array_text
            
            previousVC!.text1.textColor = color_array_text
            previousVC!.text2.textColor = color_array_text
            previousVC!.text3.textColor = color_array_text
            previousVC!.text4.textColor = color_array_text
            previousVC!.text5.textColor = color_array_text
            previousVC!.text6.textColor = color_array_text
            previousVC!.text7.textColor = color_array_text
        }
        
    }
    
    func turnBackShow_tempArrNum(_ control: Int, _ arr: Array<Int>)
    {
        let k = arr[arr.count - 4]
        
        switch control
        {
        case 4:
            previousVC!.text41.text = "\(arr[7])"
            previousVC!.text42.text = "\(arr[8])"
        case 8:
            previousVC!.text43.text = "\(arr[7])"
            previousVC!.text44.text = "\(arr[8])"
        case 9:
            previousVC!.text51.text = "\(arr[7])"
            previousVC!.text52.text = "\(arr[8])"
            previousVC!.text53.text = "\(arr[9])"
            previousVC!.text54.text = "\(arr[10])"
        case 14:
            previousVC!.text45.text = "\(arr[7])"
            previousVC!.text46.text = "\(arr[8])"
        case 16:
            previousVC!.text55.text = "\(arr[7])"
            previousVC!.text56.text = "\(arr[8])"
            previousVC!.text57.text = "\(arr[9])"
        case 17:
            previousVC!.text61.text = "\(arr[7])"
            previousVC!.text62.text = "\(arr[8])"
            previousVC!.text63.text = "\(arr[9])"
            previousVC!.text64.text = "\(arr[10])"
            previousVC!.text65.text = "\(arr[11])"
            previousVC!.text66.text = "\(arr[12])"
            previousVC!.text67.text = "\(arr[13])"
        default:
            previousVC!.text41.text = "0"
            previousVC!.text42.text = "0"
            previousVC!.text43.text = "0"
            previousVC!.text44.text = "0"
            previousVC!.text51.text = "0"
            previousVC!.text52.text = "0"
            previousVC!.text53.text = "0"
            previousVC!.text54.text = "0"
            previousVC!.text45.text = "0"
            previousVC!.text46.text = "0"
            previousVC!.text55.text = "0"
            previousVC!.text56.text = "0"
            previousVC!.text57.text = "0"
            previousVC!.text61.text = "0"
            previousVC!.text62.text = "0"
            previousVC!.text63.text = "0"
            previousVC!.text64.text = "0"
            previousVC!.text65.text = "0"
            previousVC!.text66.text = "0"
            previousVC!.text67.text = "0"
            
        }
        
    }
    
    
    func turnBackShow_tempArr(_ isHidd: Bool, _ arr: Array<Int>)
    {
        
        switch controlStack
        {
        case 0:
            previousVC!.stack11.isHidden = isHidd
            previousVC!.text11.text = "\(arr[0])"
            previousVC!.text12.text = "\(arr[1])"
            previousVC!.text13.text = "\(arr[2])"
            previousVC!.text14.text = "\(arr[3])"
        case 1:
            previousVC!.stack21.isHidden = isHidd
            previousVC!.text21.text = "\(arr[0])"
            previousVC!.text22.text = "\(arr[1])"
        case 2:
            previousVC!.stack31.isHidden = isHidd
            previousVC!.text31.text = "\(arr[0])"
        case 3:
            previousVC!.stack32.isHidden = isHidd
            previousVC!.text32.text = "\(arr[1])"
        case 4:
            previousVC!.stack41.isHidden = isHidd
            previousVC!.text41.text = "0"
            previousVC!.text42.text = "0"
        case 5:
            previousVC!.stack22.isHidden = isHidd
            previousVC!.text23.text = "\(arr[2])"
            previousVC!.text24.text = "\(arr[3])"
        case 6:
            previousVC!.stack33.isHidden = isHidd
            previousVC!.text33.text = "\(arr[2])"
        case 7:
            previousVC!.stack34.isHidden = isHidd
            previousVC!.text34.text = "\(arr[3])"
        case 8:
            previousVC!.stack42.isHidden = isHidd
            previousVC!.text43.text = "0"
            previousVC!.text44.text = "0"
        case 9:
            previousVC!.stack51.isHidden = isHidd
            previousVC!.text51.text = "0"
            previousVC!.text52.text = "0"
            previousVC!.text53.text = "0"
            previousVC!.text54.text = "0"
        case 10:
            previousVC!.stack12.isHidden = isHidd
            previousVC!.text15.text = "\(arr[4])"
            previousVC!.text16.text = "\(arr[5])"
            previousVC!.text17.text = "\(arr[6])"
        case 11:
            previousVC!.stack23.isHidden = isHidd
            previousVC!.text25.text = "\(arr[4])"
            previousVC!.text26.text = "\(arr[5])"
        case 12:
            previousVC!.stack35.isHidden = isHidd
            previousVC!.text35.text = "\(arr[4])"
        case 13:
            previousVC!.stack36.isHidden = isHidd
            previousVC!.text36.text = "\(arr[5])"
        case 14:
            previousVC!.stack43.isHidden = isHidd
            previousVC!.text45.text = "0"
            previousVC!.text46.text = "0"
        case 15:
            previousVC!.stack24.isHidden = isHidd
            previousVC!.text27.text = "\(arr[6])"
        case 16:
            previousVC!.stack52.isHidden = isHidd
            previousVC!.text55.text = "0"
            previousVC!.text56.text = "0"
            previousVC!.text57.text = "0"
        case 17:
            previousVC!.stack6.isHidden = isHidd
            previousVC!.text61.text = "0"
            previousVC!.text62.text = "0"
            previousVC!.text63.text = "0"
            previousVC!.text64.text = "0"
            previousVC!.text65.text = "0"
            previousVC!.text66.text = "0"
            previousVC!.text67.text = "0"
        default:
            previousVC!.stack11.isHidden = isHidd
            previousVC!.stack21.isHidden = isHidd
            previousVC!.stack31.isHidden = isHidd
            previousVC!.stack32.isHidden = isHidd
            previousVC!.stack41.isHidden = isHidd
            previousVC!.stack22.isHidden = isHidd
            previousVC!.stack33.isHidden = isHidd
            previousVC!.stack34.isHidden = isHidd
            previousVC!.stack42.isHidden = isHidd
            previousVC!.stack51.isHidden = isHidd
            previousVC!.stack12.isHidden = isHidd
            previousVC!.stack23.isHidden = isHidd
            previousVC!.stack35.isHidden = isHidd
            previousVC!.stack36.isHidden = isHidd
            previousVC!.stack43.isHidden = isHidd
            previousVC!.stack24.isHidden = isHidd
            previousVC!.stack52.isHidden = isHidd
            previousVC!.stack6.isHidden = isHidd
            
        }
            
    }
    
    func turnBackShowVar(_ l: Int, _ middle: Int, _ r: Int, _ i: Int, _ j: Int, _ k: Int)
    {
        if l != -1
        {
            previousVC!.lLabel.text  = "l = \(l + 1)"
        }
        else
        {
            previousVC!.lLabel.text = "l = ?"
        }
        
        if middle != -1
        {
            previousVC!.mLabel.text = "middle = \(middle + 1)"
        }
        else
        {
            previousVC!.mLabel.text = "middle = ?"
        }
        
        if r != -1
        {
            previousVC!.rLabel.text = "r = \(r + 1)"
        }
        else
        {
            previousVC!.rLabel.text = "r = ?"
        }
        
        if i != -1
        {
            previousVC!.iLabel.text = "i = \(i + 1)"
        }
        else
        {
            previousVC!.iLabel.text = "i = ?"
        }
        
        if j != -1
        {
            previousVC!.jLabel.text = "j = \(j + 1)"
        }
        else
        {
            previousVC!.jLabel.text = "j = ?"
        }
        
        if k != -1
        {
            previousVC!.kLabel.text = "k = \(k + 1)"
        }
        else
        {
            previousVC!.kLabel.text = "k = ?"
        }
    }
    
    func turnBackChangeBGColor(_ num1: Int)
    {
        //var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            previousVC!.text1.backgroundColor = color_bg_highlighter
        case 1:
            previousVC!.text2.backgroundColor = color_bg_highlighter
        case 2:
            previousVC!.text3.backgroundColor = color_bg_highlighter
        case 3:
            previousVC!.text4.backgroundColor = color_bg_highlighter
        case 4:
            previousVC!.text5.backgroundColor = color_bg_highlighter
        case 5:
            previousVC!.text6.backgroundColor = color_bg_highlighter
        case 6:
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
    
    func turnBackIntroduceStep(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            previousVC!.introduce.text = "﻿呼叫mergeSort﻿﻿函式﻿，﻿並﻿將1和﻿A﻿陣列﻿長度﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 2:
            previousVC!.introduce.text = "﻿﻿﻿﻿將(l + r) / 2﻿﻿ 的﻿值﻿給middle﻿"
        case 3:
            previousVC!.introduce.text = "﻿比較l是否﻿﻿小於r"
        case 4:
            previousVC!.introduce.text = "﻿﻿呼叫mergeSort﻿﻿函式﻿，﻿並﻿將l和﻿middle﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 5:
            previousVC!.introduce.text = "﻿呼叫mergeSort﻿﻿函式﻿，﻿並﻿將middle + 1和﻿r﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 6:
            previousVC!.introduce.text = "呼叫merge函式﻿，﻿並﻿將l﻿﻿、middle﻿﻿、﻿r﻿的﻿﻿值﻿﻿傳入"
        case 8:
            previousVC!.introduce.text = "﻿﻿﻿將tempArr﻿﻿先﻿全部﻿放0"
        case 10:
            previousVC!.introduce.text = "﻿將l的值﻿﻿﻿給i"
        case 11:
            previousVC!.introduce.text = "將middle + 1的值﻿﻿﻿給j"
        case 12:
            previousVC!.introduce.text = "﻿將k的值﻿﻿﻿﻿為1"
        case 13:
            previousVC!.introduce.text = "﻿﻿判斷目前﻿i是否﻿小於﻿﻿﻿等於middle﻿﻿，﻿且﻿j﻿小﻿於﻿等於r，﻿是則﻿執行迴圈﻿，﻿否則﻿離開"
        case 14:
            previousVC!.introduce.text = "比較A[i]是否﻿﻿小於A[j]"
        case 15:
            previousVC!.introduce.text = "﻿﻿將A[i]的值﻿﻿﻿給tempArr[k]"
        case 16:
            previousVC!.introduce.text = "﻿﻿將i的值﻿﻿﻿﻿﻿加1"
        case 18:
            previousVC!.introduce.text = "﻿﻿﻿A[i]﻿不小於A[j]﻿，將A[j]的值﻿﻿﻿給tempArr[k]"
        case 19:
            previousVC!.introduce.text = "將j的值﻿﻿﻿﻿﻿加1"
        case 20:
            previousVC!.introduce.text = "﻿將k的值﻿﻿﻿﻿﻿加1"
        case 21:
            previousVC!.introduce.text = "﻿﻿判斷目前﻿i是否﻿小於﻿﻿﻿等於middle﻿﻿，﻿是則﻿執行迴圈﻿，﻿否則﻿離開"
        case 22:
            previousVC!.introduce.text = "將A[i]的值﻿﻿﻿給tempArr[k]"
        case 23:
            previousVC!.introduce.text = "﻿﻿將k的值﻿﻿﻿﻿﻿加1"
        case 24:
            previousVC!.introduce.text = "﻿﻿將i的值﻿﻿﻿﻿﻿加1"
        case 25:
            previousVC!.introduce.text = "﻿﻿判斷目前﻿j是否﻿小於﻿﻿﻿等於r，﻿是則﻿執行迴圈﻿，﻿否則﻿離開"
        case 26:
            previousVC!.introduce.text = "將A[j]的值﻿﻿﻿給tempArr[k]"
        case 27:
            previousVC!.introduce.text = "﻿﻿將k的值﻿﻿﻿﻿﻿加1"
        case 28:
            previousVC!.introduce.text = "﻿﻿將j的值﻿﻿﻿﻿﻿加1"
        case 29:
            previousVC!.introduce.text = "﻿﻿將tempArr﻿﻿排序﻿好的值﻿放回﻿A﻿陣列"
        default:
            previousVC!.introduce.text = ""
        }
        
    }
    
    func turnBackShowCurrArr(_ arr: Array<Int>)
    {
        previousVC!.text1.text = "\(arr[0])"
        previousVC!.text2.text = "\(arr[1])"
        previousVC!.text3.text = "\(arr[2])"
        previousVC!.text4.text = "\(arr[3])"
        previousVC!.text5.text = "\(arr[4])"
        previousVC!.text6.text = "\(arr[5])"
        previousVC!.text7.text = "\(arr[6])"
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


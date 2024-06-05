//
//  MergeSortSimulation.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/23.
//

import UIKit
import SideMenu

class MergeSortSimulation: UIViewController, MenuControllerDelegate{
    
    var sideMenu: SideMenuNavigationController?
    
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!
    var textFields: [UITextField] = []
    
    @IBOutlet var text11: UITextField!
    @IBOutlet var text12: UITextField!
    @IBOutlet var text13: UITextField!
    @IBOutlet var text14: UITextField!
    @IBOutlet var text15: UITextField!
    @IBOutlet var text16: UITextField!
    @IBOutlet var text17: UITextField!
    @IBOutlet var text21: UITextField!
    @IBOutlet var text22: UITextField!
    @IBOutlet var text23: UITextField!
    @IBOutlet var text24: UITextField!
    @IBOutlet var text25: UITextField!
    @IBOutlet var text26: UITextField!
    @IBOutlet var text27: UITextField!
    @IBOutlet var text31: UITextField!
    @IBOutlet var text32: UITextField!
    @IBOutlet var text33: UITextField!
    @IBOutlet var text34: UITextField!
    @IBOutlet var text35: UITextField!
    @IBOutlet var text36: UITextField!
    @IBOutlet var text37: UITextField!
    @IBOutlet var text41: UITextField!
    @IBOutlet var text42: UITextField!
    @IBOutlet var text43: UITextField!
    @IBOutlet var text44: UITextField!
    @IBOutlet var text45: UITextField!
    @IBOutlet var text46: UITextField!
    @IBOutlet var text47: UITextField!
    @IBOutlet var text51: UITextField!
    @IBOutlet var text52: UITextField!
    @IBOutlet var text53: UITextField!
    @IBOutlet var text54: UITextField!
    @IBOutlet var text55: UITextField!
    @IBOutlet var text56: UITextField!
    @IBOutlet var text57: UITextField!
    @IBOutlet var text61: UITextField!
    @IBOutlet var text62: UITextField!
    @IBOutlet var text63: UITextField!
    @IBOutlet var text64: UITextField!
    @IBOutlet var text65: UITextField!
    @IBOutlet var text66: UITextField!
    @IBOutlet var text67: UITextField!
    
    @IBOutlet var introduce: UILabel!
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var lLabel: UILabel!
    @IBOutlet var mLabel: UILabel!
    @IBOutlet var rLabel: UILabel!
    @IBOutlet var iLabel: UILabel!
    @IBOutlet var jLabel: UILabel!
    @IBOutlet var kLabel: UILabel!
    @IBOutlet var principle: UILabel!
    
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    @IBOutlet var clear: UIButton!
    
    @IBOutlet var stack11: UIStackView!
    @IBOutlet var stack12: UIStackView!
    
    @IBOutlet var stack21: UIStackView!
    @IBOutlet var stack22: UIStackView!
    @IBOutlet var stack23: UIStackView!
    @IBOutlet var stack24: UIStackView!
    
    @IBOutlet var stack31: UIStackView!
    @IBOutlet var stack32: UIStackView!
    @IBOutlet var stack33: UIStackView!
    @IBOutlet var stack34: UIStackView!
    @IBOutlet var stack35: UIStackView!
    @IBOutlet var stack36: UIStackView!
//    @IBOutlet var stack37: UIStackView!
    
    @IBOutlet var stack41: UIStackView!
    @IBOutlet var stack42: UIStackView!
    @IBOutlet var stack43: UIStackView!
//    @IBOutlet var stack44: UIStackView!
    
    @IBOutlet var stack51: UIStackView!
    @IBOutlet var stack52: UIStackView!
    
    @IBOutlet var stack6: UIStackView!
    
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

        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            let menu = MenuController(with: ["模擬","練習","相關程式碼","相關影片","回到排序選擇畫面"])
            
            menu.delegate = self
            
            sideMenu = SideMenuNavigationController(rootViewController: menu)
            sideMenu?.leftSide = true
            SideMenuManager.default.leftMenuNavigationController = sideMenu
            SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        }
    
    @IBAction func goToSortSourceCode(_ sender: UIButton) {
        performSegue(withIdentifier: "toMergeSortSourceCode", sender: self)
    }
    

    @IBAction func turnBackMenu(_ sender: UIButton) {        //self.navigationController?.popViewController(animated: true)
           present(sideMenu!, animated: true)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toMergeSortSourceCode" {
                let pageSource = segue.destination as! MergeSortSourceCode
                pageSource.currentStep = currentStep
                pageSource.everyStep = everyStep
                pageSource.previousVC = self
                pageSource.totalStep = totalStep
                pageSource.arr = arr
                pageSource.controlStack = controlStack
                pageSource.sort = sort
                
                if everyStep.isEmpty
                {
                    textFields = [text1, text2, text3, text4, text5, text6, text7]
                    
                    for i in 0..<textFields.count
                    {
                        sendRandomArr[i] = textFields[i].text ?? ""
                    }
                }
                pageSource.sendRandomArr = sendRandomArr
            }else if segue.identifier == "toSortMenu"{
                
            }
            
        }
    
    var arr = [Int]()
    var totalStep = 1
    var everyStep = [Int: Array<Int>]()
    var controlStack = 0
    var currentStep = 0
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
        
        let temp = [Int](repeating: 0, count: 1)//﻿﻿為了﻿﻿傳﻿﻿﻿而傳的array﻿，﻿沒有﻿用途
        addInformationTodict(arr, temp, -1, -1, -1, -1, -1, -1, -1, -1, -1)
        addInformationTodict(arr, temp, -1, -1, -1, -1, -1, -1, 0, -1, -1)
        mergeSort(0, arr.count - 1)
        nextStep.isEnabled = true
        stepNum.text = "\(currentStep) / \(everyStep.count)"
    }
    */
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
                principle.isHidden = true//﻿改過
                
                showArr(everyStep[currentStep]!)
                stepNum.text = "\(currentStep) / \(everyStep.count)"
                changeBGColor(-1)
                
                if let stepArr = everyStep[currentStep]
                {
                    showVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
                    introduceStep(stepArr[stepArr.count - 3])
                    changeTempArrColor(-1, stepArr)
                    
                    if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
                    {
                        show_tempArr(false, stepArr)
                        controlStack += 1
                        
                    }
                    else if stepArr[stepArr.count - 3] > 8
                    {
                        show_tempArrNum(controlStack - 1, stepArr)
                        
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
            showArr(everyStep[currentStep]!)
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            changeBGColor(-1)
            
            if let stepArr = everyStep[currentStep]
            {
                showVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
                introduceStep(stepArr[stepArr.count - 3])
                changeTempArrColor(-1, stepArr)
                
                if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
                {
                    show_tempArr(false, stepArr)
                    controlStack += 1
                    
                }
                else if stepArr[stepArr.count - 3] > 8
                {
                    show_tempArrNum(controlStack - 1, stepArr)
                    
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
        
        if let stepArr = everyStep[currentStep]
        {
            showVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
            introduceStep(stepArr[stepArr.count - 3])
            changeTempArrColor(-1, stepArr)
            
            if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
            {
                show_tempArr(false, stepArr)
                controlStack += 1
                
            }
            else if stepArr[stepArr.count - 3] > 8
            {
                show_tempArrNum(controlStack - 1, stepArr)
                
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
        //changeBG(everyStep[currentStep]!)
        //changeTextColor(everyStep[currentStep]!)
        //introduceStep(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        //showIJKey(everyStep[currentStep]!)
        
        changeBGColor(-1)
        
        
        if let stepArr = everyStep[currentStep + 1]
        {
            if stepArr[stepArr.count - 3] == 4 || stepArr[stepArr.count - 3] == 5 || stepArr[stepArr.count - 3] == 8
            {
                controlStack -= 1
                show_tempArr(true, everyStep[currentStep]!)
            }
        }
        
        if let stepArr = everyStep[currentStep]
        {
            showVar(stepArr[stepArr.count - 9],stepArr[stepArr.count - 8],stepArr[stepArr.count - 7],stepArr[stepArr.count - 6],stepArr[stepArr.count - 5],stepArr[stepArr.count - 4])
            introduceStep(stepArr[stepArr.count - 3])
            changeTempArrColor(-1, stepArr)
            
            if stepArr[stepArr.count - 3] > 8
            {
                show_tempArrNum(controlStack - 1, stepArr)
            }
            
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
    /*
    func showArr()
    {
        text1.text = String(arr[0])
        text2.text = String(arr[1])
        text3.text = String(arr[2])
        text4.text = String(arr[3])
        text5.text = String(arr[4])
        text6.text = String(arr[5])
        text7.text = String(arr[6])
    }*/
    
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
        principle.isHidden = false//﻿改過
        
        totalStep = 1
        everyStep.removeAll()
        currentStep = 0
        controlStack = -1
        
        introduce.text = ""
        stepNum.text = "/"
        iLabel.text = "i = "
        jLabel.text = "j = "
        kLabel.text = "k = "
        lLabel.text = "l = "
        mLabel.text = "middle = "
        rLabel.text = "r = "
        
        changeBGColor(-1)
        changeTempArrColor(-1, [-1, -1, -1, -1])//﻿因為﻿函﻿﻿式﻿有.count - 4
        show_tempArr(true, [-1])
        
        controlStack = 0
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
                text41.textColor = color_text_highlighter
            case 1:
                text42.textColor = color_text_highlighter
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
                text43.textColor = color_text_highlighter
            case 1:
                text44.textColor = color_text_highlighter
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
                text51.textColor = color_text_highlighter
            case 1:
                text52.textColor = color_text_highlighter
            case 2:
                text53.textColor = color_text_highlighter
            case 3:
                text54.textColor = color_text_highlighter
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
                text45.textColor = color_text_highlighter
            case 1:
                text46.textColor = color_text_highlighter
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
                text55.textColor = color_text_highlighter
            case 1:
                text56.textColor = color_text_highlighter
            case 2:
                text57.textColor = color_text_highlighter
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
                text61.textColor = color_text_highlighter
            case 1:
                text62.textColor = color_text_highlighter
            case 2:
                text63.textColor = color_text_highlighter
            case 3:
                text64.textColor = color_text_highlighter
            case 4:
                text65.textColor = color_text_highlighter
            case 5:
                text66.textColor = color_text_highlighter
            case 6:
                text67.textColor = color_text_highlighter
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
            text41.textColor = color_array_text
            text42.textColor = color_array_text
            text43.textColor = color_array_text
            text44.textColor = color_array_text
            text51.textColor = color_array_text
            text52.textColor = color_array_text
            text53.textColor = color_array_text
            text54.textColor = color_array_text
            text45.textColor = color_array_text
            text46.textColor = color_array_text
            text55.textColor = color_array_text
            text56.textColor = color_array_text
            text57.textColor = color_array_text
            text61.textColor = color_array_text
            text62.textColor = color_array_text
            text63.textColor = color_array_text
            text64.textColor = color_array_text
            text65.textColor = color_array_text
            text66.textColor = color_array_text
            text67.textColor = color_array_text
            
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        }
        
    }
    
    func show_tempArrNum(_ control: Int, _ arr: Array<Int>)
    {
        //var k = arr[arr.count - 4]
        
        switch control
        {
        case 4:
            text41.text = "\(arr[7])"
            text42.text = "\(arr[8])"
        case 8:
            text43.text = "\(arr[7])"
            text44.text = "\(arr[8])"
        case 9:
            text51.text = "\(arr[7])"
            text52.text = "\(arr[8])"
            text53.text = "\(arr[9])"
            text54.text = "\(arr[10])"
        case 14:
            text45.text = "\(arr[7])"
            text46.text = "\(arr[8])"
        case 16:
            text55.text = "\(arr[7])"
            text56.text = "\(arr[8])"
            text57.text = "\(arr[9])"
        case 17:
            text61.text = "\(arr[7])"
            text62.text = "\(arr[8])"
            text63.text = "\(arr[9])"
            text64.text = "\(arr[10])"
            text65.text = "\(arr[11])"
            text66.text = "\(arr[12])"
            text67.text = "\(arr[13])"
        default:
            text41.text = "0"
            text42.text = "0"
            text43.text = "0"
            text44.text = "0"
            text51.text = "0"
            text52.text = "0"
            text53.text = "0"
            text54.text = "0"
            text45.text = "0"
            text46.text = "0"
            text55.text = "0"
            text56.text = "0"
            text57.text = "0"
            text61.text = "0"
            text62.text = "0"
            text63.text = "0"
            text64.text = "0"
            text65.text = "0"
            text66.text = "0"
            text67.text = "0"
            
        }
        
    }
    
    
    func show_tempArr(_ isHidd: Bool, _ arr: Array<Int>)
    {
        
        switch controlStack
        {
        case 0:
            stack11.isHidden = isHidd
            text11.text = "\(arr[0])"
            text12.text = "\(arr[1])"
            text13.text = "\(arr[2])"
            text14.text = "\(arr[3])"
        case 1:
            stack21.isHidden = isHidd
            text21.text = "\(arr[0])"
            text22.text = "\(arr[1])"
        case 2:
            stack31.isHidden = isHidd
            text31.text = "\(arr[0])"
        case 3:
            stack32.isHidden = isHidd
            text32.text = "\(arr[1])"
        case 4:
            stack41.isHidden = isHidd
            text41.text = "0"
            text42.text = "0"
        case 5:
            stack22.isHidden = isHidd
            text23.text = "\(arr[2])"
            text24.text = "\(arr[3])"
        case 6:
            stack33.isHidden = isHidd
            text33.text = "\(arr[2])"
        case 7:
            stack34.isHidden = isHidd
            text34.text = "\(arr[3])"
        case 8:
            stack42.isHidden = isHidd
            text43.text = "0"
            text44.text = "0"
        case 9:
            stack51.isHidden = isHidd
            text51.text = "0"
            text52.text = "0"
            text53.text = "0"
            text54.text = "0"
        case 10:
            stack12.isHidden = isHidd
            text15.text = "\(arr[4])"
            text16.text = "\(arr[5])"
            text17.text = "\(arr[6])"
        case 11:
            stack23.isHidden = isHidd
            text25.text = "\(arr[4])"
            text26.text = "\(arr[5])"
        case 12:
            stack35.isHidden = isHidd
            text35.text = "\(arr[4])"
        case 13:
            stack36.isHidden = isHidd
            text36.text = "\(arr[5])"
        case 14:
            stack43.isHidden = isHidd
            text45.text = "0"
            text46.text = "0"
        case 15:
            stack24.isHidden = isHidd
            text27.text = "\(arr[6])"
        case 16:
            stack52.isHidden = isHidd
            text55.text = "0"
            text56.text = "0"
            text57.text = "0"
        case 17:
            stack6.isHidden = isHidd
            text61.text = "0"
            text62.text = "0"
            text63.text = "0"
            text64.text = "0"
            text65.text = "0"
            text66.text = "0"
            text67.text = "0"
        default:
            stack11.isHidden = isHidd
            stack21.isHidden = isHidd
            stack31.isHidden = isHidd
            stack32.isHidden = isHidd
            stack41.isHidden = isHidd
            stack22.isHidden = isHidd
            stack33.isHidden = isHidd
            stack34.isHidden = isHidd
            stack42.isHidden = isHidd
            stack51.isHidden = isHidd
            stack12.isHidden = isHidd
            stack23.isHidden = isHidd
            stack35.isHidden = isHidd
            stack36.isHidden = isHidd
            stack43.isHidden = isHidd
            stack24.isHidden = isHidd
            stack52.isHidden = isHidd
            stack6.isHidden = isHidd

        }
            
    }
    
    func showVar(_ l: Int, _ middle: Int, _ r: Int, _ i: Int, _ j: Int, _ k: Int)
    {
        if l != -1
        {
            lLabel.text  = "l = \(l + 1)"
        }
        else
        {
            lLabel.text = "l = ?"
        }
        
        if middle != -1
        {
            mLabel.text = "middle = \(middle + 1)"
        }
        else
        {
            mLabel.text = "middle = ?"
        }
        
        if r != -1
        {
            rLabel.text = "r = \(r + 1)"
        }
        else
        {
            rLabel.text = "r = ?"
        }
        
        if i != -1
        {
            iLabel.text = "i = \(i + 1)"
        }
        else
        {
            iLabel.text = "i = ?"
        }
        
        if j != -1
        {
            jLabel.text = "j = \(j + 1)"
        }
        else
        {
            jLabel.text = "j = ?"
        }
        
        if k != -1
        {
            kLabel.text = "k = \(k + 1)"
        }
        else
        {
            kLabel.text = "k = ?"
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
    
    func introduceStep(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            introduce.text = "﻿呼叫mergeSort﻿﻿函式﻿，﻿並﻿將1和﻿A﻿陣列﻿長度﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 2:
            introduce.text = "﻿﻿﻿﻿將(l + r) / 2﻿﻿ 的﻿值﻿給middle﻿"
        case 3:
            introduce.text = "﻿比較l是否﻿﻿小於r"
        case 4:
            introduce.text = "﻿﻿呼叫mergeSort﻿﻿函式﻿，﻿並﻿將l和﻿middle﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 5:
            introduce.text = "﻿呼叫mergeSort﻿﻿函式﻿，﻿並﻿將middle + 1和﻿r﻿的﻿﻿值﻿分﻿別﻿做為l﻿和r"
        case 6:
            introduce.text = "呼叫merge函式﻿，﻿並﻿將l﻿﻿、middle﻿﻿、﻿r﻿的﻿﻿值﻿﻿傳入"
        case 8:
            introduce.text = "﻿﻿﻿將tempArr﻿﻿先﻿全部﻿放0"
        case 10:
            introduce.text = "﻿將l的值﻿﻿﻿給i"
        case 11:
            introduce.text = "將middle + 1的值﻿﻿﻿給j"
        case 12:
            introduce.text = "﻿將k的值﻿﻿﻿﻿為1"
        case 13:
            introduce.text = "﻿﻿判斷目前﻿i是否﻿小於﻿﻿﻿等於middle﻿﻿，﻿且﻿j﻿小﻿於﻿等於r，﻿是則﻿執行迴圈﻿，﻿否則﻿離開"
        case 14:
            introduce.text = "比較A[i]是否﻿﻿小於A[j]"
        case 15:
            introduce.text = "﻿﻿將A[i]的值﻿﻿﻿給tempArr[k]"
        case 16:
            introduce.text = "﻿﻿將i的值﻿﻿﻿﻿﻿加1"
        case 18:
            introduce.text = "﻿﻿﻿A[i]﻿不小於A[j]﻿，將A[j]的值﻿﻿﻿給tempArr[k]"
        case 19:
            introduce.text = "將j的值﻿﻿﻿﻿﻿加1"
        case 20:
            introduce.text = "﻿將k的值﻿﻿﻿﻿﻿加1"
        case 21:
            introduce.text = "﻿﻿判斷目前﻿i是否﻿小於﻿﻿﻿等於middle﻿﻿，﻿是則﻿執行迴圈﻿，﻿否則﻿離開"
        case 22:
            introduce.text = "將A[i]的值﻿﻿﻿給tempArr[k]"
        case 23:
            introduce.text = "﻿﻿將k的值﻿﻿﻿﻿﻿加1"
        case 24:
            introduce.text = "﻿﻿將i的值﻿﻿﻿﻿﻿加1"
        case 25:
            introduce.text = "﻿﻿判斷目前﻿j是否﻿小於﻿﻿﻿等於r，﻿是則﻿執行迴圈﻿，﻿否則﻿離開"
        case 26:
            introduce.text = "將A[j]的值﻿﻿﻿給tempArr[k]"
        case 27:
            introduce.text = "﻿﻿將k的值﻿﻿﻿﻿﻿加1"
        case 28:
            introduce.text = "﻿﻿將j的值﻿﻿﻿﻿﻿加1"
        case 29:
            introduce.text = "﻿﻿將tempArr﻿﻿排序﻿好的值﻿放回﻿A﻿陣列"
        default:
            introduce.text = ""
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

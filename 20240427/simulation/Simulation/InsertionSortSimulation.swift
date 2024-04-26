//
//  ViewController.swift
//  simulation
//
//  Created by WanHsuan on 2023/7/20.
//

import UIKit
import SideMenu

class InsertionSortSimulation: UIViewController, MenuControllerDelegate {
    
    var sideMenu: SideMenuNavigationController?
    
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!
    var textFields: [UITextField] = []
    
    @IBOutlet var introduce: UILabel!
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var iLabel: UILabel!
    @IBOutlet var jLabel: UILabel!
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var principle: UILabel!//﻿改過
    
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    @IBOutlet var clear: UIButton!
    
    var arr = [Int]()
    var totalStep = 1
    var everyStep = [Int: Array<Int>]()
    var currentStep = 0
    
    var color_bg_highlighter = UIColor(rgb: 0xf5f36c) //螢光筆顏色(底)
    var color_text_highlighter = UIColor(rgb: 0xe31212)
    var color_array_bg = UIColor(rgb: 0xffffff) //陣列底色
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        text1.layer.borderWidth = 3
//        text1.layer.borderColor = UIColor(rgb: 0x6B77BD).cgColor
        
        let menu = MenuController(with: ["模擬","練習","相關程式碼","相關影片","回到排序選擇畫面"])
               
               menu.delegate = self
               
               sideMenu = SideMenuNavigationController(rootViewController: menu)
               sideMenu?.leftSide = true
               SideMenuManager.default.leftMenuNavigationController = sideMenu
               SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        //textFields = [text1, text2, text3, text4, text5, text6, text7]
    }
    
    @IBAction func goInstruction(_ sender: UIButton) {
            let instructionVc = self.storyboard?.instantiateViewController(withIdentifier: "instruction") as! InstructionViewController
            self.navigationController?.pushViewController(instructionVc, animated: true)
        }
    
    // 頁面跳轉
    @IBAction func goToSortSourceCode(_ sender: UIButton) {
        performSegue(withIdentifier: "toInsertionSourceCode", sender: self)
    }
    
    @IBAction func turnBackMenu(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        present(sideMenu!, animated: true)
    }
    
    // 傳值
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toInsertionSourceCode" {
                let pageSource = segue.destination as! InsertionSortSourceCode
                pageSource.currentStep = currentStep
                pageSource.everyStep = everyStep
                pageSource.previousVC = self
                pageSource.totalStep = totalStep
                pageSource.arr = arr
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
    
//    var currentLabelStep = 0
    
    @IBAction func nextStep(sender: UIButton)
    {
        
        if currentStep == 0
        {
            //let correctInput = userInput()
            
            if userInput()
            {
                //firstNext = false
                
                currentStep += 1
                //preStep.isEnabled = true//﻿改過
                principle.isHidden = true//﻿改過
                if let stepArr = everyStep[currentStep]
                {
                    showArr(stepArr)
                    changeBG(stepArr[stepArr.count - 2])
                    changeTextColor(stepArr[stepArr.count - 1])
                    introduceStep(stepArr[stepArr.count - 3])
                    stepNum.text = "\(currentStep) / \(everyStep.count)"
                    showIJKey(stepArr[stepArr.count - 5], stepArr[stepArr.count - 4], stepArr[stepArr.count - 3], stepArr)
                    
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
                introduceStep(stepArr[stepArr.count - 3])
                stepNum.text = "\(currentStep) / \(everyStep.count)"
                showIJKey(stepArr[stepArr.count - 5], stepArr[stepArr.count - 4], stepArr[stepArr.count - 3], stepArr)
                
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
            introduceStep(stepArr[stepArr.count - 3])
            stepNum.text = "\(currentStep) / \(everyStep.count)"
            showIJKey(stepArr[stepArr.count - 5], stepArr[stepArr.count - 4], stepArr[stepArr.count - 3], stepArr)
            
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
    
    func showIJKey(_ num1: Int, _ num2: Int, _ num3: Int, _ arr2: Array<Int>)
    {
        
        if num1 != -1
        {
            iLabel.text = "j = \(num1 + 1)"
        }
        else
        {
            iLabel.text = "j = ?"
        }
        
        if num2 != -2//改﻿成-1﻿變-2,
        {
            jLabel.text = "i = \(num2 + 1)"
        }
        else
        {
            jLabel.text = "i = ?"
        }
        
        switch num3
        {
        case 0:
            keyLabel.text = "key = ?"
        case 1:
            keyLabel.text = "key = \(arr2[num1])"
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
            keyLabel.text = "key = ?"
        }
    }
    
    func showArr(_ inputArr: Array<Int>)
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
            textFields[i].text = "\(inputArr[i])"
        }
        
    }
    
    func reset()
    {
        //firstNext = true
        preStep.isEnabled = false
        nextStep.isEnabled = true
        principle.isHidden = false//﻿改過
        
        totalStep = 1
        everyStep.removeAll()
        currentStep = 0
        
        introduce.text = ""
        stepNum.text = "/"
        iLabel.text = "j = "
        jLabel.text = "i = "
        keyLabel.text = "key = "
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
            textFields[i].backgroundColor = color_array_bg
            textFields[i].textColor = color_array_text
        }
        
    }
    
    func introduceStep(_ num1: Int)
    {
        switch num1
        {
        case 0:
            introduce.text = "判斷j﻿目前﻿是否﻿小於﻿等於陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 1:
            introduce.text = "﻿將A[j]的值給key"
        case 2:
            introduce.text = "﻿將j-1的值給i"
        case 3:
            introduce.text = "﻿﻿判斷﻿i是否﻿大於0﻿，﻿且A[i]﻿的﻿值﻿﻿大於key，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 4:
            introduce.text = "﻿將A[i]的值給A[i+1]"
        case 5:
            introduce.text = "將i-1的值給i"
        case 6:
            introduce.text = "﻿將key的值給A[i+1]"
        default:
            introduce.text = ""
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
        insertToFinal()
        return true
    }
    
    func checkNumeric(_ s: String) -> Bool
    {
       return Int(s) != nil
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


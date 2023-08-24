//
//  InsertionSortSourceCode.swift
//  simulation
//
//  Created by WanHsuan on 2023/7/24.
//

//import Foundation
import UIKit

class InsertionSortSourceCode: UIViewController {
    
    
    
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
    
    @IBOutlet var stepNum: UILabel!
    
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    
    var previousVC: InsertionSortSimulation?
    var currentStep = 1
    var everyStep = [Int: Array<Int>]()
    var arr = [Int]()
    var totalStep = 1
    
    var color_bg_highlighter = UIColor(rgb: 0xfee49b) //螢光筆顏色(底)
    var color_text_highlighter = UIColor(rgb: 0xe31212)
    var color_array_bg = UIColor(rgb: 0xFFFFFF) //陣列底色
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
    
    // 頁面跳轉
    @IBAction func turnToInsertionSort(_ sender: UIButton) {
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
            showCurrArr(everyStep[currentStep]!)
            changeBG(everyStep[currentStep]!)
            changeTextColor(everyStep[currentStep]!)
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
    

    
    // 資料傳回去
    func sentDataBack() {
        if previousVC != nil {
            previousVC!.currentStep = currentStep
            
            checkButton()
            previousVC!.totalStep = totalStep
            if everyStep.isEmpty {
                turnBackClear()
                previousVC!.nextStep.isEnabled = false
                previousVC!.preStep.isEnabled = false
                
            } else {
                previousVC!.everyStep = everyStep
                previousVC!.arr = arr
                turnBackChange()
                turnBackChangeBG(everyStep[currentStep]!)
                turnBackChangeTextColor(everyStep[currentStep]!)
                turnBackIntroduceStep(everyStep[currentStep]!)
                turnBackShowIJKey(everyStep[currentStep]!)
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
                    previousVC!.iLabel.text = "j = "
                    previousVC!.jLabel.text = "i = "
                    previousVC!.keyLabel.text = "key = "

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
            let randomNumber = Int(arc4random_uniform(10)) + 1
            if !arr.contains(randomNumber) {
                arr.append(randomNumber)
            }
        }
        reset()
        showArr()
        insertToFinal()
        nextStep.isEnabled = true
        stepNum.text = "\(currentStep) / \(everyStep.count)"
    }
    
    
    

    
    @IBAction func nextStep(sender: UIButton)
    {
        currentStep += 1

        preStep.isEnabled = true
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        changeLabelBG(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        
        if(currentStep >= everyStep.count)
        {
            nextStep.isEnabled = false
        }
    }
    @IBAction func preStep(sender: UIButton)
    {
        currentStep -= 1
        nextStep.isEnabled = true
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        changeLabelBG(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        
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
        addInformationTodict(-1, -1, -1, -1, -1)
        
        for i in 1..<arr.count
        {
            addInformationTodict(i, -1, 0, -1, -1)
            
            let key = arr[i]
            addInformationTodict(i, -1, 1, -1, -1)
            
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
       
        addInformationTodict(-1, -1, 0, -1, -1)
        addInformationTodict(-1, -1, -1, -1, -1)
        
        /*
        for index in 1...everyStep.count
        {
            print(everyStep[index])
            //print(everyStep[index])
            
        }*/
        
    }
    
    func showCurrArr(_ arr: Array<Int>)
    {
        text1.text = "\(arr[0])"
        text2.text = "\(arr[1])"
        text3.text = "\(arr[2])"
        text4.text = "\(arr[3])"
        text5.text = "\(arr[4])"
        text6.text = "\(arr[5])"
        text7.text = "\(arr[6])"
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
        
    }
    
    func changeBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 2] as! Int
        switch num1
        {
        case 1:
            text1.backgroundColor = color_bg_highlighter
            text2.backgroundColor = color_bg_highlighter
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 2:
            text2.backgroundColor = color_bg_highlighter
            text3.backgroundColor = color_bg_highlighter
            text1.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 3:
            text3.backgroundColor = color_bg_highlighter
            text4.backgroundColor = color_bg_highlighter
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 4:
            text4.backgroundColor = color_bg_highlighter
            text5.backgroundColor = color_bg_highlighter
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text6.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 5:
            text5.backgroundColor = color_bg_highlighter
            text6.backgroundColor = color_bg_highlighter
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text7.backgroundColor = color_array_bg
        case 6:
            text6.backgroundColor = color_bg_highlighter
            text7.backgroundColor = color_bg_highlighter
            text1.backgroundColor = color_array_bg
            text2.backgroundColor = color_array_bg
            text3.backgroundColor = color_array_bg
            text4.backgroundColor = color_array_bg
            text5.backgroundColor = color_array_bg
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
    
    func changeTextColor(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            text1.textColor = color_text_highlighter
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        case 1:
            text1.textColor = color_array_text
            text2.textColor = color_text_highlighter
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        case 2:
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_text_highlighter
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        case 3:
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_text_highlighter
            text5.textColor = color_array_text
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        case 4:
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_text_highlighter
            text6.textColor = color_array_text
            text7.textColor = color_array_text
        case 5:
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_text_highlighter
            text7.textColor = color_array_text
        case 6:
            text1.textColor = color_array_text
            text2.textColor = color_array_text
            text3.textColor = color_array_text
            text4.textColor = color_array_text
            text5.textColor = color_array_text
            text6.textColor = color_array_text
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
    
    func changeLabelBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 3] as! Int
        switch num1
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
        }
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
    
    func turnBackChangeBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 2] as! Int
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
    
    func turnBackChangeTextColor(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 1] as! Int
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
    
    func turnBackIntroduceStep(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 3] as! Int
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
        previousVC!.text1.text = ""
        previousVC!.text2.text = ""
        previousVC!.text3.text = ""
        previousVC!.text4.text = ""
        previousVC!.text5.text = ""
        previousVC!.text6.text = ""
        previousVC!.text7.text = ""
        
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
    
    func turnBackShowIJKey(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 5] as! Int
        
        if num1 != -1
        {
            previousVC!.iLabel.text = "j = \(num1 + 1)"
        }
        else
        {
            previousVC!.iLabel.text = "j = ?"
        }
        
        var num2 = arr[arr.count - 4] as! Int
        
        if num2 != -1
        {
            previousVC!.jLabel.text = "i = \(num2 + 1)"
        }
        else
        {
            previousVC!.jLabel.text = "i = ?"
        }
        
        var num3 = arr[arr.count - 3] as! Int
        
        switch num3
        {
        case 0:
            previousVC!.keyLabel.text = "key = ?"
        case 1:
            fallthrough
        case 2:
            fallthrough
        case 3:
            fallthrough
        case 4:
            fallthrough
        case 5:
            fallthrough
        case 6:
            previousVC!.keyLabel.text = "key = \(arr[num1])"
        default:
            previousVC!.keyLabel.text = "key = ?"
        }
    }

        
 }

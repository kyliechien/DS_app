//
//  ViewController.swift
//  simulation
//
//  Created by WanHsuan on 2023/7/20.
//

import UIKit

class InsertionSortSimulation: UIViewController {
    

    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!
    
    @IBOutlet var introduce: UILabel!
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var iLabel: UILabel!
    @IBOutlet var jLabel: UILabel!
    @IBOutlet var keyLabel: UILabel!
    
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    @IBOutlet var clear: UIButton!
    
    var arr = [Int]()
    //var current = 1
    var totalStep = 1
    //var point = 2
    //var isChange = false
    var everyStep = [Int: Array<Int>]()
    var currentStep = 1
    //var labelStep = [Int]()
    
    var color_bg_highlighter = UIColor(rgb: 0xfee49b) //螢光筆顏色(底)
    var color_text_highlighter = UIColor(rgb: 0xe31212)
    var color_array_bg = UIColor(rgb: 0xF3F6FB) //陣列底色
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        text1.layer.borderWidth = 3
//        text1.layer.borderColor = UIColor(rgb: 0x6B77BD).cgColor
        

    }
    
    // 頁面跳轉
    @IBAction func goToSortSourceCode(_ sender: UIButton) {
        performSegue(withIdentifier: "toInsertionSourceCode", sender: self)
    }
    
//    @IBAction func goToSortＭenu(_ sender: UIButton) {
//        performSegue(withIdentifier: "toSortMenu", sender: self)
//    }
    
    @IBAction func turnBackMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pageSource = segue.destination as! InsertionSortSourceCode
        pageSource.currentStep = currentStep
        pageSource.everyStep = everyStep
        pageSource.previousVC = self
        pageSource.totalStep = totalStep
        pageSource.arr = arr
       
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
        //currentLabelStep += 1
        
        currentStep += 1

        preStep.isEnabled = true
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        introduceStep(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        showIJKey(everyStep[currentStep]!)
        
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
        introduceStep(everyStep[currentStep]!)
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        showIJKey(everyStep[currentStep]!)
        
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
    
    func showIJKey(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 5] as! Int
        
        if num1 != -1
        {
            iLabel.text = "j = \(num1 + 1)"
        }
        else
        {
            iLabel.text = "j = ?"
        }
        
        var num2 = arr[arr.count - 4] as! Int
        
        if num2 != -1
        {
            jLabel.text = "i = \(num2 + 1)"
        }
        else
        {
            jLabel.text = "i = ?"
        }
        
        var num3 = arr[arr.count - 3] as! Int
        
        switch num3
        {
        case 0:
            keyLabel.text = "key = ?"
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
            keyLabel.text = "key = \(arr[num1])"
        default:
            keyLabel.text = "key = ?"
        }
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
    
    func reset()
    {
        preStep.isEnabled = false
        nextStep.isEnabled = false
        
        totalStep = 1
        everyStep.removeAll()
        currentStep = 1
        
        introduce.text = ""
        stepNum.text = "/"
        iLabel.text = "j = "
        jLabel.text = "i = "
        keyLabel.text = "key = "
        
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
        
    }
    
    func introduceStep(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 3] as! Int
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
    
    
    /*
    func compare2item() -> Bool
    {
        changeBG(current)
        if current > 0 && current < arr.count
        {
            if arr[current - 1] > arr[current]
            {
                let temp = arr[current]
                arr[current] = arr[current - 1]
                arr[current - 1] = temp
                changeTextColor(current)
                current -= 1
                
            }
            else
            {
                changeTextColor(0)
                current = point
                point += 1
                
            }
            
            if current == 0
            {
                current = point
                point += 1
            }
        }
        else
        {
            return true
        }
        return false
    }
        
    func compare2itemToFinal()
    {
        var comp = true
        changeBG(current)//
        while comp
        {
            if current > 0 && current < arr.count
            {
                var arrRecord = [Int](repeating: 0, count: 9)
                for index in 0..<arr.count
                {
                    arrRecord[index] = arr[index]
                }
                arrRecord[arrRecord.count - 2] = current
                
                if arr[current - 1] > arr[current]
                {
                    arrRecord[arrRecord.count - 1] = 1
                    //everyStep[totalStep] = arrRecord
                    
                    let temp = arr[current]
                    arr[current] = arr[current - 1]
                    arr[current - 1] = temp
                    
                    changeTextColor(current)//
                    current -= 1
                    
                }
                else
                {
                    arrRecord[arrRecord.count - 1] = 0
                    //everyStep[totalStep] = arrRecord
                    
                    changeTextColor(0)//
                    current = point
                    point += 1
                    
                }
                everyStep[totalStep] = arrRecord
                totalStep += 1
                
                if current == 0
                {
                    current = point
                    point += 1
                }
            }
            else
            {
                comp = false
                //return true
            }
            //return false
        }
    }
    */
    
}


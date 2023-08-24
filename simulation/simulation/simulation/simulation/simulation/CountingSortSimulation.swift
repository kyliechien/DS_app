//
//  CountingSortSimulation.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/3.
//

//import Foundation
import UIKit

class CountingSortSimulation: UIViewController {
    
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!
    
    @IBOutlet var countText1: UILabel!
    @IBOutlet var countText2: UILabel!
    @IBOutlet var countText3: UILabel!
    @IBOutlet var countText4: UILabel!
    @IBOutlet var countText5: UILabel!
    @IBOutlet var countText6: UILabel!
    @IBOutlet var countText7: UILabel!
    @IBOutlet var countText8: UILabel!
    @IBOutlet var countText9: UILabel!
//    @IBOutlet var countText10: UILabel!
    
    @IBOutlet var Btext1: UILabel!
    @IBOutlet var Btext2: UILabel!
    @IBOutlet var Btext3: UILabel!
    @IBOutlet var Btext4: UILabel!
    @IBOutlet var Btext5: UILabel!
    @IBOutlet var Btext6: UILabel!
    @IBOutlet var Btext7: UILabel!
    
    @IBOutlet var introduce: UILabel!
    @IBOutlet var stepNum: UILabel!
//    @IBOutlet var iLabel: UILabel!
//    @IBOutlet var jLabel: UILabel!
//    @IBOutlet var keyLabel: UILabel!
    
    @IBOutlet var nextStep: UIButton!
    @IBOutlet var preStep: UIButton!
    @IBOutlet var clear: UIButton!
    
    @IBOutlet var countStack1: UIStackView!
    @IBOutlet var countStack2: UIStackView!
    @IBOutlet var countStack3: UIStackView!
    @IBOutlet var countStack4: UIStackView!
    @IBOutlet var countStack5: UIStackView!
    @IBOutlet var countStack6: UIStackView!
    @IBOutlet var countStack7: UIStackView!
    @IBOutlet var countStack8: UIStackView!
    @IBOutlet var countStack9: UIStackView!
    
    @IBOutlet var BStack: UIStackView!
    
    
    
    var arr = [Int]()
    var changeArr = [Int]()
    var totalStep = 1
    var everyStep = [Int: Array<Int>]()
    var currentStep = 1
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        text1.layer.borderWidth = 3
//        text1.layer.borderColor = UIColor(rgb: 0x6B77BD).cgColor
        

    }
    
    @IBAction func goToSortSourceCode(_ sender: UIButton) {
        performSegue(withIdentifier: "toCountingSortSourceCode", sender: self)
    }
    
//    @IBAction func goToSortＭenu(_ sender: UIButton) {
//        performSegue(withIdentifier: "toSortMenu", sender: self)
//    }

    @IBAction func turnBackMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pageSource = segue.destination as! CountingSortSourceCode
        pageSource.currentStep = currentStep
        pageSource.everyStep = everyStep
        pageSource.previousVC = self
        pageSource.totalStep = totalStep
        pageSource.arr = arr
        pageSource.changeArr = changeArr
//        pageSource.maxValue = maxValue
       
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
        maxValue = getMaxValue(arr)
        show_B_CArrLength(maxValue)
        showArr()
        countingToFinal()
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
    
    @IBAction func nextStep(sender: UIButton)
    {
        currentStep += 1

        preStep.isEnabled = true
        introduceStep(everyStep[currentStep]!)

        /*
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        introduceStep(everyStep[currentStep]!)*/
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        //showIJKey(everyStep[currentStep]!)
        
        //print(everyStep[currentStep])
        
        if currentStep < changeArr[0]
        {
            changeBG(everyStep[currentStep]!)
            changeCountingTextColor(everyStep[currentStep]!)
            showCurrCountArr(everyStep[currentStep]!)
            //changeBucketTextColor(everyStep[currentStep]!)
            
        }
        else if currentStep < changeArr[1]
        {
            showCurrCountArr(everyStep[currentStep]!)
            changeCountingTextColor(everyStep[currentStep]!)
            
        }
        else
        {
            
            showCurrBArr(everyStep[currentStep]!)
            changeBG(everyStep[currentStep]!)
            changeCountingBG(everyStep[currentStep]!)
            changeBTextColor(everyStep[currentStep]!)
            
            changeCountingTextColor(everyStep[currentStep]!)
            showCurrCountArr(everyStep[currentStep]!)

            //showCurrBArr(everyStep[currentStep]!)
            //showCurrCountArr(everyStep[currentStep]!)
            /*
            if everyStep[currentStep]!.count == 7 + 5
            {
                showCurrBArr(everyStep[currentStep]!)
                //changeBG(everyStep[currentStep]!)
                //changeCountingBG(everyStep[currentStep]!)
                //changeBTextColor(everyStep[currentStep]!)
                //introduceStep(everyStep[currentStep]!)
                
                //changeCountingTextColor(everyStep[currentStep]!)
            }
            else
            {
                showCurrCountArr(everyStep[currentStep]!)
                //changeBG(everyStep[currentStep]!)
                //changeCountingTextColor(everyStep[currentStep]!)
                //changeBTextColor(everyStep[currentStep]!)
                //introduceStep(everyStep[currentStep]!)
                
                //changeCountingBG(everyStep[currentStep]!)
                //changeBTextColor(everyStep[currentStep]!)
                
            }*/
            
            
            
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
        introduceStep(everyStep[currentStep]!)
        
        /*
        showCurrArr(everyStep[currentStep]!)
        changeBG(everyStep[currentStep]!)
        changeTextColor(everyStep[currentStep]!)
        introduceStep(everyStep[currentStep]!)*/
        stepNum.text = "\(currentStep) / \(everyStep.count)"
        //showIJKey(everyStep[currentStep]!)
        
        if currentStep < changeArr[0]
        {
            changeBG(everyStep[currentStep]!)
            changeCountingTextColor(everyStep[currentStep]!)
            showCurrCountArr(everyStep[currentStep]!)
            //changeBucketTextColor(everyStep[currentStep]!)
            
        }
        else if currentStep < changeArr[1]
        {
            showCurrCountArr(everyStep[currentStep]!)
            changeCountingTextColor(everyStep[currentStep]!)
            //introduceStep(everyStep[currentStep]!)
            
            //showCurrBArr(everyStep[currentStep]!)
            
        }
        else
        {
            print(everyStep[currentStep]!.count)
            print(everyStep[currentStep])
            
            showCurrBArr(everyStep[currentStep]!)
            changeBG(everyStep[currentStep]!)
            changeCountingBG(everyStep[currentStep]!)
            changeBTextColor(everyStep[currentStep]!)
            
            changeCountingTextColor(everyStep[currentStep]!)
            
            showCurrBArr(everyStep[currentStep]!)
            showCurrCountArr(everyStep[currentStep]!)
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
        
        //let maxValue = getMaxValue(arr)
        //﻿範圍﻿ 0 ~﻿ max
        var counting = [Int](repeating: 0, count: maxValue)
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
    
    
    func showCurrBArr(_ arr: Array<Int>)
    {
        Btext1.text = "\(arr[maxValue])"
        Btext2.text = "\(arr[maxValue + 1])"
        Btext3.text = "\(arr[maxValue + 2])"
        Btext4.text = "\(arr[maxValue + 3])"
        Btext5.text = "\(arr[maxValue + 4])"
        Btext6.text = "\(arr[maxValue + 5])"
        Btext7.text = "\(arr[maxValue + 6])"
        
    }
    
    func showCurrCountArr(_ arr: Array<Int>)
    {
        countText1.text = "\(arr[0])"
        countText2.text = "\(arr[1])"
        countText3.text = "\(arr[2])"
        countText4.text = "\(arr[3])"
        countText5.text = "\(arr[4])"
        countText6.text = "\(arr[5])"
        countText7.text = "\(arr[6])"
        countText8.text = "\(arr[7])"
        countText9.text = "\(arr[8])"
        //countText10.text = "\(arr[9])"
        
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
	
	func show_B_CArrLength(_ maxValue: Int)
    {
        
        BStack.isHidden = false
        
        switch maxValue
        {
        case 1:
            countStack1.isHidden = false
        case 2:
            countStack1.isHidden = false
            countStack2.isHidden = false
        case 3:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
        case 4:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
            countStack4.isHidden = false
        case 5:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
            countStack4.isHidden = false
            countStack5.isHidden = false
        case 6:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
            countStack4.isHidden = false
            countStack5.isHidden = false
            countStack6.isHidden = false
        case 7:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
            countStack4.isHidden = false
            countStack5.isHidden = false
            countStack6.isHidden = false
            countStack7.isHidden = false
        case 8:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
            countStack4.isHidden = false
            countStack5.isHidden = false
            countStack6.isHidden = false
            countStack7.isHidden = false
            countStack8.isHidden = false
        case 9:
            countStack1.isHidden = false
            countStack2.isHidden = false
            countStack3.isHidden = false
            countStack4.isHidden = false
            countStack5.isHidden = false
            countStack6.isHidden = false
            countStack7.isHidden = false
            countStack8.isHidden = false
            countStack9.isHidden = false
        default:
            countStack1.isHidden = true
            countStack2.isHidden = true
            countStack3.isHidden = true
            countStack4.isHidden = true
            countStack5.isHidden = true
            countStack6.isHidden = true
            countStack7.isHidden = true
            countStack8.isHidden = true
            countStack9.isHidden = true
            
            BStack.isHidden = true
        }
    }
    
    func reset()
    {
        preStep.isEnabled = false
        nextStep.isEnabled = false
        
        show_B_CArrLength(-1)
        totalStep = 1
        everyStep.removeAll()
        currentStep = 1
        
        introduce.text = ""
        stepNum.text = "/"
//        iLabel.text = "j = "
//        jLabel.text = "i = "
//        keyLabel.text = "key = "
        
        text1.backgroundColor = color_array_bg
        text2.backgroundColor = color_array_bg
        text3.backgroundColor = color_array_bg
        text4.backgroundColor = color_array_bg
        text5.backgroundColor = color_array_bg
        text6.backgroundColor = color_array_bg
        text7.backgroundColor = color_array_bg
        
        countText1.backgroundColor = color_array_bg
        countText2.backgroundColor = color_array_bg
        countText3.backgroundColor = color_array_bg
        countText4.backgroundColor = color_array_bg
        countText5.backgroundColor = color_array_bg
        countText6.backgroundColor = color_array_bg
        countText7.backgroundColor = color_array_bg
        countText8.backgroundColor = color_array_bg
        countText9.backgroundColor = color_array_bg
        
        
        text1.textColor = color_array_text
        text2.textColor = color_array_text
        text3.textColor = color_array_text
        text4.textColor = color_array_text
        text5.textColor = color_array_text
        text6.textColor = color_array_text
        text7.textColor = color_array_text
        
        countText1.text = ""
        countText2.text = ""
        countText3.text = ""
        countText4.text = ""
        countText5.text = ""
        countText6.text = ""
        countText7.text = ""
        countText8.text = ""
        countText9.text = ""
//        countText10.text = ""
        
        Btext1.text = ""
        Btext2.text = ""
        Btext3.text = ""
        Btext4.text = ""
        Btext5.text = ""
        Btext6.text = ""
        Btext7.text = ""
        
        
    }
    
    func introduceStep(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 3] as! Int
        switch num1
        {
        case 0:
            introduce.text = "﻿把﻿C陣列﻿﻿﻿中的﻿﻿值全部﻿放﻿0"
        case 1:
            introduce.text = "﻿判斷i目前﻿是否﻿小於﻿﻿等於A﻿陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 2:
            introduce.text = "﻿將C[A[i]]﻿的值﻿﻿﻿加1"
        case 3:
            introduce.text = "﻿﻿判斷i目前﻿是否﻿小於﻿等於C陣列的長度﻿，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 4:
            introduce.text = "﻿將C﻿[﻿i]﻿與前﻿一﻿個﻿元素﻿的值﻿相加"
        case 5:
            introduce.text = "判斷i目前﻿是否﻿﻿大於﻿等於1，﻿是則進入﻿迴圈﻿，﻿否則﻿離開"
        case 6:
            introduce.text = "﻿將﻿A﻿[i]的值給B[C[A[i]]]"
        case 7:
            introduce.text = "將C[A[i]]﻿的值﻿﻿﻿﻿減1"
        default:
            introduce.text = ""
        }
        
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
    
    func changeCountingBG(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 2] as! Int
        switch num1
        {
        case 0:
            countText1.backgroundColor = color_bg_highlighter
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 1:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_bg_highlighter
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 2:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_bg_highlighter
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 3:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_bg_highlighter
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 4:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_bg_highlighter
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 5:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_bg_highlighter
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 6:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_bg_highlighter
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 7:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_bg_highlighter
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        case 8:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_bg_highlighter
//            countText10.backgroundColor = color_array_bg
        case 9:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_bg_highlighter
        default:
            countText1.backgroundColor = color_array_bg
            countText2.backgroundColor = color_array_bg
            countText3.backgroundColor = color_array_bg
            countText4.backgroundColor = color_array_bg
            countText5.backgroundColor = color_array_bg
            countText6.backgroundColor = color_array_bg
            countText7.backgroundColor = color_array_bg
            countText8.backgroundColor = color_array_bg
            countText9.backgroundColor = color_array_bg
//            countText10.backgroundColor = color_array_bg
        }
        
    }
    
    
    func changeBTextColor(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 1] as! Int
        switch num1
        {
        case 0:
            Btext1.textColor = color_text_highlighter
            Btext2.textColor = color_array_text
            Btext3.textColor = color_array_text
            Btext4.textColor = color_array_text
            Btext5.textColor = color_array_text
            Btext6.textColor = color_array_text
            Btext7.textColor = color_array_text
        case 1:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_text_highlighter
            Btext3.textColor = color_array_text
            Btext4.textColor = color_array_text
            Btext5.textColor = color_array_text
            Btext6.textColor = color_array_text
            Btext7.textColor = color_array_text
        case 2:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_array_text
            Btext3.textColor = color_text_highlighter
            Btext4.textColor = color_array_text
            Btext5.textColor = color_array_text
            Btext6.textColor = color_array_text
            Btext7.textColor = color_array_text
        case 3:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_array_text
            Btext3.textColor = color_array_text
            Btext4.textColor = color_text_highlighter
            Btext5.textColor = color_array_text
            Btext6.textColor = color_array_text
            Btext7.textColor = color_array_text
        case 4:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_array_text
            Btext3.textColor = color_array_text
            Btext4.textColor = color_array_text
            Btext5.textColor = color_text_highlighter
            Btext6.textColor = color_array_text
            Btext7.textColor = color_array_text
        case 5:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_array_text
            Btext3.textColor = color_array_text
            Btext4.textColor = color_array_text
            Btext5.textColor = color_array_text
            Btext6.textColor = color_text_highlighter
            Btext7.textColor = color_array_text
        case 6:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_array_text
            Btext3.textColor = color_array_text
            Btext4.textColor = color_array_text
            Btext5.textColor = color_array_text
            Btext6.textColor = color_array_text
            Btext7.textColor = color_text_highlighter
        default:
            Btext1.textColor = color_array_text
            Btext2.textColor = color_array_text
            Btext3.textColor = color_array_text
            Btext4.textColor = color_array_text
            Btext5.textColor = color_array_text
            Btext6.textColor = color_array_text
            Btext7.textColor = color_array_text
        }
    }
    
    func changeCountingTextColor(_ arr: Array<Int>)
    {
        var num1 = arr[arr.count - 4] as! Int
        switch num1
        {
        case 0:
            countText1.textColor = color_text_highlighter
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 1:
            countText1.textColor = color_array_text
            countText2.textColor = color_text_highlighter
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 2:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_text_highlighter
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 3:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_text_highlighter
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 4:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_text_highlighter
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 5:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_text_highlighter
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 6:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_text_highlighter
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 7:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_text_highlighter
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        case 8:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_text_highlighter
//            countText10.textColor = color_array_text
        case 9:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_text_highlighter
        default:
            countText1.textColor = color_array_text
            countText2.textColor = color_array_text
            countText3.textColor = color_array_text
            countText4.textColor = color_array_text
            countText5.textColor = color_array_text
            countText6.textColor = color_array_text
            countText7.textColor = color_array_text
            countText8.textColor = color_array_text
            countText9.textColor = color_array_text
//            countText10.textColor = color_array_text
        }
    }
}

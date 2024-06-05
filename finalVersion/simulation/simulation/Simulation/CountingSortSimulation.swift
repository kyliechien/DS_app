//
//  CountingSortSimulation.swift
//  simulation
//
//  Created by WanHsuan on 2023/8/3.
//

//import Foundation
import UIKit
import SideMenu

class CountingSortSimulation: UIViewController, MenuControllerDelegate {
    
    var sideMenu: SideMenuNavigationController?
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var text5: UITextField!
    @IBOutlet var text6: UITextField!
    @IBOutlet var text7: UITextField!
    var textFields: [UITextField] = []
    
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
    var textCountLabels: [UILabel] = []
    
    @IBOutlet var Btext1: UILabel!
    @IBOutlet var Btext2: UILabel!
    @IBOutlet var Btext3: UILabel!
    @IBOutlet var Btext4: UILabel!
    @IBOutlet var Btext5: UILabel!
    @IBOutlet var Btext6: UILabel!
    @IBOutlet var Btext7: UILabel!
    var textBLabels: [UILabel] = []
    
    @IBOutlet var introduce: UILabel!
    @IBOutlet var stepNum: UILabel!
    @IBOutlet var iLabel: UILabel!
//    @IBOutlet var jLabel: UILabel!
//    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var principle: UILabel!//﻿改過
    
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
    var countStack: [UIStackView] = []
    
    @IBOutlet var BStack: UIStackView!
    
    
    
    var arr = [Int]()
    var changeArr = [Int]()
    var totalStep = 1
    var everyStep = [Int: Array<Int>]()
    var currentStep = 0
    var maxValue = 0
    
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
          let menu = MenuController(with: ["模擬","練習","相關程式碼","相關影片","回到排序選擇畫面"])
          
          menu.delegate = self
          
          sideMenu = SideMenuNavigationController(rootViewController: menu)
          sideMenu?.leftSide = true
          SideMenuManager.default.leftMenuNavigationController = sideMenu
          SideMenuManager.default.addPanGestureToPresent(toView: self.view)


      }
    
    @IBAction func goInstruction(_ sender: UIButton) {
          let instructionVc = self.storyboard?.instantiateViewController(withIdentifier: "instruction") as! InstructionViewController
          self.navigationController?.pushViewController(instructionVc, animated: true)
      }

    
    @IBAction func goToSortSourceCode(_ sender: UIButton) {
        performSegue(withIdentifier: "toCountingSortSourceCode", sender: self)
    }
    

    @IBAction func turnBackMenu(_ sender: UIButton) {
    //        self.navigationController?.popViewController(animated: true)
            present(sideMenu!, animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          if segue.identifier == "toCountingSortSourceCode" {
              let pageSource = segue.destination as! CountingSortSourceCode
              pageSource.currentStep = currentStep
              pageSource.everyStep = everyStep
              pageSource.previousVC = self
              pageSource.totalStep = totalStep
              pageSource.arr = arr
              pageSource.changeArr = changeArr
              pageSource.maxValue = maxValue
      //        pageSource.maxValue = maxValue
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
            let randomNumber = Int(arc4random_uniform(9)) + 1//1~9
            randArr.append(randomNumber)
            
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
        //currentStep += 1
        //preStep.isEnabled = true
        //stepNum.text = "\(currentStep) / \(everyStep.count)"
        
        if currentStep == 0
        {
            if userInput()
            {
                currentStep += 1
                //preStep.isEnabled = true
                principle.isHidden = true//﻿改過
                
                stepNum.text = "\(currentStep) / \(everyStep.count)"
                
                if let stepArr = everyStep[currentStep]
                {
                    introduceStep(stepArr[stepArr.count - 3])
                    showI(stepArr[stepArr.count - 6])
                    
                    if currentStep < changeArr[0]
                    {
                        changeBG(stepArr[stepArr.count - 5])
                        changeCountingTextColor(stepArr[stepArr.count - 4])
                        showCurrCountArr(stepArr)
                        //changeBucketTextColor(everyStep[currentStep]!)
                        
                    }
                    else if currentStep < changeArr[1]
                    {
                        showCurrCountArr(stepArr)
                        changeCountingTextColor(stepArr[stepArr.count - 4])
                        
                    }
                    else
                    {
                        showCurrBArr(everyStep[currentStep]!)
                        changeBG(stepArr[stepArr.count - 5])
                        changeCountingBG(stepArr[stepArr.count - 2])
                        changeBTextColor(stepArr[stepArr.count - 1])
                        
                        changeCountingTextColor(stepArr[stepArr.count - 4])
                        showCurrCountArr(stepArr)
                        
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
                introduceStep(stepArr[stepArr.count - 3])
                showI(stepArr[stepArr.count - 6])
                
                if currentStep < changeArr[0]
                {
                    changeBG(stepArr[stepArr.count - 5])
                    changeCountingTextColor(stepArr[stepArr.count - 4])
                    showCurrCountArr(stepArr)
                    //changeBucketTextColor(everyStep[currentStep]!)
                    
                }
                else if currentStep < changeArr[1]
                {
                    showCurrCountArr(stepArr)
                    changeCountingTextColor(stepArr[stepArr.count - 4])
                    
                }
                else
                {
                    showCurrBArr(everyStep[currentStep]!)
                    changeBG(stepArr[stepArr.count - 5])
                    changeCountingBG(stepArr[stepArr.count - 2])
                    changeBTextColor(stepArr[stepArr.count - 1])
                    
                    changeCountingTextColor(stepArr[stepArr.count - 4])
                    showCurrCountArr(stepArr)
                    
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
            introduceStep(stepArr[stepArr.count - 3])
            showI(stepArr[stepArr.count - 6])
            
            if currentStep < changeArr[0]
            {
                changeBG(stepArr[stepArr.count - 5])
                changeCountingTextColor(stepArr[stepArr.count - 4])
                showCurrCountArr(stepArr)
                //changeBucketTextColor(everyStep[currentStep]!)
                
            }
            else if currentStep < changeArr[1]
            {
                showCurrCountArr(stepArr)
                changeCountingTextColor(stepArr[stepArr.count - 4])
                
            }
            else
            {
                showCurrBArr(everyStep[currentStep]!)
                changeBG(stepArr[stepArr.count - 5])
                changeCountingBG(stepArr[stepArr.count - 2])
                changeBTextColor(stepArr[stepArr.count - 1])
                
                changeCountingTextColor(stepArr[stepArr.count - 4])
                showCurrCountArr(stepArr)
                
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
    
    func showArr(_ inputArr: Array<Int>)
    {
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        
        for i in 0..<textFields.count
        {
            //textFields[i].text = inputArr[i]
            textFields[i].text = "\(inputArr[i])"
        }
        
    }
    
    func show_B_CArrLength(_ maxValue: Int)
    {
        
        BStack.isHidden = false
        /*
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
        }*/
        
        countStack = [countStack1, countStack2, countStack3, countStack4, countStack5, countStack6, countStack7, countStack8, countStack9]
        
        if maxValue > 0 && maxValue < 10
        {
            for i in 0..<maxValue
            {
                countStack[i].isHidden = false
                
            }
        }
        else
        {
            for i in 0..<countStack.count
            {
                countStack[i].isHidden = true
            }
            BStack.isHidden = true
        }
        
    }
    
    func reset()
    {
        preStep.isEnabled = false
        nextStep.isEnabled = true
        principle.isHidden = false//﻿改過
        
        show_B_CArrLength(-1)
        totalStep = 1
        everyStep.removeAll()
        currentStep = 0
        
        introduce.text = ""
        stepNum.text = "/"
        iLabel.text = "i = "
//        jLabel.text = "i = "
//        keyLabel.text = "key = "
        
        textFields = [text1, text2, text3, text4, text5, text6, text7]
        textBLabels = [Btext1, Btext2, Btext3, Btext4, Btext5, Btext6, Btext7]
        
        for i in 0..<textFields.count
        {
            textFields[i].backgroundColor = color_array_bg
            textFields[i].textColor = color_array_text
            textBLabels[i].text = ""
        }
        
        
        textCountLabels = [countText1, countText2, countText3, countText4, countText5, countText6, countText7, countText8, countText9]
        for i in 0..<textCountLabels.count
        {
            textCountLabels[i].backgroundColor = color_array_bg
            textCountLabels[i].text = ""
        }
        
    }
    
    func introduceStep(_ num1: Int)
    {
        //var num1 = arr[arr.count - 3] as! Int
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
    
    func showI(_ num1: Int)
    {
        //var num1 = arr[arr.count - 6] as! Int
        
        if num1 != -2
        {
            iLabel.text  = "i = \(num1 + 1)"
        }
        else
        {
            iLabel.text = "i = ?"
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
    
    func changeCountingBG(_ num1: Int)
    {
        textCountLabels = [countText1, countText2, countText3, countText4, countText5, countText6, countText7, countText8, countText9]
        if num1 >= 0 && num1 < 9
        {
            for i in 0..<textCountLabels.count
            {
                if i == num1
                {
                    textCountLabels[i].backgroundColor = color_bg_highlighter
                }
                else
                {
                    textCountLabels[i].backgroundColor = color_array_bg
                }
                
            }
        }
        else
        {
            for i in 0..<textFields.count
            {
                textCountLabels[i].backgroundColor = color_array_bg
            }
        }
        
    }
    
    
    func changeBTextColor(_ num1: Int)
    {
        textBLabels = [Btext1, Btext2, Btext3, Btext4, Btext5, Btext6, Btext7]
        
        if num1 >= 0 && num1 < 7
        {
            for i in 0..<textBLabels.count
            {
                if i == num1
                {
                    textBLabels[i].textColor = color_text_highlighter
                }
                else
                {
                    textBLabels[i].textColor = color_array_text
                }
                
            }
        }
        else
        {
            for i in 0..<textBLabels.count
            {
                textBLabels[i].textColor = color_array_text
            }
        }
        
    }
    
    func changeCountingTextColor(_ num1: Int)
    {
        textCountLabels = [countText1, countText2, countText3, countText4, countText5, countText6, countText7, countText8, countText9]
        if num1 >= 0 && num1 < 9
        {
            for i in 0..<textCountLabels.count
            {
                if i == num1
                {
                    textCountLabels[i].textColor = color_text_highlighter
                }
                else
                {
                    textCountLabels[i].textColor = color_array_text
                }
                
            }
        }
        else
        {
            for i in 0..<textFields.count
            {
                textCountLabels[i].textColor = color_array_text
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

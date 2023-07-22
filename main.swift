//
//  ViewController.swift
//  insertSort
//
//  Created by U10916004 on 2023/7/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var text4: UITextField!
    @IBOutlet var nextStep: UIButton!
    
    var arr = [Int](repeating: 0, count: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showNumber(sender: UIButton)
    {
        //var arr = [Int](repeating: 0, count: 4)
        for index in 0..<arr.count
        {
            arr[index] = Int.random(in: 1..<10)
            print(arr[index])
        }
        reset()
        showArr()
        
    }
    
    @IBAction func nextStep(sender: UIButton)
    {
        let isFinish = compare2item()
        showArr()
        
        if isFinish
        {
            nextStep.isEnabled = false
        }
    }
    
    var current = 1
    var point = 2
    var isChange = false
    
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
        

 /*
    func insertionSortStep()
    {
        for i in current..<arr.count
        {
            print("now:\(i)")
            let key = arr[i]
            var j = i - 1
            
            while j >= 0 && arr[j] > key
            {
                arr[j + 1] = arr[j]
                if j == 0
                {
                    current = i + 1
                    
                }
                else
                {
                    current = j
                }
                j -= 1
                isChange = true
                break
            }
            arr[j + 1] = key
            
            if isChange
            {
                isChange = false
                break
            }
        }
    }
  */
    
    func showArr()
    {
        text1.text = String(arr[0])
        text2.text = String(arr[1])
        text3.text = String(arr[2])
        text4.text = String(arr[3])
    }
    
    func reset()
    {
        nextStep.isEnabled = true
        current = 1
        point = 2
        //isChange = false
        
    }
    func changeBG(_ num1: Int)
    {
        switch num1
        {
        case 1:
            text1.backgroundColor = UIColor.yellow
            text2.backgroundColor = UIColor.yellow
            text3.backgroundColor = UIColor.white
            text4.backgroundColor = UIColor.white
        case 2:
            text2.backgroundColor = UIColor.yellow
            text3.backgroundColor = UIColor.yellow
            text1.backgroundColor = UIColor.white
            text4.backgroundColor = UIColor.white
        case 3:
            text3.backgroundColor = UIColor.yellow
            text4.backgroundColor = UIColor.yellow
            text1.backgroundColor = UIColor.white
            text2.backgroundColor = UIColor.white
        default:
            text1.backgroundColor = UIColor.white
            text2.backgroundColor = UIColor.white
            text3.backgroundColor = UIColor.white
            text4.backgroundColor = UIColor.white
        }
    }
    
    func changeTextColor(_ num1: Int)
    {
        switch num1
        {
        case 1:
            text1.textColor = UIColor.red
            text2.textColor = UIColor.red
            text3.textColor = UIColor.black
            text4.textColor = UIColor.black
        case 2:
            text2.textColor = UIColor.red
            text3.textColor = UIColor.red
            text1.textColor = UIColor.black
            text4.textColor = UIColor.black
            
        case 3:
            text3.textColor = UIColor.red
            text4.textColor = UIColor.red
            text1.textColor = UIColor.black
            text2.textColor = UIColor.black
            
        default:
            text1.textColor = UIColor.black
            text2.textColor = UIColor.black
            text3.textColor = UIColor.black
            text4.textColor = UIColor.black
        }
    }
    
}

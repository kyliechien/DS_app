//
//  InstructionViewController.swift
//  simulation
//
//  Created by WanHsuan on 2023/11/29.
//

import UIKit

class InstructionViewController: UIViewController{
    
    @IBOutlet var button1: UIButton! {
        didSet {
            button1.layer.cornerRadius = button1.bounds.width/2
        }
    }
    
    
    
    @IBAction func turnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
}

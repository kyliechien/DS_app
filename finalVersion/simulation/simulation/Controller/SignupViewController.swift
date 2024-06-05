//
//  SignupViewController.swift
//  simulation
//
//  Created by U10916003 on 2023/10/20.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var newAccount: UITextField!
    @IBOutlet weak var newUsername: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var oncePassword: UITextField!
    @IBOutlet weak var emailHint: UILabel!
    @IBOutlet weak var passwordHint: UILabel!
    @IBOutlet weak var oncePasswordHint: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hintInitailize()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: UIButton){
        
        hintInitailize()
        
        if(newPassword.text == oncePassword.text){

            Auth.auth().createUser(withEmail: newAccount.text!, password: newPassword.text!){ result, error in
                guard let user = result?.user,
                      error == nil else{
                    
                    
                    
                    switch error?.localizedDescription {
                        
                    case "The email address is already in use by another account.":
                        self.emailHint.text = "該電子信箱已被使用"
                        self.emailHint.isHidden = false
                        
                    case "An email address must be provided.":
                        self.emailHint.text = "未填寫電子信箱"
                        self.emailHint.isHidden = false
                        
                    case "The email address is badly formatted.":
                        self.emailHint.text = "信箱格式錯誤"
                        self.emailHint.isHidden = false
                        
                    case "The password must be 6 characters long or more.":
                        self.passwordHint.isHidden = false
                        
                    default:
                        break
                    }
                    
                    
                    return
                }
                
                // change user name, but I don't know where to check this
                

                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.newUsername?.text

                changeRequest?.commitChanges(completion: { error in
                    guard error == nil else{
                        print(error?.localizedDescription)
                        return
                    }
                    
                    let currentUser = Auth.auth().currentUser
                    let uid = currentUser?.uid
                    let userName = currentUser?.displayName
                    let dataProcess = DataProcess()
                    dataProcess.newUser(UID: uid!, userName: userName!)
                })
                
            
                
                
                

                
                let alertController = UIAlertController(title: "註冊成功", message: "您已註冊成功，點擊確認鈕回到登入畫面", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "確認", style: .default) { action in
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(confirm)
                self.present(alertController, animated: true,completion: nil)
                
            }
        }
        else{
            oncePasswordHint.isHidden = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func hintInitailize(){
        emailHint.isHidden = true
        passwordHint.isHidden = true
        oncePasswordHint.isHidden = true
    }
    
    @IBAction func backToSignin(){
        self.dismiss(animated: true, completion: nil)
    }
}

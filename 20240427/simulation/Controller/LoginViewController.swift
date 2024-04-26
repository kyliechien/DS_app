//
//  LoginViewController.swift
//  simulation
//
//  Created by U10916003 on 2023/10/17.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(){
        Auth.auth().signIn(withEmail: accountTextField.text!, password: passwordTextField.text!){ result, error in
            guard let user = result?.user, error == nil else {
                let alertController = UIAlertController(title: "登入失敗", message: "帳號或密碼錯誤", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "確認", style: .default, handler: nil)
                alertController.addAction(confirm)
                self.present(alertController, animated: true,completion: nil)
                return
            }
            
            if let user = Auth.auth().currentUser{
                //print("\(user.displayName) welcome back")
                self.performSegue(withIdentifier: "toHomepage", sender: self)
                
            }
        }
    }
    
    
    @IBAction func forgetPassword() {
        
        let controller = UIAlertController(title: "重設密碼", message: "請輸入你註冊時使用的電子信箱", preferredStyle: .alert)
        controller.addTextField { textField in
           textField.placeholder = "E-mail"
        }
        
        let okAction = UIAlertAction(title: "確認", style: .default) { [unowned controller] _ in
           guard let inputEmail = controller.textFields?[0].text, !inputEmail.isEmpty else {
               
               let alertController = UIAlertController(title: "錯誤", message: "請輸入電子信箱", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
               alertController.addAction(okAction)
               self.present(alertController, animated: true, completion: nil)
               return
           }
            
            
            Auth.auth().sendPasswordReset(withEmail: inputEmail, completion: { (error) in
                if error != nil {
                    return
                }
            })
            
            let alertController = UIAlertController(title: "發送成功", message: "請查看您填寫的信箱並進行重設密碼", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(confirm)
            self.present(alertController, animated: true,completion: nil)
        }

        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
        
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
}

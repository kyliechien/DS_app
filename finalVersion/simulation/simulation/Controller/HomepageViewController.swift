//
//  HomeViewController.swift
//  simulation
//
//  Created by U10916003 on 2023/9/1.
//

import UIKit
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class HomepageViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var learnButton: UIButton!
    @IBOutlet var testButton: UIButton!
    
    @IBOutlet var insertionPrac: UIButton!
    @IBOutlet var countingPrac: UIButton!
    @IBOutlet var quickPrac: UIButton!
    @IBOutlet var mergePrac: UIButton!
    
    var color = UIColor(rgb: 0x363636)
    var pracBackColor = UIColor(rgb: 0xE7EAFF )
    var pracTitleColor = UIColor(rgb: 0x6B77B7)
    var pracSubtitleColor = UIColor(rgb: 0x676565)
    var pracTitleFont = UIFont.systemFont(ofSize: 38)
    var pracSubtitleFont = UIFont.systemFont(ofSize: 28)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // MARK: - Learn button
        let learnSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let learnSymbolImage = UIImage(systemName: "book", withConfiguration: learnSymbolConfig)
        let learnColoredSymbolImage = learnSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        learnButton.setImage(learnColoredSymbolImage, for: .normal)
        
        // MARK: - Home button
        let homeSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let homeSymbolImage = UIImage(systemName: "house.fill", withConfiguration: homeSymbolConfig)
        let homeColoredSymbolImage = homeSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        homeButton.setImage(homeColoredSymbolImage, for: .normal)
        
        // MARK: - Test button
        let testSymbolConfig = UIImage.SymbolConfiguration(pointSize: 50.0)
        let testSymbolImage = UIImage(systemName: "graduationcap", withConfiguration: testSymbolConfig)
        let testColoredSymbolImage = testSymbolImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        testButton.setImage(testColoredSymbolImage, for: .normal)
        
        //starImage.size
        
        
//        let colorView = UIView()
//
//        colorView.backgroundColor = UIColor(rgb: 0x4A618F)
//        view.addSubview(colorView)
//               
//        colorView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            colorView.heightAnchor.constraint(equalToConstant: 102)
//               ])
        
        
        
        // MARK: - everyPrac setting
        
        let sortPrac = [insertionPrac, countingPrac, quickPrac, mergePrac]
        
        
        for perPrac in sortPrac {
            perPrac?.backgroundColor = pracBackColor
            perPrac?.titleLabel?.textColor = pracTitleColor
            perPrac?.titleLabel?.font = pracTitleFont
            perPrac?.subtitleLabel?.textColor = pracSubtitleColor
            perPrac?.subtitleLabel?.font = pracSubtitleFont
        }
        
        
        insertionPrac.titleLabel?.text = "插入排序 (insertion sort)"
        countingPrac.titleLabel?.text = "計數排序 (counting sort)"
        quickPrac.titleLabel?.text = "快速排序 (quick sort)"
        mergePrac.titleLabel?.text = "合併排序 (merge sort)"
        
        // MARK: - Load Data, upload content
        
        let user = Auth.auth().currentUser
        let uid = (user?.uid)!
        let dataProcess = DataProcess()
        var totalStars = 0
        
        
        dataProcess.loadUserFromData(UID: uid) { (user) in
            if let user = user {
                
                for perStar in user.getStars() {
                    totalStars += perStar
                }
                
                self.userNameLabel.text = user.getUserName()
                self.starsLabel.text = String(totalStars)
                
                for index in 0..<user.getPracticePass().count {
                    if user.getPracticePass()[index] == true {
                        sortPrac[index]?.subtitleLabel?.text = "練習通過狀態：已通過"
                    }
                    else {
                        sortPrac[index]?.subtitleLabel?.text = "練習通過狀態：未通過"
                    }
                }
            }
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
    @IBAction func goToLearn(_ sender: UIButton){
        self.performSegue(withIdentifier: "toLearn", sender: self)
    }
    
    @IBAction func goToTest(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTest", sender: self)
    }
    
    @IBAction func logout(_ sender: UIButton){
        do {
          try Auth.auth().signOut()
            performSegue(withIdentifier: "unwindToLogin", sender: self)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

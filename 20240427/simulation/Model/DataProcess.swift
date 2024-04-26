//
//  DataProcess.swift
//  simulation
//
//  Created by U10916003 on 2023/10/23.
//
// this class for process with firebase like store and load

import Foundation
import FirebaseFirestore



class DataProcess{
    
    let db = Firestore.firestore()
    
    
    
    // when sign up a new account, new
    func newUser(UID : String, userName: String){
        
        let userInitData: [String: Any] = [
            "userName" : userName,
            "testStars" : Array(repeating: 0, count: 5),
            "practicePass" : Array(repeating: false, count: 4)
        ]
        
        db.collection("users").document(UID).setData(userInitData) { error in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
    func updateStar(UID : String, stage: Int, stars: Int){

        
        let docRef = db.collection("users").document(UID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var currentArray = document.data()?["testStars"] as? [Int] ?? []
                
                if stage < currentArray.count {
                    
                    if currentArray[stage] < stars {
                        currentArray[stage] = stars
                        docRef.updateData(["testStars" : currentArray]) { error in
                            if let error = error {
                                print("error")
                            } else {
                                print("success")
                            }
                        }
                    }
   
                }
            }
            
        }
    }
    
    
    func getUserName(UID: String, completion: @escaping (String?) -> Void) {
        let docRef = db.collection("users").document(UID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let userName = document.data()?["userName"] as? String {
                    completion(userName)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
//    func updateUserName(UID : String, newUserName: String){
//        
//        let docRef = db.collection("users").document(UID)
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                docRef.updateData(["userName" : newUserName]) { error in
//                    if let error = error {
//                        print("error")
//                    }
//                    else {
//                        print("success")
//                    }
//                }
//                
//            }
//        }
//    }
    
    func loadUserFromData(UID: String, completion: @escaping (Users?) -> Void) {
        let docRef = db.collection("users").document(UID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let userName = document.data()?["userName"] as? String,
                   let testStars = document.data()?["testStars"] as? [Int], let practicePass = document.data()?["practicePass"] as? [Bool] {
                    
                    let fetchedUser = Users(userName: userName, testStars: testStars, practicePass: practicePass)
                    completion(fetchedUser)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    
    func updatePracticePass(UID : String, sortType: Int){
        
        let docRef = db.collection("users").document(UID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var currentArray = document.data()?["practicePass"] as? [Bool] ?? []
                
                
                if currentArray[sortType] == false {
                    currentArray[sortType] = true
                    docRef.updateData(["practicePass" : currentArray]) { error in
                        if let error = error {
                            print("error")
                        }
                        else {
                            print("success")
                        }
                    }
                }
            }
        }
    }
    
    
    
}




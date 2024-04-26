//
//  Users.swift
//  simulation
//
//  Created by U10916003 on 2023/10/22.
//

import Foundation

class Users{
    private var userName: String
    private var testStars: [Int]
    private var practicePass : [Bool]
    
    init(userName: String, testStars: [Int], practicePass: [Bool]) {
        self.userName = userName
        self.testStars = testStars
        self.practicePass = practicePass
    }
    
    convenience init(){
        self.init(userName : "", testStars: Array(repeating: 0, count: 5), practicePass: Array(repeating: false, count: 4))
    }
    
    
    // get user information from db
    func getUserName() -> String{
        return userName
    }
    
    
    func getStars() -> [Int] {
        return testStars
    }
    
    func getPracticePass() -> [Bool] {
        return practicePass
    }
}



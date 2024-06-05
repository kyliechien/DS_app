//
//  Repository.swift
//  simulation
//
//  Created by U10916003 on 2023/8/11.
//

import Foundation

class Repository{
    // Mark: information
    var name: String
    var html_url: String
    var stars: Int
    var login: String
    var language: String
    
    init(name: String, html_url: String, stars: Int, login: String, language: String) {
        self.name = name
        self.html_url = html_url
        self.stars = stars
        self.login = login
        self.language = language
    }
    
    convenience init(){
        self.init(name: "", html_url: "", stars: 0, login: "", language: "")
    }
}

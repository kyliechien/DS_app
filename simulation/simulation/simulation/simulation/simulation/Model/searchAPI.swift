//
//  searchAPI.swift
//  simulation
//
//  Created by U10916003 on 2023/8/11.
//
//import FirebaseDatabase
import Foundation


class searchAPI{
    var repositories: [Repository] = []
    
    init(){}
    
    // Mark: Github Request API
    
    func searchGitHubRepositories(keyword: String, completion: @escaping ([Repository]?, Error?) -> Void) {
        let accessToken = "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"
        let urlString = "https://api.github.com/search/repositories?q=\(keyword)"
        //default is the most related to keyword
        //next line can insert at tail to request API return others content
        //&sort=stars&order=desc
        //&page=2
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let items = json["items"] as? [[String: Any]] {
                    
                    for item in items {
                        if let name = item["name"] as? String,
                           let stars = item["stargazers_count"] as? Int,
                           let html_url = item["html_url"] as? String,let owner = item["owner"] as? [String: Any], let login = owner["login"] as? String, let language = item["language"] as? String
                        {
                            self.repositories.append(Repository(name: name, html_url: html_url, stars: stars, login: login, language: language))
                        }
                    }
                    

                    
                    completion(self.repositories, nil)
                } else {
                    completion(nil, NSError(domain: "JSON Parsing Error", code: -1, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }

    func getRepos() -> [Repository]{
        return repositories
    }
    
}

//
//  searchAPI.swift
//  simulation
//
//  Created by U10916003 on 2023/8/11.
//
//import FirebaseDatabase
import Foundation


// MARK: - Youtube API struct
struct SearchResponse: Codable{
    let items: [Item]
    let nextPageToken : String
    
    struct Item: Codable{
        let snippet: Snippet
        let id: Id
        
        
        struct Id: Codable{
            let videoId: String
        }

        struct Snippet: Codable{
            let title: String
            let thumbnails: Thumbnail
            let channelTitle: String
            
            struct Thumbnail: Codable {
                let medium: ThumbnailImage
                let high: ThumbnailImage
                struct ThumbnailImage: Codable {
                    let url: URL
                }
            }
            
        }
    }
}

struct Video{
    let title: String
    let thumbnailUrl: URL
    let videoId: String
    let channelTitle: String
}




class searchAPI{
    var repositories: [Repository] = []
    var newVideos: [Video] = []
    var searchToken: String = ""
    
    init(){}
    
    // Mark: Github Request API
    
    func searchGitHubRepositories(keyword: String, pageNum : Int, language: String, sequence: String, completion: @escaping ([Repository]?, Error?) -> Void) {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
        guard let accessToken : String = infoDictionary["Github_API_KEY"] as? String else { return }
        
        
        
        let urlString = "https://api.github.com/search/repositories?q=\(keyword)+language:\(language)&page=\(pageNum)&sort=\(sequence)"
        
        
        
        let urlTemp = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    
        
        
        
        
        //default is the most related to keyword
        //next line can insert at tail to request API return others content
        //&sort=stars&order=desc
        //&page=2
        //"https://api.github.com/search/repositories?q=\(keyword)+language:C&page=\(pageNum)&sort=stars&order=desc"
        
        
        guard let url = URL(string: urlTemp) else {
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

    
    func searchYoutubeVideo(keyword: String, pageToken: String, completion: @escaping([Video]?, Error?) ->Void){
        
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
        guard let apiKey : String = infoDictionary["Youtube_API_KEY"] as? String else { return }
        
       

        
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=\(keyword)&key=\(apiKey)&pageToken=\(pageToken)"
        
        
        
        if let url = URL(string: urlString) {
               URLSession.shared.dataTask(with: url) { data, response, error in
                   let decoder = JSONDecoder()
                   //decoder.dateDecodingStrategy = .iso8601
                   if let data = data {
                       do {
                           let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                           
                           self.searchToken = searchResponse.nextPageToken
                           
                           for item in searchResponse.items {
                               let newVideo = Video(title: item.snippet.title, thumbnailUrl: item.snippet.thumbnails.medium.url, videoId: item.id.videoId, channelTitle: item.snippet.channelTitle)
                               self.newVideos += [newVideo]
                           }
                           
                           completion(self.newVideos,nil)
                       } catch {
                           print(error)
                       }
                   }
               }.resume()
           }
        
    }
    func getVideo() -> [Video]{
        return newVideos
    }
    
    func initRepo() {
        repositories = []
    }
    
    
    
}

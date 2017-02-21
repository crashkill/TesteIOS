//
//  Repo.swift
//  FabricioCardoso
//
//  Created by Fabricio Cardoso on 20/02/17.
//  Copyright © 2017 Fabricio Cardoso. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class RepoSearch {
    
    static func search(page: String? = "1", completionHandler: @escaping (_ success: Itens, _ fail: String?) -> ())
    {
        let URL = ("https://api.github.com/search/repositories?q=language:Java&sort=stars&page=" + page!)
        
        print("URL: ",URL)
        
        // TODO
        // Tratar se é places ou app
        Alamofire.request(URL).responseObject { (response: DataResponse<Itens>) in
            
            
            var model: Itens = Itens()
            let response = response.result.value
            
            if(response != nil){
                model = (response!)
            }
            
            completionHandler(model, "")
            
        }
    }
}


class Itens: Mappable {
    
    var repo: [Repo]?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map) {
        repo <- map["items"]
    }
}

class Repo: Mappable {
    
    var id: Int?
    var name: String?
    var full_name: String?
    var pulls_url: String?
    var avatar_url: String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        full_name <- map["full_name"]
        pulls_url <- map["pulls_url"]
        avatar_url <- map["avatar_url"]
    }
}

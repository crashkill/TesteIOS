//
//  PullRequest.swift
//  FabricioCardoso
//
//  Created by Fabricio Cardoso on 20/02/17.
//  Copyright © 2017 Fabricio Cardoso. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class PullRequestSearch {
    
    static func search(repo: Repo, completionHandler: @escaping (_ success: [PullRequest], _ fail: String?) -> ())
    {
        let URL = (repo.pulls_url!).replacingOccurrences(of: "{/number}", with: "")
        
        print("URL: ",URL)
        
        Alamofire.request(URL).responseObject { (response: DataResponse<PullRequest>) in
            
            
            var model: Array<PullRequest> = Array<PullRequest>()
            let response = response.result.value
            
            if(response != nil){
                model.append(response!)
            }
            
            completionHandler(model, "")
            
        }
    }
}


class PullRequest: Mappable {
    
    var title: String?
    var body: String?
    var created_at: String?
    
    var user: User?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        body <- map["body"]
        created_at <- map["created_at"]
    }
}

class User: Mappable {

    var login: String?
    var avatar_url: String?
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map) {
        avatar_url <- map["avatar_url"]
        login <- map["login"]
    }
        
}

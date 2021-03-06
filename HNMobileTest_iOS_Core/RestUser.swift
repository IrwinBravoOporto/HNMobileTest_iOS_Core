//
//  RestUser.swift
//  HNMobileTest_iOS_Core
//
//  Created by everis on 1/02/21.
//

import CoreData
import Alamofire

class RestClient {

    var baseEndpoint: String

    class var sharedInstance:RestClient {
        return restClient
    }
    
    

    init() {
        let path = Bundle.main.path(forResource: "Info", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        baseEndpoint = dict?.object(forKey: "URL_SERVICES") as! String
    }

    func hits(completion: @escaping (News?) -> Void, failure:((Error) -> Void)!) {
        let urlString = "\(baseEndpoint)v1/search_by_date?query=ios"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let hitRequest = try decoder.decode(News.self, from: data)
                completion(hitRequest)
            } catch let error {
                failure(error)
            }
        }
    }

}

let restClient = RestClient()


//
//  BGNetworkController.swift
//  BitGallery
//
//  Created by Khagesh Patel on 2/6/21.
//

import Foundation

class BGNetworkController {
    
    func getBitbucketRepositories(urlString: String, completion: @escaping (BGRepository?, Error?) -> Void) {
        getAPICall(urlString: urlString) { response, error in
            if let response = response {
                
                do {
                    let repository = try JSONDecoder().decode(BGRepository.self, from: response)
                    completion(repository, nil)
                    
                } catch let error {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
                
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getAPICall(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
}

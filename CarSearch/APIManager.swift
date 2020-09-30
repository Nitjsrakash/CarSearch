//
//  ApiManager.swift
//  CarSearch
//
//  Created by Mac on 03/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class APIManager{
    
    static let api = APIManager()
    
  private init() {
    }
    
    func onGet(value: String, completionHendler: @escaping (Data?,Error?) -> Void){
         let urlString = Constants.BaseURL + value
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                completionHendler(data,nil)
            }
            else{
                completionHendler(nil,error)
            }
        }.resume()
    }
}


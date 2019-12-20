//
//  ApiController.swift
//  ProductRaj
//
//  Created by Techops on 20/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

protocol ControllerDelegate: NSObjectProtocol {
    func responseDataForProducts(respJson: [[String: Any]])
}

class ApiController: NSObject {
    
    var delegate: ControllerDelegate?
    
    public func readProductJSON() -> [[String: Any]] {
        var response: [[String: Any]] = [[String: Any]]()
        if let path = Bundle.main.path(forResource: "ProductRaj/ProductJson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                response = jsonResult as! [[String : Any]]
                if (delegate != nil) {
                    self.delegate?.responseDataForProducts(respJson: response)
                }
            } catch {
                // handle error
            }
        }
        return response
    }
    
    public func getProductListFromServer(withUrl: String) {
        
        var apiResponse: [[String: Any]] = [[String: Any]]()
        var request = URLRequest(url: URL(string: withUrl)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            DispatchQueue.main.async { [weak self] in
                if let strongSelf = self {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                        apiResponse = jsonResult as! [[String : Any]]
                        if (strongSelf.delegate != nil) {
                            strongSelf.delegate?.responseDataForProducts(respJson: apiResponse)
                        }
                        
                    } catch {
                        print("JSON Serialization error")
                        if (strongSelf.delegate != nil) {
                            strongSelf.delegate?.responseDataForProducts(respJson: apiResponse)
                        }
                    }
                }
            }
            
        }).resume()
    }
}

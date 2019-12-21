//
//  UserDefaultsUtility.swift
//  ProductRaj
//
//  Created by Techops on 21/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

class UserDefaultsUtility: NSObject {
    
    private let CartItems = "cartItems"
    
    static let sharedInstance = UserDefaultsUtility()
    
    public func readDataFromUserDefaults() -> [ProductList] {
        let userDefaults = UserDefaults.standard
        var cartModel: [ProductList] = [ProductList]()
        if let decoded  = userDefaults.data(forKey: CartItems) {

            do {
                let productList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! [ProductList]
                cartModel = productList

            } catch  {
                //Catch errors
            }
        }
        return cartModel
    }

    

}

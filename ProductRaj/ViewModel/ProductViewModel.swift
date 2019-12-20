//
//  ProductViewModel.swift
//  ProductRaj
//
//  Created by Techops on 20/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

protocol ProductListDelegate: NSObjectProtocol {
    func reloadCollectionView()
}

class ProductViewModel: NSObject {
    
    private var controller: ApiController = ApiController()
    public var model: [ProductList] = [ProductList]()
    public var cartModel: [ProductList] = [ProductList]()
    var delegate: ProductListDelegate?
    
    func getProductsList() {
        self.controller.delegate = self
        self.controller.getProductListFromServer(withUrl: ProductsListURL)
    }
}


extension ProductViewModel: ControllerDelegate {
    
    func responseDataForProducts(respJson: [[String: Any]]) {
        for i in 0..<respJson.count {
            var product: ProductList = ProductList()
            let currentValue = respJson[i]
            product = ProductList(dictionary: currentValue as NSDictionary)!
            self.model.append(product)
        }
        self.delegate?.reloadCollectionView()
    }
    
}

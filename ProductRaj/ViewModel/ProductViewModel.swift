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
    
    private let CartItems = "cartItems"
    private var controller: ApiController = ApiController()
    public var model: [ProductList] = [ProductList]()
    public var cartModel: [ProductList] = [ProductList]()
    var delegate: ProductListDelegate?
    
    func getProductsList() {
        self.controller.delegate = self
        self.controller.getProductListFromServer(withUrl: ProductsListURL)
    }
    
    //Cart CRUD operations
     private func addCartData(product: ProductList) {
         self.cartModel.append(product)
         self.saveToUserDefaults()
     }

     private func performUpdateOrDelete(productID: Int, countValue: String, actualProductList: ProductList) {

         let productFromModelList = self.cartModel.filter({$0.pID == productID})
         if !(productFromModelList.isEmpty) {
             if (countValue == "0") {
                 //Performs Deletion
                 self.cartModel.removeAll(where: {$0.pID == productFromModelList.first?.pID})
             } else {
                 //Performs Update
                 self.cartModel.filter{$0.pID == actualProductList.pID}.first?.pCount = String(countValue)
             }
         } else {
             self.addCartData(product: actualProductList)
         }
         self.saveToUserDefaults()
     }

     //UserDefaults CRUD
     public func readDataFromUserDefaults() {
         let userDefaults = UserDefaults.standard
         if let decoded  = userDefaults.data(forKey: CartItems) {

             do {
                 let productList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! [ProductList]
                 self.cartModel.removeAll()
                 self.cartModel = productList

             } catch  {
                 //Catch errors
             }
         }
     }

     private func deleteDataFromUserDefaults() {
         let domain = Bundle.main.bundleIdentifier!
         UserDefaults.standard.removePersistentDomain(forName: domain)
         UserDefaults.standard.synchronize()
         print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)

     }

     private func saveToUserDefaults() {
         if (self.cartModel.count < 1) { //Delete UserDefaults
             deleteDataFromUserDefaults()
         }
         do {
             let userDefaults = UserDefaults.standard
             let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: self.cartModel, requiringSecureCoding: false)
             userDefaults.set(encodedData, forKey: CartItems)
             userDefaults.synchronize()

         } catch  {
             //Handle Error
             //print(error)
         }
     }


     func processCartModel(productId_: Int, countValue_: String) {
         let productFromActualList = self.model.filter({$0.pID == productId_}).first
         //productFromActualList?.pCount = countValue_
         
         if !(self.cartModel.isEmpty) {
             self.performUpdateOrDelete(productID: productId_, countValue: countValue_, actualProductList: productFromActualList!)

         } else {
             self.addCartData(product: productFromActualList!)
         }
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

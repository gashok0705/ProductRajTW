//
//  WishListViewModel.swift
//  ProductRaj
//
//  Created by Techops on 21/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

protocol WishListDelegate: NSObjectProtocol {
    func populatUI()
}

class WishListViewModel: NSObject {
    
    public var wishList: WishLists = WishLists()
    weak var delegate: WishListDelegate?
    
    public func getWishListDetails(selectedProducts: [ProductList]) {
        let currentWishList: WishLists = WishLists()
        currentWishList.totalQuantity = String(selectedProducts.count)
        var offerPrice: Double = 0
        var totalPrice: Double = 0
        //var totalQuantity = 0
        for i in 0..<selectedProducts.count {
            let currentProduct = selectedProducts[i]
            if !(currentProduct.offerPrice!.isEmpty) {
                offerPrice = offerPrice + Double(currentProduct.offerPrice!.chopPrefix().removeComma())!
            }
            if !(currentProduct.price!.isEmpty) {
                totalPrice = totalPrice + Double(currentProduct.price!.chopPrefix().removeComma())!
            }
        }
        currentWishList.savings = String(offerPrice)
        currentWishList.totalPrice = String(totalPrice - offerPrice)
        self.wishList = currentWishList
        self.delegate?.populatUI()
    }

}

extension String {

    func chopPrefix(_ count: Int = 1) -> String {
        if count >= 0 && count <= self.count {
            let indexStartOfText = self.index(self.startIndex, offsetBy: count)
            return String(self[indexStartOfText...])
        }
        return ""
    }

    func chopSuffix(_ count: Int = 1) -> String {
        if count >= 0 && count <= self.count {
            let indexEndOfText = self.index(self.endIndex, offsetBy: -count)
            return String(self[..<indexEndOfText])
        }
        return ""
    }
    
    func removeComma() -> String { //I can handle here for removing $ too
        self.trimmingCharacters(in: NSCharacterSet.init(charactersIn: ",") as CharacterSet)
    }
}

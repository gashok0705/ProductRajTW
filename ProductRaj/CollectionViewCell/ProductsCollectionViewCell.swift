//
//  ProductsCollectionViewCell.swift
//  ProductRaj
//
//  Created by Techops on 20/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

protocol ProductsListCellDelegate: NSObjectProtocol {
    func getCounterData(productId: Int, countValue: String)
}

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleAndDesc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productStepper: UIStepper!
    @IBOutlet weak var productCount: UILabel!
    var delegate: ProductsListCellDelegate?
    
    override func awakeFromNib() {
        self.titleAndDesc.text = ""
        self.price.text = ""
        self.setUpLabel(label: self.titleAndDesc)
    }
    
    private func setUpLabel(label: UILabel) {
        //label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
    }
    
    func populateValues(model: ProductList, cartListItem: [ProductList]) {
        
        let filteredCartList = cartListItem.filter({$0.pID == model.pID})

        self.productCount.tag = model.pID!
        if !(filteredCartList.isEmpty) {
            self.productStepper.value = Double(filteredCartList.first!.pCount)!
            self.productCount.text = "(" + filteredCartList.first!.pCount + ")"
        } else {
            self.productCount.text = "(0)"
        }
        
        ImageLoader.image(for: URL(string: model.image!)!) { image in
          self.productImage.image = image
        }
        self.titleAndDesc.text = model.name
        if !model.offerPrice!.isEmpty {
            self.price.text = model.offerPrice
            self.price.textColor = UIColor.orange
        } else {
            self.price.text = model.price
            self.price.textColor = UIColor.gray
        }
    }
    
    @IBAction func counterValueChanges(_ sender: UIStepper) {
//        print(Int(sender.value).description)
//        print(self.productCount.tag)
        self.productCount.text = "(" + String(Int(sender.value).description) + ")"
        self.delegate?.getCounterData(productId: self.productCount.tag, countValue: String(Int(sender.value).description))
    }
    
}

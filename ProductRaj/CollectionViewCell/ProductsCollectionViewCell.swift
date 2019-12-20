//
//  ProductsCollectionViewCell.swift
//  ProductRaj
//
//  Created by Techops on 20/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleAndDesc: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        self.titleAndDesc.text = ""
        self.price.text = ""
        self.price.textColor = UIColor.gray
        self.setUpLabel(label: self.titleAndDesc)
        self.setUpLabel(label: self.price)
    }
    
    private func setUpLabel(label: UILabel) {
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
    }
    
    func populateValues(model: ProductList) {
        ImageLoader.image(for: URL(string: model.image!)!) { image in
          self.productImage.image = image
        }
        self.titleAndDesc.text = model.name
        if model.offerPrice != nil {
            self.price.text = model.offerPrice
            self.price.textColor = UIColor.orange
            return
        }
        self.price.text = model.price
        self.price.textColor = UIColor.gray
    }
    
}

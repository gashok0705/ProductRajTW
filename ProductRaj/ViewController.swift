//
//  ViewController.swift
//  ProductRaj
//
//  Created by Techops on 20/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    private var viewModel: ProductViewModel = ProductViewModel()
    private let ProductListSize: CGFloat = 200.0
    private let navBarTitle: String = "Shopper"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navBarTitle
        self.productCollectionView.dataSource = self
        self.productCollectionView.delegate = self
        self.viewModel.delegate = self
        self.getProductList()
        // Do any additional setup after loading the view.
    }
    
    private func getProductList() {
        self.viewModel.getProductsList()
    }
    
    private func setUpCollectionViewDataSource() {
        self.productCollectionView.reloadData()
        
    }
    
}

extension ViewController: ProductListDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ProductsListCellDelegate  {
    
    func reloadCollectionView() {
        self.setUpCollectionViewDataSource()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: ProductListSize)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        if let cell_ = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCellIdentifier, for: indexPath) as? ProductsCollectionViewCell {
            let currentModel = self.viewModel.model[indexPath.row]
            cell_.populateValues(model: currentModel)
            cell_.delegate = self
            cell = cell_
        }
        return cell
    }
    
    func getCounterData(productId: Int, countValue: String) { //Move to VM
        
        let productFromActualList = self.viewModel.model.filter({$0.pID == productId}).first
        self.viewModel.model.filter{$0.pID == productId}.first?.pCount = String(countValue)
        
        if !(self.viewModel.cartModel.isEmpty) {
            let productFromModelList = self.viewModel.cartModel.filter({$0.pID == productId})
            if !(productFromModelList.isEmpty) {
                if (countValue == "0") {
                    self.viewModel.cartModel.removeAll(where: {$0.pID == productFromModelList.first?.pID})
                } else {
                    self.viewModel.cartModel.filter{$0.pID == productFromActualList?.pID}.first?.pCount = String(countValue)
                }
            } else {
                productFromActualList?.pCount = countValue
                self.viewModel.cartModel.append(productFromActualList!)
            }
        } else {
            productFromActualList?.pCount = countValue
            self.viewModel.cartModel.append(productFromActualList!)
        }
        
    }
}


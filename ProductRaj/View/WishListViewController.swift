//
//  WishListViewController.swift
//  ProductRaj
//
//  Created by Techops on 21/12/19.
//  Copyright © 2019 Techops. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!

    private var selectedCartItems: [ProductList] = [ProductList]()
    private var viewModel: WishListViewModel = WishListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedCartItems = UserDefaultsUtility.sharedInstance.readDataFromUserDefaults()
        self.viewModel.delegate = self
        self.viewModel.getWishListDetails(selectedProducts: self.selectedCartItems)
        //print(selectedCartItems)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WishListViewController: WishListDelegate {
    
    func populatUI() {
        
        self.totalPrice.text = self.viewModel.wishList.totalPrice
        self.quantity.text = self.viewModel.wishList.totalQuantity
        self.savingsLabel.text = self.viewModel.wishList.savings
    }
}

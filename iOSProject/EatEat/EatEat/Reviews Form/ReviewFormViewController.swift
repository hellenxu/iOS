//
//  ReviewFormViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-04-10.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    var selectedRestaurantID: Int?
    @IBOutlet weak var ratingView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedRestaurantID as Any)
    }

}

//MARK: private extension
private extension ReviewFormViewController {
    @IBAction func onSaveTapped(_ sender: Any) {
        
        var item = ReviewItem()
        item.rating = Float(ratingView.rating)
        item.title = tfTitle.text
        item.name = tfName.text
        item.customerReview = tvReview.text
        item.restaurantID = selectedRestaurantID
        
        let manager = CoreDataManager()
        manager.addReview(item)
        
        dismiss(animated: true, completion: nil)
    }
}

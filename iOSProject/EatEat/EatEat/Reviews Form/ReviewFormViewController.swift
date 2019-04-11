//
//  ReviewFormViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-04-10.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    @IBOutlet weak var ratingView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //TODO
    @IBAction func onSaveTapped(_ sender: Any) {
        print(ratingView.rating)
        print(tfTitle.text as Any)
        print(tfName.text as Any)
        print(tvReview.text)
        dismiss(animated: true, completion: nil)
    }
    
}

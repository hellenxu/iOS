//
//  ReviewsViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-04-22.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedRestaurantID: Int?
    let manager = CoreDataManager()
    var data: [ReviewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
}

private extension ReviewsViewController {
    func initialize() {
        setupCollectionView()
    }

    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = flow
    }
    
    func setupDefaults() {
        checkReviews()
    }
    
    func checkReviews() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
            if data.count > 0 {data.removeAll()}
            data = manager.fetchReviews(by: id)
            if data.count > 0 {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews")
                view.set(desc: "There are currently no reviews")
                collectionView.backgroundView = view
            }
            
            collectionView.reloadData()
        }
    }
}

//MARKER: dataSource
extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let item = data[indexPath.item]
        cell.lblTitle.text = item.title
        cell.lblDate.text = item.displayDate
        cell.lblName.text = item.name
        cell.lblReview.text = item.customerReview
        if let rating = item.rating {cell.ratingView.rating = CGFloat(rating)}
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARKER: flow layout
extension ReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        if data.count == 1 {
            width = collectionView.frame.size.width - 14
        } else {
            width = collectionView.frame.size.width - 21
        }
        return CGSize(width: width, height: 200)
    }
}

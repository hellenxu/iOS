//
//  PhotosViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-04-26.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var photoCollection: UICollectionView!
    var photoReviews: [RestaurantPhotoItem] = []
    let manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showView()
    }
    
}

//MARKER: private extension
private extension PhotosViewController {
    func initialize() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        flow.minimumLineSpacing = 7
        flow.minimumInteritemSpacing = 2
        flow.scrollDirection = .horizontal
        photoCollection?.collectionViewLayout = flow
    }
    
    func showView() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
            if photoReviews.count > 0 {photoReviews.removeAll()}
            photoReviews = manager.fetchPhotos(by: id)
            if photoReviews.count > 0 {
                photoCollection.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: photoCollection.frame.width, height: photoCollection.frame.height))
                view.set(title: "Reviews")
                view.set(desc: "There are currently no photo reviews")
                photoCollection.backgroundView = view
            }
            
            photoCollection.reloadData()
        }
    }
}

//MARKER: data source
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let item = photoReviews[indexPath.item]
        if let photo = item.photo { cell.set(image: photo) }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARKER: delegate
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        if photoReviews.count == 1 {
            width = collectionView.frame.size.width - 14
        } else {
            width = collectionView.frame.size.width - 21
        }
        return CGSize(width: width, height: 200)
    }
}

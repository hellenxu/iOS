//
//  PhotoFilterViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-04-12.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoFilterViewController: UIViewController {
    var image: UIImage?
    var thumbnail: UIImage?
    let manager = FilterManager()
    var selectedRestaurantID: Int?
    var data:[FilterItem] = []
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var imgExample: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @IBAction func onPhotoTapped(_ sender: Any) {
        checkSource()
    }
}

//MARK: private extension
private extension PhotoFilterViewController {
    func initialize() {
        requestAccess()
        setupCollectionView()
        checkSource()
    }
    
    //TODO
    func requestAccess() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
            if granted {}
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 7
        
        collectionView?.collectionViewLayout = layout
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func checkSource() {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            showCameraUserInterface()
        case .restricted, .denied:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) {granted in
                if granted {
                    self.showCameraUserInterface()
                }
            }
        }
    }
    
    func showCameraUserInterface() {
        
    }
    
    func showApplyFilter() {
        manager.fetch { (items) in
            //clean up
            if data.count > 0 {data.removeAll()}
            
            data = items
            if let image = self.image {
                imgExample.image = image
                collectionView.reloadData()
            }
        }
    }
    
    func filterItem(at indexPath: IndexPath) -> FilterItem {
        return data[indexPath.item]
    }
}

//MARK: delegate and dataSource
extension PhotoFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        let item = self.data[indexPath.row]
        if let img = self.thumbnail {
            cell.set(image: img, item: item)
        }
        return cell
    }
}

//MARK: delegate flow layout
extension PhotoFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = collectionView.frame.size.height
        let screenHt = screenRect - 14
        return CGSize(width: 150, height: screenHt)
    }
}

//
//  ExploreCellCollectionViewCell.swift
//  EatEat
//
//  Created by Hellen on 2019-03-20.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var imgExplore: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCorners()
    }
}

//private extension
private extension ExploreCell {
    func roundedCorners() {
        imgExplore.layer.cornerRadius = 9
        imgExplore.layer.masksToBounds = true
    }
}

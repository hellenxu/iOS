//
//  ContactCell.swift
//  iDailyProject
//
//  Created by Hellen on 2019-05-24.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("xxl-prepare for reuse")
        contactImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contactImage.layer.cornerRadius = 15
    }
}

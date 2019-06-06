//
//  ContactCollectionViewLayout.swift
//  iDailyProject
//
//  Created by Hellen on 2019-06-04.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ContactCollectionViewLayout: UICollectionViewLayout {
    private let itemSize = CGSize(width: 100, height: 90)
    private let itemSpacing: CGFloat = 10
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        return .zero
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        let availableHeight = Int(collectionView.bounds.height + itemSpacing)
        let itemHeight = Int(itemSize.height + itemSpacing)
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let numberOfRows = availableHeight / itemHeight
        let numberOfColums = Int(ceil(CGFloat(numberOfItems) / CGFloat(numberOfRows)))
        
        layoutAttributes.removeAll()
        layoutAttributes = (0..<numberOfItems).map{index in
            let row = index % numberOfRows
            let column = index % numberOfColums
            
            var xPos = column * Int(itemSize.width + itemSpacing)
            if row % 2 == 1 {
                xPos += Int(itemSize.width / 2)
            }
            let yPos = row * Int(itemSize.height + itemSpacing)
            
            let indexPath = IndexPath(row: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: CGFloat(xPos), y: CGFloat(yPos), width: itemSize.width, height: itemSize.height)
            return attributes
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return nil
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
}

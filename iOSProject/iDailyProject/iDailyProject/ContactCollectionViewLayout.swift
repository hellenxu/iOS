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
    private var numberOfRows: Int = 0
    private var numberOfColumns: Int = 0
    
    override var collectionViewContentSize: CGSize {
        let width = CGFloat(numberOfColumns) * itemSize.width + CGFloat(numberOfColumns - 1) * itemSpacing
        let height = CGFloat(numberOfRows) * itemSize.height + CGFloat(numberOfRows - 1) * itemSpacing
        return CGSize(width: width, height: height)
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        let availableHeight = Int(collectionView.bounds.height + itemSpacing)
        let itemHeight = Int(itemSize.height + itemSpacing)
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        numberOfRows = availableHeight / itemHeight
        numberOfColumns = Int(ceil(CGFloat(numberOfItems) / CGFloat(numberOfRows)))
        
        layoutAttributes.removeAll()
        layoutAttributes = (0..<numberOfItems).map{index in
            let row = index % numberOfRows
            let column = index % numberOfColumns
            
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
    
    //could be a better way to provide attributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { attributes in
            return attributes.frame.intersects(rect)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
    }
}

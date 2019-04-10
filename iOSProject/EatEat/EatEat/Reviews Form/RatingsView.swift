//
//  RatingsView.swift
//  EatEat
//
//  Created by Hellen on 2019-04-09.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class RatingsView: UIControl {
    let imgFilledStar = #imageLiteral(resourceName: "filled-star")
    let imgHalfStar = #imageLiteral(resourceName: "half-star")
    let imgEmptyStar = #imageLiteral(resourceName: "empty-star")
    
    let shouldBecomeFirstResponder = true
    var rating: CGFloat = 0.0
    var totalStars = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        context!.fill(rect)
        
        let availWidth = rect.size.width
        let cellWidth = availWidth / CGFloat(totalStars)
        let starSide = (cellWidth <= rect.size.height) ? cellWidth : rect.size.height
        
        for index in 0...totalStars {
            let value = cellWidth * CGFloat(index) + cellWidth / 2
            let center = CGPoint(x: value + 1, y: rect.size.height / 2)
            let frame = CGRect(x: center.x - starSide / 2, y: center.y - starSide / 2, width: starSide, height: starSide)
            let highlighted = (Float(index + 1) <= ceilf(Float(self.rating)))
            
            if highlighted && (CGFloat(index + 1) > CGFloat(self.rating)) {
                drawHalfStar(with: frame)
            } else {
                drawStar(with: frame, highlighted: highlighted)
            }
        }
    }
}

private extension RatingsView {
    func drawStar(with frame: CGRect, highlighted: Bool) {
        let image = highlighted ? imgFilledStar : imgEmptyStar
        draw(with: image, and: frame)
    }
    
    func drawHalfStar(with frame: CGRect) {
        draw(with: imgHalfStar, and: frame)
    }
    
    func draw(with image: UIImage, and frame: CGRect) {
        image.draw(in: frame)
    }
}

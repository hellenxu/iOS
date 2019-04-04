//
//  NoDataView.swift
//  EatEat
//
//  Created by Hellen on 2019-04-03.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    var view: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "NoDataView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setupView(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(desc: String) {
        descLabel.text = desc
    }
}

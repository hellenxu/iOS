//
//  BitCoinReporterViewController.swift
//  Playground
//
//  Created by Hellen on 2021-07-09.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class BitCoinReporterViewController: UIViewController {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var currencyUnitLabel: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        coinManager.delegate = self
    }
}

extension BitCoinReporterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension BitCoinReporterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        print("xxl-selected: \(selectedCurrency)")
        coinManager.getCoinValue(currencyUnit: selectedCurrency)
    }
}

extension BitCoinReporterViewController: CoinValueDelegate {
    func onValueFetchFailed() {
        print("xxl-vc: failed to fetch rates")
    }
    
    func onValueFetchSucceed(model: SpecificRateUIModel) {
        
        DispatchQueue.main.async {
            self.valueLabel.text = model.rate
            self.currencyUnitLabel.text = model.currency
        }
    }
}

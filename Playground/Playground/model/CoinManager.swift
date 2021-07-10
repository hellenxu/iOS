//
//  CoinManager.swift
//  Playground
//
//  Created by Hellen on 2021-07-09.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct CoinManager{
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let baseUrl = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    
    private let apiKey = "xxx"
    private let headerKey = "X-CoinAPI-Key"
    private var selectedCurrency = ""
    
    var delegate: CoinValueDelegate?
    
    mutating func getCoinValue(currencyUnit: String) {
        selectedCurrency = currencyUnit
        let queryUrl = baseUrl + currencyUnit
        sendRequest(url: queryUrl)
    }
    
    // TODO add a network request client
    private func sendRequest(url: String) {
        if let validUrl = URL(string: url) {
            var urlRequest = URLRequest(url: validUrl)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue(apiKey, forHTTPHeaderField: headerKey)
            
            URLSession.shared.dataTask(with: urlRequest) {data,response,err in
                if err != nil {
                    return
                }
                
                if let validResult = data {
                    if let result = parseData(data: validResult) {
                        let model = SpecificRateUIModel(rate: result, currency: selectedCurrency)
                        self.delegate?.onValueFetchSucceed(model: model)
                    } else {
                        self.delegate?.onValueFetchFailed()
                    }
                }
            }.resume()
        }
    }
    
    private func parseData(data: Data) -> String?{
        let decoder = JSONDecoder()
        
        do {
            let decodedInfo = try decoder.decode(SpecificRateResponse.self, from: data)
            return String(format: "%.2f", decodedInfo.rate)
        } catch {
            print("xxl-err: \(String(describing: error))")
            return nil
        }
    }
}

protocol CoinValueDelegate {
    func onValueFetchSucceed(model: SpecificRateUIModel)
    func onValueFetchFailed()
}

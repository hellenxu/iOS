//
//  SpecificRateModel.swift
//  Playground
//
//  Created by Hellen on 2021-07-10.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct SpecificRateResponse: Decodable {
    let rate: Float
    let asset_id_base: String
    let asset_id_quote: String
}

struct SpecificRateUIModel {
    let rate: String
    let currency: String
}

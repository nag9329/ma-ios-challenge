//
//  DealSummary.swift
//  sd-ios-test
//
//  Created by Nagarjuna Ramagiri on 10/7/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import Foundation

struct DealSummary: Codable {
    var id: Int
    var title: String
    var price: String
    var extra: String
    var score: Int
    var numReplies: Int
    var image: String
    var storeName: String
    var showFlag: Bool
    var flagText: String
    var flagTextColor: String
    var flagBackgroundColor: String
}


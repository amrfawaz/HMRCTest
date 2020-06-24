//
//  Storyboard.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation

struct StoryboardName {
    static let orders = "Orders"
}

struct StoryboardIdentifire {
    // Order Storyboard
    static let orderDetailsView = "OrderDetailsViewController"
}

struct Storyboard {
    let name: String
    let identifire: String?
}

struct StoryboardMapper {
    struct Order {
        static let orderDetails = Storyboard(name: StoryboardName.orders, identifire: StoryboardIdentifire.orderDetailsView)
    }
}

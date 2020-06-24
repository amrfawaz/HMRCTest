//
//  Order.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation

class Order: Codable, Hashable {
    
    let id: String?
    let customerLoc: Location?
    let storeLoc: Location?
    var path: [Order]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }


}


struct Location: Codable {
    let lat: Double?
    let lon: Double?
}


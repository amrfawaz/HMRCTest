//
//  OrdersViewModel.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import CoreLocation
class OrdersViewModel {
    
    var orders = [[Order]]()
  
    func getOrders(complition: @escaping(_ error: CustomError?) -> Void) {
        let ordersApi = OrdersApi()
        ordersApi.getOrders().get { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.orders = strongSelf.groupOrders(orders: strongSelf.getLessOrdersDistance(orders: response))
            complition(nil)
        }.catch { error in
            complition(error as? CustomError)
        }
    }
}


extension OrdersViewModel {
    
    // Filter orders that their sources is within 1 KM radius AND their destinations is within 1 KM radius
    func getLessOrdersDistance(orders: [Order]) -> [[Order]] {
        return orders.sorted { (order1, order2) -> Bool in
            let locationR1 = CLLocation(latitude: order1.storeLoc?.lat ?? 0, longitude: order1.storeLoc?.lon ?? 0)
            let locationR2 = CLLocation(latitude: order2.storeLoc?.lat ?? 0, longitude: order2.storeLoc?.lon ?? 0)
            
            let locationD1 = CLLocation(latitude: order1.customerLoc?.lat ?? 0, longitude: order1.customerLoc?.lon ?? 0)
            let locationD2 = CLLocation(latitude: order2.customerLoc?.lat ?? 0, longitude: order2.customerLoc?.lon ?? 0)
            
            let distance = (getDistance(location1: locationR1, location2: locationR2) + getDistance(location1: locationD1, location2: locationD2))
            if distance <= 1 {
                order1.path = [Order]()
                order1.path?.append(contentsOf: [order1, order2])
            }
            return distance <= 1
            }.compactMap { $0.path }
    }


    // Group orders in common together
    func groupOrders(orders: [[Order]]) -> [[Order]] {
        var result = [[Order]]()

        orders.forEach { item in
            var itemAdded = false
            result.forEach { oldItem in
                if !oldItem.filter(item.contains).isEmpty {
                    let newItem: [Order] = Array(Set(oldItem + item))
                    result.remove(at: result.firstIndex(of: oldItem)!)
                    if !itemAdded {
                        result.append(newItem)
                    }
                    itemAdded = true
                }
            }
            if !itemAdded {
                result.append(item)
            }
        }
        return result
    }

    // get distance between two points in KM
    func getDistance(location1: CLLocation, location2: CLLocation) -> Float {
        return (Float(location1.distance(from: location2) / 1000))
    }
}

//
//  OrdersApi.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation


import Alamofire
import PromiseKit

class OrdersApi: Api {
    enum APIRouter: Requestable {
        case getOrders(OrdersApi)
        
        var path: String {
            switch self {
            case .getOrders:
                return "/driver/test"
            }
        }
        
        var baseUrl: URL {
            return Configurations.rootUrl
        }

        var method: HTTPMethod {
            switch self {
            case .getOrders:
                return .get
            }
        }
        
    }
}

extension OrdersApi {
    func getOrders() -> Promise<[Order]> {
        return fireRequestWithMultiResponse(requestable: APIRouter.getOrders(self))
    }
}

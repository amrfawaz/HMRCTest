//
//  Router.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

enum PresentationType {
    case push
    case modal
}

struct Router {
    static func navigate(destination: Storyboard, presentationType: PresentationType) {
        let currentViewController = getCurrentViewController()
        let destinationViewController = getDestinationViewController(storyboard: destination)

        switch presentationType {
        case .push:
            destinationViewController.hidesBottomBarWhenPushed = true
            currentViewController?.show(destinationViewController, sender: nil)

        case .modal:
            destinationViewController.modalPresentationStyle = .fullScreen
            currentViewController?.present(destinationViewController, animated: true, completion: nil)
        }
    }

    static func navigate(destination: UIViewController, presentationType: PresentationType) {
        let currentViewController = getCurrentViewController()
        let destinationViewController = destination

        switch presentationType {
        case .push:
            destinationViewController.hidesBottomBarWhenPushed = true
            currentViewController?.show(destinationViewController, sender: nil)

        case .modal:
            destinationViewController.modalPresentationStyle = .fullScreen
            currentViewController?.present(destinationViewController, animated: true, completion: nil)
        }
    }

    static func getCurrentViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
    }

    static func getDestinationViewController(storyboard: Storyboard) -> UIViewController {
        let st = UIStoryboard(name: storyboard.name, bundle: nil)

        if let identifire = storyboard.identifire {
            return st.instantiateViewController(withIdentifier: identifire)
        } else {
            return st.instantiateInitialViewController()!
        }
    }

    static func getNavigationController(root: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: root)
        return navigationController
    }
}

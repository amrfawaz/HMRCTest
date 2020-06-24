//
//  BaseViewController.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import UIKit
import Lottie

typealias CustomAlertClosure = ((UIAlertAction) -> Void)

class BaseViewController: UIViewController {
    var loadAnimationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showErrorAnimation() {
        showLottieAnimation(fileName: "error")
    }

    func showLoadingAnimation() {
        showLottieAnimation(fileName: "loading")
    }

    func showEmptyAnimation() {
        showLottieAnimation(fileName: "empty")
    }

    private func showLottieAnimation(fileName: String) {
        loadAnimationView = AnimationView(name: fileName)
        loadAnimationView?.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        loadAnimationView?.center = view.center
        loadAnimationView?.contentMode = .scaleAspectFill
        view.addSubview(loadAnimationView!)
        loadAnimationView?.play(completion: { _ in
        })
    }

    func hideLottieAnimation() {
        loadAnimationView?.stop()
        loadAnimationView?.removeFromSuperview()
    }

    func showCustomAlert(title: String, message: String, doneButtonTitle: String, doneAction: (CustomAlertClosure)? = nil, cancelButtonTitle: String = "", cancelActin: (CustomAlertClosure)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: doneButtonTitle, style: .default, handler: doneAction))
        if !cancelButtonTitle.isEmpty {
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .default, handler: cancelActin))
        }
        present(alert, animated: true, completion: nil)
    }
}

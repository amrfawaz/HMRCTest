//
//  OrdersViewController.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/22/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import UIKit

class OrdersViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModels = OrdersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        registerCells()
        getOrders()
        
    }
    
    
    func getOrders() {
        viewModels.getOrders { [weak self] error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.showCustomAlert(title: error.title ?? "", message: error.message ?? "", doneButtonTitle: "Ok")
            } else {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: String(describing: OrderCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OrderCell.self))
    }
}


extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderCell.self)) as? OrderCell
        
        orderCell?.labelTitle.text = "\(viewModels.orders[indexPath.row].count) Orders"
        orderCell?.accessoryType = .disclosureIndicator
        return orderCell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orders = viewModels.orders[indexPath.row]
        
        let orderDetailsViewController = Router.getDestinationViewController(storyboard: StoryboardMapper.Order.orderDetails) as? OrderDetailsViewController
        orderDetailsViewController?.orders = orders
        Router.navigate(destination: orderDetailsViewController!, presentationType: .push)
    }
}

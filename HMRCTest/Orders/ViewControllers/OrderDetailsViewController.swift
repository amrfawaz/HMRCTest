//
//  OrderDetailsViewController.swift
//  HMRCTest
//
//  Created by AmrFawaz on 6/24/20.
//  Copyright © 2020 AmrFawaz. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order Details"
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: String(describing: OrderCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OrderCell.self))
    }

}


extension OrderDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderCell.self)) as? OrderCell
        
        orderCell?.labelTitle.text = "ID: \(orders?[indexPath.row].id ?? "N/A")"
        orderCell?.accessoryType = .disclosureIndicator
        return orderCell!
    }
}

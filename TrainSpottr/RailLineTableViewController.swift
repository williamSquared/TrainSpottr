//
//  RailLineTableViewController.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailLineTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        tableView.backgroundColor = UIColor.blueColor()
    }
}

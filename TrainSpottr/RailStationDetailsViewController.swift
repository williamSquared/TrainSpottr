//
//  RailStationDetailsViewController.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/30/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailStationDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Class Variables
    private let cellId = "cell"
    private var trains = [Train]()
    private var refreshControl: UIRefreshControl!
    internal var stationName: String?
    internal var stationCode: String?
    
    // MARK: Outlet Connections
    @IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var railArrivalTableView: UITableView!
    @IBOutlet var stationImage: UIImageView!
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(applicationWillEnterForeground),
            name: UIApplicationWillEnterForegroundNotification,
            object: nil
        )
        
        navigationItem.title = "Station Details"
        railArrivalTableView.dataSource = self
        
        addRefreshControl()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
        getRailStationDetails(stationCode: stationCode!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        imageViewHeightConstraint.constant = CGFloat(239)
    }
    
    // MARK: View Methods
    func configureView() {
        stationImage.image = UIImage(named: stationName!)
        if stationImage.image == nil {
            imageViewHeightConstraint.constant = CGFloat(0)
        }
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(RailStationDetailsViewController.refresh), forControlEvents: .ValueChanged)
        railArrivalTableView.addSubview(refreshControl)
    }
    
    func applicationWillEnterForeground() {
        getRailStationDetails(stationCode: stationCode!)
    }
    
    // MARK: Network Call
    private func getRailStationDetails(stationCode stationCode: String){
        WMATAService.getRailStationDetails(stationCode: stationCode) { (result) -> Void in
            if result != nil {
                self.trains = result as! [Train]
                dispatch_async(dispatch_get_main_queue()) {
                    self.railArrivalTableView.reloadData()
                }
            }
        }
    }

    // MARK: TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trains.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        let train = self.trains[indexPath.row]
        cell.textLabel?.text = train.destination
        cell.detailTextLabel!.text = handleMinutes(eta: train.etaInMinutes)
        
        return cell
    }
    
    func refresh() {
        getRailStationDetails(stationCode: stationCode!)
        refreshControl.endRefreshing()
    }
    
    private func handleMinutes(eta eta: String) -> String {
        
        switch eta {
        case "BRD":
            return "Boarding NOW"
        case "ARR":
            return "Arriving Soon"
        case "---":
            return ""
        default:
            return "\(eta) minutes"
        }
    }
}
    
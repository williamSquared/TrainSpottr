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
    internal var stationName: String?
    internal var stationCode: String?
    
    // MARK: Outlet Connections
    @IBOutlet var railArrivalTableView: UITableView!
    @IBOutlet var stationImage: UIImageView!
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        navigationItem.title = "Station Details"
        railArrivalTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
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
    
    // MARK: View Methods
    func configureView() {
        stationImage.image = UIImage(named: stationName!)
        stationImage.contentMode = .ScaleAspectFill
    }

    // MARK: TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trains.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        let train = self.trains[indexPath.row]
        cell.textLabel?.text = train.destination
        cell.detailTextLabel!.text = "\(train.etaInMinutes) minutes"
        
        return cell
    }
}
    
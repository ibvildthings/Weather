//
//  DayHourlyTableViewController.swift
//  Weather
//
//  Created by Pritesh Desai on 5/25/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit
import MapKit

class DayHourlyTableViewController: UITableViewController {

    // MARK: Properties
    var location = CLLocationCoordinate2D()
    var day: String?
    var hours: [forecastHourly]?
    
    // a closure to filter out all but only those forecasts for the given day
    var hoursForDay: [forecastHourly]? {
        return hours?.filter{ $0.weekday == self.day }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let day = day {
            print("Selected Day" + day)
            self.title = day
        }
        
        // create an object to download weather details for the next 10 days
        let dayHourlyForecastDetails = DayHourly()
        
        dayHourlyForecastDetails.downloadData(location: location) { (data: containerHourly) in
            //update the UI on the main queue
            DispatchQueue.main.async {
                self.updateTable(with: data.hours)
            }
        }
        
    }
    
    func updateTable(with hours: [forecastHourly]) {
        self.hours = hours
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hoursForDay?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        // Configure the cell...
        let details = hoursForDay![indexPath.row]
        
        cell.textLabel?.text = "\(details.civil!) - \(details.temperature!) F"
        cell.detailTextLabel?.text = details.condition!
        
        // set a placeholder image until the image loads
        cell.imageView?.image = UIImage(named: "loading.png")
        cell.imageView?.setCustomImage(getIconURL(for: details.icon))
        
        return cell
    }
    


}

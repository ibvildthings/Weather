//
//  TenDayForecastTableViewController.swift
//  Weather
//
//  Created by Pritesh Desai on 5/25/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit
import MapKit

class TenDayForecastTableViewController: UITableViewController {

    // MARK: Properties
    var location = CLLocationCoordinate2D()
    var days: [forecastDay]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create an object to download weather details for the next 10 days
        let tenDayForecastDetails = TenDays()
        
        tenDayForecastDetails.downloadData(location: location) { (data: container) in
            //update the UI on the main queue
            DispatchQueue.main.async {
                
                self.updateTable(with: data.days)
            }
        }
        
        
    }
    
    //update table with the downloaded data
    func updateTable(with days: [forecastDay]) {
        self.days = days
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
        return days?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let day = days![indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = day.fcttext
        cell.detailTextLabel?.text = day.title
        
        // place holder image before the icon loads
        cell.imageView?.image = UIImage(named: "loading.png")
        cell.imageView?.setCustomImage(getIconURL(for: day.icon))

        return cell
    }
    
    
    
    // MARK: Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DayHourly", sender: indexPath);
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass location if the segue is to the 10 Day Forecast screen
        if segue.identifier == "DayHourly" {
            if let vc = segue.destination as? DayHourlyTableViewController {
                vc.location = self.location
                if let indexPath = sender as? IndexPath {
                    let row = indexPath.row
                    
                    // find the day which the user has selected
                    var whichDay = self.days![row].title
                    
                    // remove subsctring " Night" from the string
                    whichDay = whichDay?.replacingOccurrences(of: " Night", with: "")
                    vc.day = whichDay
                }
            }
        }
        

    }
    
    

}

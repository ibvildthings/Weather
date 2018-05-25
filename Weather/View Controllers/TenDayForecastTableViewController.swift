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
        cell.imageView?.setCustomImage(getURL(for: day.icon))

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

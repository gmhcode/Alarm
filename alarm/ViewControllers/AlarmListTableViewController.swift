//
//  AlarmListTableViewController.swift
//  alarm
//
//  Created by Greg Hughes on 12/3/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else {fatalError()}

        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell.delegate = self
        
        cell.alarmCellView = alarm
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let deleteLocation = AlarmController.shared.alarms[indexPath.row]
            
            AlarmController.shared.delete(alarm: deleteLocation)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        i
        if segue.identifier == "editAlarm"{
            guard let indexPath = tableView.indexPathForSelectedRow  else {return}
            
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            
            let alarmTakeOff = AlarmController.shared.alarms[indexPath.row]
            
            destinationVC?.alarmLandingPad = alarmTakeOff
            
        }
        //        i
        //        d
        
        //        o
        //        o

    }
 
    
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        let alarmToggle = AlarmController.shared.alarms[indexPath.row]
        
        alarmToggle.enabled.toggle()
        
        cell.alarmCellView = alarmToggle
    }
    
}

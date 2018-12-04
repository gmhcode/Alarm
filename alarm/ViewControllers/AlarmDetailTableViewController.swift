//
//  AlarmDetailTableViewController.swift
//  alarm
//
//  Created by Greg Hughes on 12/3/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    var alarmLandingPad : Alarm?{
        didSet {
           alarmIsOn = alarmLandingPad?.enabled ?? true
           loadViewIfNeeded()
           updateView()
        }
    }
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameLabel: UITextField!
    
    @IBOutlet weak var alarmButton: UIButton!
    
    var alarmIsOn : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        updateButton()
        
    }
    

    // MARK: - Table view data source

    
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        
        if let enableAlarm = alarmLandingPad {
            
        AlarmController.shared.toggleEnabled(for: enableAlarm)
        updateButton()
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard datePicker.calendar != nil,
            alarmNameLabel.text != nil,
            let alarmName = alarmNameLabel.text else {return}
        
        if let existingAlarm = alarmLandingPad{
            
            AlarmController.shared.update(alarm: existingAlarm, firedate: datePicker.date, name: alarmName, enabled: existingAlarm.enabled )
        } else {
            AlarmController.shared.addAlarm(fireDate: datePicker.date, name: alarmName, enabled: alarmIsOn)
        }
        updateView()
        updateButton()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func updateView(){
        
        guard let alarmDate = alarmLandingPad?.fireDate else {return}
        datePicker.date = alarmDate
        
        alarmNameLabel.text = alarmLandingPad?.name
        
    }
    
    
    
    private func updateButton(){
        
        if alarmLandingPad?.enabled == false {
          alarmButton.setTitle("Turn on", for: .normal)
        }
        else if alarmLandingPad?.enabled == true {
            alarmButton.setTitle("turn off", for: .normal)

        }

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

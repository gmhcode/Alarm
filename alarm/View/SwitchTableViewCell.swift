//
//  SwitchTableViewCell.swift
//  alarm
//
//  Created by Greg Hughes on 12/3/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit


protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}


class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarmCellView : Alarm?{
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews(){
        if let updateAlarm = alarmCellView {
            timeLabel.text = updateAlarm.fireTimeAsString
            nameLabel.text = updateAlarm.name
            alarmSwitch.isOn = updateAlarm.enabled
        }
    }
    
    
    
    @IBAction func switchValueChanged(_ sender: Any) {
        
        delegate?.switchCellSwitchValueChanged(cell: self)
        
        
        
    }
    

}

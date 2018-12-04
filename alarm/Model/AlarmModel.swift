//
//  AlarmModel.swift
//  alarm
//
//  Created by Greg Hughes on 12/3/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class Alarm: Equatable, Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    
    var fireTimeAsString : String {
       return DateFormatter.localizedString(from: fireDate, dateStyle: .short, timeStyle: .short)
    }
    
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.fireDate == rhs.fireDate &&
        lhs.name == rhs.name &&
        lhs.enabled == rhs.enabled 
            
        
    
    }
    

}

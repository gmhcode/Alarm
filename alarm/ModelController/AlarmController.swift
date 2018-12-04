//
//  AlarmController.swift
//  alarm
//
//  Created by Greg Hughes on 12/3/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmController{
    
    
    static let shared = AlarmController()
    var alarms : [Alarm] = []
    
    init(){
        self.alarms = mockAlarms
    }
    
    var mockAlarms: [Alarm]{
        let alarm1 = Alarm(fireDate: Date(timeIntervalSinceNow: 1200), name: "Wake up", enabled: true)
        let alarm2 = Alarm(fireDate: Date(timeIntervalSinceNow: 1600), name: "Go to sleep", enabled: true)
        let alarm3 = Alarm(fireDate: Date(timeIntervalSinceNow: 2100), name: "Eat", enabled: true)
        return [alarm1, alarm2, alarm3]
    }
    
    //TURNARY
    func toggleEnabled(for alarm: Alarm){
        
        alarm.enabled.toggle()
        alarm.enabled ? cancelUserNotifications(for: alarm) : scheduleUserNotifications(for: alarm)
        
    }
    
    //crud
    @discardableResult
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) -> Alarm{
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        saveToPersistentStorage()
        return newAlarm
    }
    
    func update(alarm: Alarm, firedate: Date, name: String, enabled: Bool){
        alarm.fireDate = firedate
        alarm.name = name
        alarm.enabled = enabled
        saveToPersistentStorage()
    }
    
    
    func delete(alarm: Alarm) {
        
        guard let alarmLocation = alarms.index(of:alarm) else {return}
        alarms.remove(at: alarmLocation)
        saveToPersistentStorage()
    }
    
    
    
    
    
    func fileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "entries.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        // this adds a word to the file URL
        print(fullURL)
        
        return fullURL
        
    }
    
    
    
    func saveToPersistentStorage(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(self.alarms)
            try data.write(to: fileURL())
        } catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
    }
    
    
    
    func loadFromPersistentStorage() -> [Alarm] {
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            let entries = try decoder.decode([Alarm].self, from: data)
            return entries
        }catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
        return []
    }
    
}



protocol AlarmScheduler: class {
    
//    func scheduleUserNotificatications(for alarm: Alarm)
//    func cancelUserNotifications(for alarm: Alarm)
    
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm){
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm Complete"
        content.body = "now what?"
        content.sound = UNNotificationSound.default
        
        let fireDate = alarm.fireDate
        
        let dateMatching = Calendar.current.dateComponents([.day, .hour, .minute], from: fireDate)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: true)
        
        let identifier = alarm.uuid
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
            }
        }
        
    }
    func cancelUserNotifications(for alarm: Alarm){
        
       
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        
        
    }
}

//AlarmController AlarmScheduler Extention

extension AlarmController: AlarmScheduler{
    
}



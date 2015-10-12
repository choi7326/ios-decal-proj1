//
//  ToDoItem.swift
//  ToDoList
//
//  Created by John W Choi on 9/30/15.
//  Copyright © 2015 <SELF>. All rights reserved.
//

import UIKit

class ToDoItem: NSObject, NSCoding {
    
    var itemName: NSString = ""
    var completed: Bool = false
    var creationDate: NSDate = NSDate()
    var completionDate: NSDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 3, toDate: NSDate(), options: [])!
    init(name:String) {
        self.itemName = name
    }
    
    init(name:String, completed:Bool, creationDate: NSDate, completionDate: NSDate) {
        self.itemName = name
        self.completed = completed
        self.creationDate = creationDate
        self.completionDate = completionDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.itemName, forKey: "itemName")
        aCoder.encodeObject(self.completed, forKey: "completed")
        aCoder.encodeObject(self.creationDate, forKey: "creationDate")
        aCoder.encodeObject(self.completionDate, forKey: "completionDate")
    }
    
    required convenience init(coder decoder: NSCoder) {
        let name =  decoder.decodeObjectForKey("itemName") as! String
        let isCompleted = decoder.decodeObjectForKey("completed") as! Bool
        let dateCreated = decoder.decodeObjectForKey("creationDate") as! NSDate
        let dateCompleted = decoder.decodeObjectForKey("completionDate")
        self.init(name:name, completed: isCompleted, creationDate: dateCreated, completionDate: dateCompleted as! NSDate)
    }
}

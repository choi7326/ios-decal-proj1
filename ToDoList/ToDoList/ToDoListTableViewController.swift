//
//  TableViewController.swift
//  ToDoList
//
//  Created by John W Choi on 9/30/15.
//  Copyright © 2015 <SELF>. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var toDoItems: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if toDoItems.count == 0 {
            loadInitialData()
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        //recognizer.direction = .Right
        //self.view .addGestureRecognizer(recognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        for (var row = 0; row < tableView.numberOfRowsInSection(0); row++) {
            var indexPath = NSIndexPath(forRow: row, inSection: 0)
            //following line of code is for invisible cells
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
            //get cell for current row
            // var cell = tableView.cellForRowAtIndexPath(indexPath)
            var todoitem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
            let elapsedTime = Int(NSDate().timeIntervalSinceDate(todoitem.completionDate))
            if elapsedTime >= 86400 {
                print("task is removed")
                self.toDoItems.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        saveData();
    }
    
    func saveData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(self.toDoItems), forKey: "Tasks")
        defaults.synchronize()
    }
    
    func loadInitialData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tasks = defaults.objectForKey("Tasks")
        {
            let tasksUnwrapped = NSKeyedUnarchiver.unarchiveObjectWithData(tasks as! NSData) as! NSMutableArray
            for item in tasksUnwrapped {
                self.toDoItems.addObject(item as! ToDoItem)
            }
        }
        
    }
    
    func sendNumberOfTasksCompleted() -> Int {
        return toDoItems.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.toDoItems.count
        
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            var todoitem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
            cell.textLabel!.text = todoitem.itemName as String
            
            if todoitem.completed {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:
        NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            var tappedItem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
            tappedItem.completed = !tappedItem.completed
            if tappedItem.completed {
                tappedItem.completionDate = NSDate()
            } else {
                tappedItem.completionDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 3, toDate: NSDate(), options: [])!
            }
            tableView.reloadData()
    }
    
    
    @IBAction func unwindToList(segue:UIStoryboardSegue){
        var source: AddToDoItemViewController = segue.sourceViewController as! AddToDoItemViewController
        
        if let item: ToDoItem = source.toDoItem {
            self.toDoItems.addObject(item)
            self.tableView.reloadData()
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.toDoItems.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }
    
//    func swipeRight(recognizer : UISwipeGestureRecognizer) {
//        self.performSegueWithIdentifier("ShowDailyStats", sender: self)
//    }
//    
    
    //override func tableView(tableView: UITableView,
    //    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        var cell =
    //        tableView.dequeueReusableCellWithIdentifier("") as! UITableViewCell
            
    //        cell.textLabel?.tex = self.items[indexPath.row]
    //        return cell
    //}

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

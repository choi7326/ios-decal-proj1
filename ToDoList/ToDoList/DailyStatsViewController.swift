//
//  DailyStatsViewController.swift
//  ToDoList
//
//  Created by John W Choi on 10/1/15.
//  Copyright © 2015 <SELF>. All rights reserved.
//

import UIKit

class DailyStatsViewController: UIViewController {
    
    @IBOutlet weak var tasksCompletedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tasks = defaults.objectForKey("Tasks")
        {
            let tasksUnwrapped = NSKeyedUnarchiver.unarchiveObjectWithData(tasks as! NSData) as! NSMutableArray
            var count = 0
            for item in tasksUnwrapped {
                if (item as! ToDoItem).completed {
                    count++
                }
            }
            self.tasksCompletedLabel.text = String(format: "%d", count)
        }
        
        //let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        //recognizer.direction = .Left
        //self.view .addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }
    
    @IBAction func unwindToStatsFromList(segue:UIStoryboardSegue){
    }
//    
//    func swipeRight(recognizer : UISwipeGestureRecognizer) {
//        self.performSegueWithIdentifier("ShowToDoList", sender: self)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by John W Choi on 10/1/15.
//  Copyright © 2015 <SELF>. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {
    
    var toDoItem: ToDoItem?
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender as? NSObject != self.doneButton{
            return
        }
        if self.textField.text!.utf16.count > 0{
            self.toDoItem = ToDoItem(name: self.textField.text!)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AddTaskViewController.swift
//  Practice Plan
//
//  Created by Rutvik Patel on 2019-05-15.
//  Copyright © 2019 Rutvik Patel. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        
        // Getting input from user
        task.name = textField.text!
        task.isImportant = isImp.isOn
        
        // Saving data to coredata...
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
        
    }
    
}

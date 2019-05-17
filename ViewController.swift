//
//  ViewController.swift
//  Practice Plan
//
//  Created by Rutvik Patel on 2019-05-15.
//  Copyright © 2019 Rutvik Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    // initializing empty tasks array
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To-Do List";  // setting title
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get data from coredata
        fetchData()
        
        // reload table view
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        if task.isImportant {
            // updating the cell name
            cell.textLabel?.text = "⭐️ \(task.name!)"
        } else {
            // updating the cell name
            cell.textLabel?.text = "      \(task.name!)"
        }
        
        return cell
    }
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            // update the tasks array
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch {
            // error message
            print("Fetch failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // swipe to delete functionality
        if editingStyle == .delete {
            // get the task to delete
            let task = tasks[indexPath.row]
            // delete task
            context.delete(task)
            // save context
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                // update the tasks array
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch {
                // error message
                print("Fetch failed")
            }
        }
        // reload screen to show changes
        tableView.reloadData()
    }
    

}


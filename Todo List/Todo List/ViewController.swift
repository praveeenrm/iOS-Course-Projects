//
//  ViewController.swift
//  Todo List
//
//  Created by PRAVEEN on 31/08/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var todos : [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get the data from Core data
        getData()
        
        // Reload Table View
        tableView.reloadData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let todo = Todo(context: ctx)
        
        todo.title = textField.text!
        
        // Save the data to Core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        getData()
        
        // Reload Table View
        tableView.reloadData()
        
        textField.text = ""
        
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    // Cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.numberOfLines = 0
        
        let todo = todos[indexPath.row]
        
        if todo.title! == "" {
            cell.textLabel?.text = "<Empty>"
        } else {
            cell.textLabel?.text = todo.title!
        }
        
        
        return cell
    }
    
    // Delete Cell / Todo
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            //            let todo = todos[indexPath.row]
            
            ctx.delete(todos.remove(at: indexPath.row))
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                todos = try ctx.fetch(Todo.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        
    }
    
    // Cell tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        print(todos[indexPath.row].title!)
        
    }
    
    func getData() {
        
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            todos = try ctx.fetch(Todo.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        
    }
    
}









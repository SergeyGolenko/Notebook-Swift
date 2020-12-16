//
//  ViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var firstVC : NoteTableViewController?
    var newTask = Entries()
    
    
    
    
    @IBOutlet weak var newTimeForNotebook: UIDatePicker!
    @IBOutlet weak var newTextForNotebook: UITextView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newTextForNotebook.text = ""
            }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        newTask.text = newTextForNotebook.text
        newTask.date = newTimeForNotebook.date
        firstVC?.entriesArray.append(newTask)
        firstVC?.tableView.reloadData()
        
    }


}


//
//  ViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    var entry : Entries?
    
    
    
    @IBAction func trashButton(_ sender: UIBarButtonItem) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(entry!)
                try? context.save()
            }
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var newTimeForNotebook: UIDatePicker!
    @IBOutlet weak var newTextForNotebook: UITextView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if entry == nil {
            newTextForNotebook.text = ""
        } else {
            //Fill in info about existing entry
            if let dateToBeShown = entry?.date{
                newTimeForNotebook.date = dateToBeShown
            }
            newTextForNotebook.text = entry?.text
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //Make an entry
        
        if entry == nil {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let newTask = Entries(context: context)
                newTask.text = newTextForNotebook.text
                newTask.date = newTimeForNotebook.date
            }
            
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

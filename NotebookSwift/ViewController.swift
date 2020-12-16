//
//  ViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var entry : Entries?
    
    
    
    @IBAction func dateChanched(_ sender: UIDatePicker) {
        entry?.date = newTimeForNotebook.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        
    }
    
    
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
    @IBOutlet weak var constraintText: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        if entry == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                entry = Entries(context: context)
                entry?.date = newTimeForNotebook.date
                entry?.text = "Today was..."
                newTextForNotebook.becomeFirstResponder()
            }
        }
        newTextForNotebook.text = entry?.text
        if let dateToBeShown = entry?.date{
            newTimeForNotebook.date = dateToBeShown
        }
        newTextForNotebook.delegate = self
    }
    
    
    @objc func keyboardWillShow(notification:NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            constraintText.constant = keyboardHeight
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    
    
}

extension ViewController: UITextViewDelegate{
    
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = newTextForNotebook.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    
}

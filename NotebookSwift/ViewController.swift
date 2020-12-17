//
//  ViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit

class ViewController: UIViewController {
    // cюда будут передаваться данные с ячейки(если в ней содержаться данные)
    var entry : Entries?
    // переменная для доступа к NSManagedObjectContext
    let contextDelegate = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @IBAction func dateChanched(_ sender: UIDatePicker) {
        entry?.date = newTimeForNotebook.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    // удаление данных
    @IBAction func trashButton(_ sender: UIBarButtonItem) {
        if entry != nil {
            if let context = contextDelegate {
                context.delete(entry!)
                try? context.save()
            }
        }
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Outlets
    @IBOutlet weak var newTimeForNotebook: UIDatePicker!
    @IBOutlet weak var newTextForNotebook: UITextView!
    @IBOutlet weak var constraintText: NSLayoutConstraint!
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //cоздаю наблюдателя для изминения размера textView, когда появляется клавиатура
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //выполнить эти действия если в entry отсутствует значение
        if entry == nil {
            if let context = contextDelegate {
                entry = Entries(context: context)
                entry?.date = newTimeForNotebook.date
                entry?.text = "Today was..."
                newTextForNotebook.becomeFirstResponder()
            }
        }
        //Если в переменной entry есть данные, то нужно выполнить следующий код
        newTextForNotebook.text = entry?.text
        if let dateToBeShown = entry?.date{
            newTimeForNotebook.date = dateToBeShown
        }
        
        //подписываюсь на delegate, что бы отработал метод textViewDidChange
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

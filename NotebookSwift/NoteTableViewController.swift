//
//  NoteTableViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {
    
    // массив содержащий объекты типа Entries
    var entriesArray : [Entries] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Эта функция срабатывает при каждом появлении этого контроллера
    override func viewWillAppear(_ animated: Bool) {
        
        // при каждом появлении этого экрана, мы вытаскиваем из CoreData наши данные и присваиваем их entriesArray и перезагружаем таблицу
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let request : NSFetchRequest<Entries> = Entries.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            if let entriesFromCoreData =  try? context.fetch(request) {
                entriesArray = entriesFromCoreData
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // кастомную ячейку нужно привести к ее типу
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as? CustomCellTableViewCell
        let item = entriesArray[indexPath.row]
        cell?.myTextLabel.text = item.text
        cell?.mounthDate.text = item.month()
        cell?.numberDate.text = item.day()
        return cell!
    }
    
    // здесть через segue получаю доступ к другому контроллеру и передаю один выбранный объект Entries который был выбрал в методе didSelect и сохранен sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? ViewController{
            if let entryToBeSent = sender as? Entries {
                secondVC.entry = entryToBeSent
            }
        }
    }
    
    
    //здесь при нажатии на ячейку захватываю один объект Entries и передаю его через performSegue в sender
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entriesArray[indexPath.row]
         performSegue(withIdentifier:"111", sender: entry)
    }

}

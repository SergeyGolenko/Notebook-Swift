//
//  NoteTableViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    var entriesArray : [Entries] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Эта функция срабатывает при каждом появлении этого контроллера
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            if let entriesFromCoreData =  try? context.fetch(Entries.fetchRequest()) as? [Entries] {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as? CustomCellTableViewCell
        let item = entriesArray[indexPath.row]
        cell?.myTextLabel.text = item.text
        cell?.mounthDate.text = item.month()
        cell?.numberDate.text = item.day()
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? ViewController{
            if let entryToBeSent = sender as? Entries {
                secondVC.entry = entryToBeSent
            }
        }
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entriesArray[indexPath.row]
         performSegue(withIdentifier:"111", sender: entry)
    }

}

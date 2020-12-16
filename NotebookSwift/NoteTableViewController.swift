//
//  NoteTableViewController.swift
//  NotebookSwift
//
//  Created by Сергей Голенко on 15.12.2020.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    var entriesArray = [Entries]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = UITableViewCell()
        let item = entriesArray[indexPath.row].text
        cell.textLabel?.text = item
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? ViewController{
            secondVC.firstVC = self
        }
    }

}

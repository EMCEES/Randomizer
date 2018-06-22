//
//  RandomizeControllerTableViewController.swift
//  Randomizer
//
//  Created by CELLFiY on 6/22/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit
import CoreData

class RandomizeControllerTableViewController: UITableViewController {
    
    @IBAction func randomize(_ sender: Any) {
    }
    
    @IBAction func addPerson(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    let fetchRequestController: NSFetchedResultsController<People> = {
        let internalFetchRequest: NSFetchRequest<People> = Entry.fetchRequest()
        
        internalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: internalFetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        guard let persons = fetchRequestController.fetchedObjects else { return UITableViewCell() }
        let people = persons[indexPath.row]
        cell.textLabel?.text = people.name
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let person = fetchRequestController.fetchedObjects?[indexPath.row] {
                
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        
    }
}

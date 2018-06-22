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
    
    
    //FRC
    let fetchRequestController: NSFetchedResultsController<People> = {
        let internalFetchRequest: NSFetchRequest<People> = People.fetchRequest()
        
        internalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: internalFetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    //Actions
    @IBAction func randomize(_ sender: Any) {
    }
    
    var person: String = ""
    
    @IBAction func addPerson(_ sender: Any) {
        
        addPersonAlert()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequestController.delegate = self
        
        do {
            try fetchRequestController.performFetch()
        } catch let error {
            print("Error fetching: \(error) \(error.localizedDescription)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Alert Controller
    
    func addPersonAlert() {
        let addNameAlert = UIAlertController(title: "Add", message: "Enter the name of a person.", preferredStyle: .alert)
        addNameAlert.addTextField { (nameText) in
            nameText.placeholder = "Enter name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            addNameAlert.addTextField(configurationHandler: { (textfield) in
                textfield.placeholder = "Enter name"
            })
            print("User cancelled")
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (add) in
            guard let person = addNameAlert.textFields?[0].text else { return }
            PeopleController.shared.create(person: person)
        }
        
        addNameAlert.addAction(cancelAction)
        addNameAlert.addAction(addAction)
        
        self.present(addNameAlert, animated: true, completion: nil)
    }
    


    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return (fetchRequestController.fetchedObjects?.count)! / 2
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (fetchRequestController.fetchedObjects?.count)!
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
                PeopleController.shared.delete(person: person)
            }
        }
    }
}

extension RandomizeControllerTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
}

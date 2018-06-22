//
//  PeopleController.swift
//  Randomizer
//
//  Created by CELLFiY on 6/22/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit
import CoreData

class PeopleController {
    
    static let shared = PeopleController()

    func create(person: String) {
        People(name: person)
        save()
    }
    
    func save() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("Dohhh.... there was an error saving \(error) \(error.localizedDescription).")
        }
    }
    
    func delete(entry: People) {
        CoreDataStack.context.delete(entry)
        save()
    }
    
}

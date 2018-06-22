//
//  People.swift
//  Randomizer
//
//  Created by CELLFiY on 6/22/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import Foundation
import CoreData

convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
    self.init(context: context)
    self.name = name
}

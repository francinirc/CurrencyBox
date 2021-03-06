//
//  ManagedConversion.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 28/07/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation
import CoreData

class ManagedConversion: NSManagedObject {
    
    convenience init() {
        let classStringName = String(describing: ManagedConversion.self)
        let entityDescription = NSEntityDescription.entity(forEntityName: classStringName, in: CoreDataManager.sharedManager().getContext())
        
        self.init(entity: entityDescription!, insertInto: CoreDataManager.sharedManager().getContext())
    }
    
}

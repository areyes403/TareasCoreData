//
//  Tarea+CoreDataProperties.swift
//  ToDoList
//
//  Created by Paola Garcia on 05/06/22.
//
//

import Foundation
import CoreData


extension Tarea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tarea> {
        return NSFetchRequest<Tarea>(entityName: "Tarea")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var fecha: Date?
    @NSManaged public var imagen: Data?

}

extension Tarea : Identifiable {

}

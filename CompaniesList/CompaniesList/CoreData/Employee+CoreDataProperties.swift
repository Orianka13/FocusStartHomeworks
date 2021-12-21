//
//  Employee+CoreDataProperties.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 21.12.2021.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var age: String
    @NSManaged public var experience: String?
    @NSManaged public var name: String
    @NSManaged public var uid: UUID
    @NSManaged public var company: Company
}

extension Employee : Identifiable {

}

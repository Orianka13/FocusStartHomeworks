//
//  Company+CoreDataProperties.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 21.12.2021.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String
    @NSManaged public var uid: UUID
    @NSManaged public var employees: NSOrderedSet?

}

// MARK: Generated accessors for employees
extension Company {

    @objc(insertObject:inEmployeesAtIndex:)
    @NSManaged public func insertIntoEmployees(_ value: Employee, at idx: Int)

    @objc(removeObjectFromEmployeesAtIndex:)
    @NSManaged public func removeFromEmployees(at idx: Int)

    @objc(insertEmployees:atIndexes:)
    @NSManaged public func insertIntoEmployees(_ values: [Employee], at indexes: NSIndexSet)

    @objc(removeEmployeesAtIndexes:)
    @NSManaged public func removeFromEmployees(at indexes: NSIndexSet)

    @objc(replaceObjectInEmployeesAtIndex:withObject:)
    @NSManaged public func replaceEmployees(at idx: Int, with value: Employee)

    @objc(replaceEmployeesAtIndexes:withEmployees:)
    @NSManaged public func replaceEmployees(at indexes: NSIndexSet, with values: [Employee])

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSOrderedSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSOrderedSet)

}

extension Company : Identifiable {

}

//
//  EmployeeModel.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import Foundation

protocol IEmployeeModel {
    func getName() -> String
    func getAge() -> Int32
    func getExperience() -> NSNumber?
}

final class EmployeeModel {
    private(set) var uid: UUID
    private(set) var companyId: UUID
    private var name: String
    private var age: Int32
    private var experience: NSNumber?
    
    
    init?(employee: Employee){
        self.name = employee.name
        self.age = employee.age
        self.experience = employee.experience
        
        self.uid = employee.uid
        self.companyId = employee.company.uid
    }
    
    init(name: String, age: Int32, experience: NSNumber?, companyId: UUID) {
        self.name = name
        self.age = age
        self.experience = experience
        self.companyId = companyId
        self.uid = UUID()
    }
}

//MARK: IEmployeeModel
extension EmployeeModel: IEmployeeModel {
    func getName() -> String {
        return self.name
    }
    
    func getAge() -> Int32 {
        return self.age
    }
    
    func getExperience() -> NSNumber? {
        return self.experience
    }
    
    func setModel(name: String, age: Int32, exp: NSNumber) {
        self.name = name
        self.age = age
        self.experience = exp
    }
}

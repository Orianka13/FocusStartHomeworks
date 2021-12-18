//
//  EmployeeModel.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import Foundation

protocol IEmployeeModel {
    func getName() -> String
    func getAge() -> String
    func getExperience() -> String?
}

final class EmployeeModel {
    private(set) var uid: UUID
    private(set) var companyId: UUID
    private var name: String
    private var age: String
    private var experience: String?
    
    
    init?(employee: Employee){
        self.name = employee.name ?? "Egor"
        self.age = employee.age ?? "0"
        self.experience = employee.experience
        
        guard let uid = employee.uid else { return nil }
        self.uid = uid
        
        guard let companyId = employee.company?.uid else { return nil }
        self.companyId = companyId
    }
    
    init(name: String, age: String, experience: String?, companyId: UUID) {
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
    
    func getAge() -> String {
        return self.age
    }
    
    func getExperience() -> String? {
        return self.experience
    }
}

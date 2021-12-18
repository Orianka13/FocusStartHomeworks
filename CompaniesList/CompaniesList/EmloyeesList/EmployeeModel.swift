//
//  EmployeeModel.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import Foundation

protocol IEmployeeModel {
    func getName() -> String
    func getAge() -> Double
    func getExperience() -> Double?
}

final class EmployeeModel {
    
    private let name: String
    private let age: Double
    private let experience: Double?
    
    init(employee: Employee){
        self.name = employee.name ?? "Egor"
        self.age = employee.age
        self.experience = employee.experience
        
    }
    
}

//MARK: IEmployeeModel
extension EmployeeModel: IEmployeeModel {
    func getName() -> String {
        return self.name
    }
    
    func getAge() -> Double {
        return self.age
    }
    
    func getExperience() -> Double? {
        return self.experience
    }
    
   
}

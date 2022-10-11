//
//  CompanyModell.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 22.12.2021.
//


import Foundation



protocol ICompanyModel {
    func getName() -> String
    
}

final class CompanyModel {
    private(set) var uid: UUID
    private var name: String
    
    init?(company: Company) {
        self.name = company.name
        self.uid = company.uid
        
    }
}

//MARK: ICompanyModel
extension CompanyModel: ICompanyModel {
    func getName() -> String {
        return self.name
    }
}

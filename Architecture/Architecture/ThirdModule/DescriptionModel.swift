//
//  DescriptionModel.swift
//  Architecture
//
//  Created by Олеся Егорова on 28.11.2021.
//

import Foundation

final class Description {
    
    var data: String?
    
    func getData() -> String {
        self.data ?? "Default text"
    }
    
    func setData(data: String) {
        self.data = data
    }
}

enum descriptionData {
    static let filmDescription = "Is a 2016 American superhero film based on the Marvel Comics character of the same name. Distributed by 20th Century Fox, it is a spin-off in the X-Men film series and the eighth installment overall ."
}

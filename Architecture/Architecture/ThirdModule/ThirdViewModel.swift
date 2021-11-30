//
//  ThirdViewModel.swift
//  Architecture
//
//  Created by Олеся Егорова on 29.11.2021.
//

import Foundation

final class Observable<T> {
    var data: T {
        didSet {
            self.notify?(self.data)
        }
    }
    
    private var notify: ((T) -> Void)?
    
    init(_ data: T) {
        self.data = data
    }
    
    func setNotify(notify: @escaping ((T) -> Void)) {
        self.notify = notify
        self.notify?(self.data)
    }
}

final class ThirdViewModel {
    
    private let description = Description()
    
    var data: Observable<String> = Observable<String>(descriptionData.filmDescription)
    
    init() {
        self.updateModel()
    }
    
    func updateModel() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            self?.description.setData(data: "New text")
            DispatchQueue.main.async {
                let viewData = self?.description.getData()
                self?.data.data = viewData ?? ""
            }
        }
    }
}








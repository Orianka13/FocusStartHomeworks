//
//  ViewModel.swift
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
    
    init(data: T) {
        self.data = data
    }
    
    func setNotify(notify: ((T) -> Void)?) {
        self.notify = notify
        self.notify?(self.data)
    }
}


final class ViewModel {
    
    private let description = Description()
    
    var dataModally: Observable<String> = Observable<String>(data: "cat")
    
    init() {
        self.updateModel()
    }
    
    func updateModel() {
        let timeLoad = Int.random(in: 1..<5)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(timeLoad)) { [weak self] in
            self?.description.setText(text: "kjhg")
            DispatchQueue.main.async { [weak self] in
                if let data = self?.description.getText() {
                    self?.dataModally.data = data
                }
            }
        }
    }
}

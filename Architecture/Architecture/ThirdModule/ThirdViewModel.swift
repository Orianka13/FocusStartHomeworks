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
    
    var data: Observable<String> = Observable<String>("description.getText()")
    
    init() {
        self.updateModel()
    }
    
    func updateData(text: String) {
        self.description.setText(text: text)
        print(description.getText())
        let text = description.getText()
        self.data.data = text
    }
    
    func updateModel() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
            self?.description.setText(text: "Текст обновился!")
            DispatchQueue.main.async { [weak self] in
                if let data = self?.description.getText() {
                    self?.data.data = data
                }
            }
        }
    }
}








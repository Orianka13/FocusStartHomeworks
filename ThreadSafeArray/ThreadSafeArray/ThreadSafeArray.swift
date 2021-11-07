//
//  ThreadSafeArray.swift
//  ThreadSafeArray
//
//  Created by Олеся Егорова on 07.11.2021.
//

import Foundation

class ThreadSafeArray<Element> {
    
    private var array = [Element]()
    
    var isEmpty: Bool {
        return self.array.isEmpty
    }
    
    var count: Int {
        return self.array.count
    }
    
    private let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    func append(_ item: Element) {
        queue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    func remove(at index: Int) {
        queue.async(flags: .barrier) {
            if self.array.indices.contains(index) {
                self.array.remove(at: index)
            } else {
                print("Удаление невозможно. Указан неверный индекс.")
            }
        }
    }
    
    subscript(index: Int) -> Element? {
        queue.sync {
            var element: Element?
            if self.array.indices.contains(index){
                element = self.array[index]
                return element
            } else {
                print("Нет элемента с указанным индексом")
            }
            return element
        }
    }
}

extension ThreadSafeArray where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        queue.sync {
            return self.array.contains(element)
        }
    }
}

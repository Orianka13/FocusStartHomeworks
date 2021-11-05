//
//  main.swift
//  ThreadSafeArray
//
//  Created by Олеся Егорова on 03.11.2021.
//

import Foundation

class ThreadSafeArray<Element> {
    
    private var threadSafeArray = [Element]()
    
    private var isEmpty: Bool {
        return threadSafeArray.isEmpty
    }
    
    private var count: Int {
        return threadSafeArray.count
    }
    
    private let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    func append(_ item: Element) {
        queue.async {
            self.threadSafeArray.append(item)
        }
    }
    
    func remove(at index: Int) {
        queue.async {
            self.threadSafeArray.remove(at: index)
        }
    }
    
    subscript(index: Int) -> Element? {
        queue.sync {
            var element: Element?
            if threadSafeArray.indices.contains(index){
                element = threadSafeArray[index]
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
            return threadSafeArray.contains(element)
        }
    }
}

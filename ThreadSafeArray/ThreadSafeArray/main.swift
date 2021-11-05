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
    
    
    func append(_ item: Element) {
        //async
        threadSafeArray.append(item)
        
    }
    
    func remove(at index: Int) {
        //async
        threadSafeArray.remove(at: index)
        
    }
    
    subscript(index: Int) -> Element? {
        //sync
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


extension ThreadSafeArray where Element: Equatable {
    func contains(_ element: Element) -> Bool {
       //sync
            return threadSafeArray.contains(element)
    }
}

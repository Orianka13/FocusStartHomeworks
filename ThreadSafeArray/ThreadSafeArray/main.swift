//
//  main.swift
//  ThreadSafeArray
//
//  Created by Олеся Егорова on 03.11.2021.
//

import Foundation

let testQueue = DispatchQueue(label: "testQueue", attributes: .concurrent)
var testArray = ThreadSafeArray<Int>()
let group = DispatchGroup()

group.enter()
testQueue.async {
    for number in 0...1000 {
        testArray.append(number)
    }
    group.leave()
}
group.wait()

group.enter()
testQueue.async {
    for number in 0...1000 {
        testArray.append(number)
    }
    group.leave()
}

group.wait()

group.notify(queue: testQueue){
    print("Количество элементов в массиве: \(testArray.count)")
}

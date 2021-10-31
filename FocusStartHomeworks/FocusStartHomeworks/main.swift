//
//  main.swift
//  FocusStartHomeworks
//
//  Created by Олеся Егорова on 29.10.2021.
//

import Foundation

private var cars = [Car]()
private var numberOfMenu: String?
private var body: Body

let auto1 = Car(manufacturer: "BMW", model: "X5", body: .crossover, yearOfIssue: 2006, carNumber: "VT567GT")
let auto2 = Car(manufacturer: "Audi", model: "A3", body: .sedan, yearOfIssue: 2020, carNumber: "VT123YT")
cars.append(auto1)
cars.append(auto2)

menu()

private func menu() {
    while true{
        print("""
            
            1 - Добавить автомобиль
            2 - Вывести список добавленных автомобилей
            3 - Отфильтровать по типу кузова
            """)
        menuOptions()
    }
}

private func menuOptions() {
    numberOfMenu = readLine() ?? "0"
    switch numberOfMenu {
    case "0":
        print("Выберите пункт меню\n")
    case "1":
        print("Добавить автомобиль\n")
        addAuto()
    case "2":
        print("Список добавленных автомобилей")
        listOfAutos(cars: cars)
    case "3":
        bodyFilter()
    default:
        print("Введите номер команды\n")
    }
}

private func addAuto(){
    var manufacturer: String
    var model: String
    var body: Body
    var yearOfIssue: Int?
    var carNumber: String?
    
    print("Укажите производителя:")
    manufacturer = readLine() ?? "Неизвестен"
    
    print("Укажите модель:")
    model = readLine() ?? "Неизвестен"
    
    bodyTypePrint()
    let bodyNumber = Int(readLine() ?? "0") ?? 0
    body = Body(index: bodyNumber) ?? .another
    
    print("Укажите год выпуска:")
    yearOfIssue = Int(readLine() ?? "-") ?? nil
    
    print("Укажите номер автомобиля:")
    carNumber = readLine() ?? nil
    
    let newCar = Car(manufacturer: manufacturer,
                     model: model,
                     body: body,
                     yearOfIssue: yearOfIssue,
                     carNumber: carNumber)
    
    cars.append(newCar)
    
    print("Автомобиль добавлен!")
}

private func listOfAutos(cars: [Car]){
    
    if cars.isEmpty {
        print("Автомобилей не найдено\n")
    }
    for car in cars {
        print("\nПроизводитель : ",car.manufacturer,
              "\nМодель: ", car.model,
              "\nТип кузова: ", car.body.rawValue,
              "\nГод выпуска: ", car.yearOfIssue ?? "-")
        if car.carNumber?.count != 0 {
            print("Гос.номер: ", car.carNumber ?? "-",
                  "\n")
        }
    }
}

private func bodyTypePrint(){
    print("Укажите тип кузова:")
    for (index, value) in Body.allCases.enumerated() {
        print(index, " - ", value.rawValue)
    }
}
private func bodyFilter() {
    bodyTypePrint()
    guard let bodyNumber = Int(readLine() ?? "0") else { return }
    let body = Body(index: bodyNumber) ?? .another
    let filteredBodyType = cars.filter { car in
        car.body == body }
    listOfAutos(cars: filteredBodyType)
}

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
    print("\n1 - Добавить автомобиль\n2 - Вывести список добавленных автомобилей\n3 - Отфильтровать по типу кузова")
    menuOptions()
}

private func menuOptions() {
    numberOfMenu = readLine() ?? "0"
    switch numberOfMenu {
    case "0":
        print("Выберите пункт меню\n")
        menu()
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
        menu()
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
    
    print("Укажите тип кузова:\n1 - Седан \n2 - Универсальный\n3 - Кабриолет\n4 - Пикап\n5 - Кроссовер\n6 - Другой")
    let bodyNumber = Int(readLine() ?? "6") ?? 6
    body = bodyType(numberOfType: bodyNumber)
    
    print("Укажите год выпуска:")
    yearOfIssue = Int(readLine() ?? "-") ?? nil
    
    print("Укажите номер автомобиля:")
    carNumber = readLine() ?? nil
    
    let newCar = Car(manufacturer: manufacturer, model: model, body: body, yearOfIssue: yearOfIssue, carNumber: carNumber)
    
    cars.append(newCar)
    
    print("Автомобиль добавлен!")
    
    menu()
}

private func bodyType(numberOfType: Int) -> Body {
    switch numberOfType {
    case 1:
        return .sedan
    case 2:
        return .universal
    case 3:
        return .cabriolet
    case 4:
        return .piсkup
    case 5:
        return .crossover
    case 6:
        return .another
    default:
        return .another
    }
}

private func listOfAutos(cars: [Car]){
    
    if cars.isEmpty {
        print("Автомобилей не найдено\n")
        menu()
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
    menu()
}

private func bodyFilter() {
    print("Укажите тип кузова:\n1 - Седан \n2 - Универсальный\n3 - Кабриолет\n4 - Пикап\n5 - Кроссовер\n6 - Другой")
    guard let bodyNumber = Int(readLine() ?? "6") else { return }
    let body = bodyType(numberOfType: bodyNumber)
    let filteredBodyType = cars.filter { car in
        car.body == body }
    listOfAutos(cars: filteredBodyType)
}

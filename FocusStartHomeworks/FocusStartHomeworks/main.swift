//
//  main.swift
//  FocusStartHomeworks
//
//  Created by Олеся Егорова on 29.10.2021.
//

import Foundation

var cars = [Car]()
var numberOfMenu: String?
var body: Body

menu()

private func menu() {
   print("1 - Добавить автомобиль\n2 - Вывести список добавленных автомобилей\n3 - Отфильтровать по типу кузова")
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
        print("Список добавленных автомобилей\n")
        listOfAutos()
    case "3":
        print("Отфильтровать по типу кузова\n")
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
    guard let bodyNumber = Int(readLine() ?? "6") else { return }
    body = bodyType(numberOfType: bodyNumber)

    print("Укажите год выпуска:")
    yearOfIssue = Int(readLine() ?? "-") ?? nil

    print("Укажите номер автомобиля:")
      carNumber = readLine() ?? nil
    
    let newCar = Car(manufacturer: manufacturer, model: model, body: body, yearOfIssue: yearOfIssue, carNumber: carNumber)
    
    cars.append(newCar)
    
    print("Автомобиль добавлен!")
    print()
    
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

private func listOfAutos(){
    
    if !cars.isEmpty {
        for car in cars {
            print("Производитель : \(car.manufacturer)\nМодель: \(car.model)\nТип кузова: \(car.body.rawValue)\nГод выпуска: \(car.yearOfIssue ?? 0)\nГос.номер: \(car.carNumber ?? "-")\n")
            menu()
        }
    } else {
        print("Автомобилей не найдено\n")
        
        menu()
    }
}


//
//  EmployeePresenter.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import Foundation
import CoreData

protocol IEmployeePresenter {
    func loadView(controller: IEmployeeViewController, view: IEmployeeView)
}

final class EmployeePresenter {
    
    private enum Literal {
        static let entityName = "Employee"
        static let companyError = "No company"
    }
    
    private let companyUid: UUID
    
    init(companyUid: UUID) {
        self.companyUid = companyUid
    }
    
    private weak var controller: IEmployeeViewController?
    private var view: IEmployeeView?
    private let coreDS = CoreDataStack()
    
    private var tableView: EmployeeTableView?
    private var employees = [Employee]()
    private var data = [EmployeeModel]()
}

//MARK: Private extension
private extension EmployeePresenter {
    func setHandlers() {
        
        self.controller?.onTouchedHandler = { [weak self] name, age, experience in
            guard let context = self?.getContext() else { return }
            
            guard let companyId = self?.companyUid else { return }
            
            guard let age = Int32(age) else { return }
            let experience = NSNumber(value: experience)
            
            let model = EmployeeModel(name: name, age: age, experience: experience, companyId: companyId)
            
            let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = '\(model.companyId)'")
            
            guard let company = try? context.fetch(fetchRequest).first else { return }
            guard let entity = NSEntityDescription.entity(forEntityName: Literal.entityName, in: context) else { return }
            
            let taskObject = Employee(entity: entity, insertInto: context)
            
            taskObject.name = model.getName()
            taskObject.uid = model.uid
            taskObject.experience = model.getExperience()
            taskObject.age = model.getAge()
            taskObject.company = company
            
            do {
                try context.save()
                self?.employees.append(taskObject)
                self?.data.append(model)
                self?.tableView?.reloadTableView()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        self.controller?.fetchRequestHandler = { [weak self] in
            guard let context = self?.getContext() else { return }
            
            let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
            guard let id = self?.companyUid else { return }
            fetchRequest.predicate = NSPredicate(format: "ANY company.uid = '\(id)'")
            
            
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                self?.employees = try context.fetch(fetchRequest)
                var array = [EmployeeModel]()
                self?.employees.forEach({ employee in
                    guard let modelObject = EmployeeModel(employee: employee) else { return }
                    array.append(modelObject)
                    self?.data = array
                })
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        self.tableView?.didSelectRowAtHandler = { [weak self] indexPath in
            guard let item = self?.data[indexPath.row] else { return }
            self?.controller?.showEditAlert(item: item)
            
            self?.controller?.editHandler = { [weak self] name, age, exp in
                guard let age = Int32(age) else { return }
                guard let intExp = exp else { return }
                let exp = NSNumber(value: intExp)
                item.setModel(name: name, age: age, exp: exp)
                self?.coreDS.update(employee: item)
                self?.tableView?.reloadTableView()
            }
        }
        
        
        self.tableView?.numberOfRowsInSectionHandler = { [weak self] in
            return self?.data.count ?? 0
        }
        
        self.tableView?.cellForRowAtHandler = { [weak self] indexPath in
            let item = self?.data[indexPath.row]
            return item?.getName() ?? Literal.companyError
            
        }
        
        self.tableView?.deleteItemHandler = { [weak self] indexPath in
            let uid = self?.data[indexPath.row].uid
            guard let employee = self?.data.first(where: { $0.uid == uid }) else { return }
            self?.coreDS.remove(employee: employee) { [weak self] in
                self?.controller?.fetchRequestHandler?()
                self?.tableView?.reloadTableView()
            }
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
    }
}

//MARK: IEmployeePresenter

extension EmployeePresenter: IEmployeePresenter {
    
    func loadView(controller: IEmployeeViewController, view: IEmployeeView) {
        self.controller = controller
        self.view = view
        
        self.tableView = view.getTableView()
        self.setHandlers()
        self.controller?.setNavBar()
    }
}

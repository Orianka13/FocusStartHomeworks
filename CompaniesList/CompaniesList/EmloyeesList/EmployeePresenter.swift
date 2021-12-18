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
     
    }
    
    private let companyUid: UUID
    
    init(companyUid: UUID) {
        self.companyUid = companyUid
    }
 
    private weak var controller: IEmployeeViewController?
    private var view: IEmployeeView?
    
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
            
            let model = EmployeeModel(name: name, age: age, experience: experience, companyId: companyId)
            
            let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = '\(model.companyId)'")
            
            guard let company = try? context.fetch(fetchRequest).first else { return }
            guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context) else { return }
            
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
            //let item = self?.data[indexPath.row]
            //guard let uid = item?.uid else { return }
            //let vc = EmployeeAssembly.build(companyUid: uid)
            //self?.controller?.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.tableView?.numberOfRowsInSectionHandler = { [weak self] in
            return self?.data.count ?? 0
        }
        
        self.tableView?.cellForRowAtHandler = { [weak self] indexPath in
            let item = self?.data[indexPath.row]
            return item?.getName() ?? "No company"
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let coreDS = CoreDataStack()
        return coreDS.persistentContainer.viewContext
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

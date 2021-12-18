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
    
 
    private weak var controller: IEmployeeViewController?
    private var view: IEmployeeView?
    
    private var tableView: EmployeeTableView?
    private var employees = [Employee]()
   
 
}

//MARK: Private extension
private extension EmployeePresenter {
    func setHandlers() {
        self.controller?.onTouchedHandler = {[weak self] name in
//            guard let context = self?.getContext() else { return }
//
//            guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context) else { return }
//
//            let taskObject = Employee(entity: entity, insertInto: context)
//            taskObject.name = name
//            //let mo = EmployeeModel(employee: taskObject)
//
//            do {
//                try context.save()
//                self?.employees.append(taskObject)
//                //self?.tableView?.appendData(data: mo)
//
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
        }
        
        self.controller?.fetchRequestHandler = { [weak self] in
            guard let context = self?.getContext() else { return }
            let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                self?.employees = try context.fetch(fetchRequest)
                //var modelData = [CompanyModel]()
                
                self?.employees.forEach({ employee in
                    //let modelObject = CompanyModel(company: company)
                    //modelData.append(modelObject)
                    //self?.tableView?.reloadDataArray(array: modelData)
                })
            } catch let error as NSError {
                print(error.localizedDescription)
            }
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

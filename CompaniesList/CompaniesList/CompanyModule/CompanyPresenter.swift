//
//  CompanyPresenterr.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import CoreData

protocol ICompanyPresenter {
    func loadView(controller: CompanyViewController, view: ICompanyView)
}

final class CompanyPresenter {
    
    private enum Literal {
        
        static let entityName = "Company"
        static let itemError = "No company"
    }
    
    private weak var controller: CompanyViewController?
    private var view: ICompanyView?
    
    private var tableView: CompanyTableView?
    private var companies = [Company]()
    private let coreDS = CoreDataStack()
    private var data = [CompanyModel]()
    
}

//MARK: Private extension
private extension CompanyPresenter {
    func setHandlers() {
        self.controller?.onTouchedHandler = {[weak self] name in
            guard let context = self?.getContext() else { return }
            
            guard let entity = NSEntityDescription.entity(forEntityName: Literal.entityName, in: context) else { return }
            
            let taskObject = Company(entity: entity, insertInto: context)
            
            taskObject.name = name
            taskObject.uid = UUID()
            
            guard let mo = CompanyModel(company: taskObject) else { return }
            
            do {
                try context.save()
                self?.companies.append(taskObject)
                self?.data.append(mo)
                self?.tableView?.reloadTableView()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        self.controller?.fetchRequestHandler = { [weak self] in
            guard let context = self?.getContext() else { return }
            let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            
            do {
                self?.companies = try context.fetch(fetchRequest)
                var array = [CompanyModel]()
                self?.companies.forEach({ company in
                    guard let modelObject = CompanyModel(company: company) else { return }
                    array.append(modelObject)
                    self?.data = array
                })
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        self.tableView?.didSelectRowAtHandler = { [weak self] indexPath in
            guard let item = self?.data[indexPath.row] else { return }
            let uid = item.uid
            let vc = EmployeeAssembly.build(companyUid: uid)
            self?.controller?.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.tableView?.numberOfRowsInSectionHandler = { [weak self] in
            return self?.data.count ?? 0
        }
        
        self.tableView?.cellForRowAtHandler = { [weak self] indexPath in
            let item = self?.data[indexPath.row]
            return item?.getName() ?? Literal.itemError
        }
        
        self.tableView?.deleteItemHandler = { [weak self] indexPath in
            let uid = self?.data[indexPath.row].uid
            guard let company = self?.data.first(where: { $0.uid == uid }) else { return }
            self?.coreDS.remove(company: company) { [weak self] in
                self?.controller?.fetchRequestHandler?()
                self?.tableView?.reloadTableView()
            }
        }
    }
    
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
        
    }
}

//MARK: ICompanyPresenter

extension CompanyPresenter: ICompanyPresenter {
    
    func loadView(controller: CompanyViewController, view: ICompanyView) {
        
        self.controller = controller
        self.view = view
        
        self.tableView = view.getTableView()
        self.setHandlers()
        self.controller?.setNavBar()
        
    }
}

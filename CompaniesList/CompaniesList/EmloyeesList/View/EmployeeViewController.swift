//
//  EmployeeViewController.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import UIKit
import CoreData

protocol IEmployeeViewController: AnyObject {
    func showAlert()
    func showEditAlert(item: EmployeeModel)
    func setNavBar()
    var onTouchedHandler: ((String, String, Int) -> Void)? { get set }
    var editHandler: ((String, String, Int?) -> Void)? { get set }
    var fetchRequestHandler: (() -> Void)? { get set }
}

final class EmployeeViewController: UIViewController {
    
    private enum Literal {
        static let alertTitle = "Добавьте сотрудника"
        static let placeholderName = "Имя"
        static let placeholderAge = "Возраст"
        static let placeholderExp = "Стаж"
        static let saveTitle = "Save"
        static let cancelTitle = "Cancel"
        
        static let editAlertTitle = "Отредактируйте сотрудника"
        static let navigationTitle = "Employees"
        static let imageSystemName = "plus"
        
        static let errorTitle = "Error"
        static let errorMessage = "Введите все обязательные поля!"
        static let okTitle = "OK"
    }
    
    var onTouchedHandler: ((String, String, Int) -> Void)?
    var fetchRequestHandler: (() -> Void)?
    var editHandler: ((String, String, Int?) -> Void)?
    
    private var employeeView: EmployeeView
    private var presenter: IEmployeePresenter?
    
    struct Dependencies {
        let presenter: IEmployeePresenter
    }
    
    init(dependencies: Dependencies) {
        self.employeeView = EmployeeView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.employeeView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchRequestHandler?()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(employeeView)
        self.view.backgroundColor = .systemGreen
        
    }
}

//MARK: Private extension
private extension EmployeeViewController {
    @objc func addNewEmployee() {
        showAlert()
    }
    
    func showErrorAlert(){
        let alertController = UIAlertController(title: Literal.errorTitle, message: Literal.errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Literal.okTitle, style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}




//MARK: IEmployeeViewController
extension EmployeeViewController: IEmployeeViewController {
    
    func showAlert(){
        let alertController = UIAlertController(title: Literal.alertTitle, message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields?[0].placeholder = Literal.placeholderName
        alertController.textFields?[1].placeholder = Literal.placeholderAge
        alertController.textFields?[2].placeholder = Literal.placeholderExp
        
        
        let saveAction = UIAlertAction(title: Literal.saveTitle, style: .default) { [weak self] _ in
            let nameTF = alertController.textFields?[0]
            let ageTF = alertController.textFields?[1]
            let expTF = alertController.textFields?[2]
            
            let nameCount = nameTF?.text?.count ?? 0
            let ageCount = ageTF?.text?.count ?? 0
            if nameCount > 1, ageCount > 1 {
                guard let name = nameTF?.text else { return }
                guard let age = ageTF?.text else { return }
                guard let expText = expTF?.text else { return }
                guard let exp = Int(expText) else { return }
                self?.onTouchedHandler?(name, age, exp)
            }
            else {
                self?.showErrorAlert()
            }
        }
        
        let cancelAction = UIAlertAction(title: Literal.cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showEditAlert(item: EmployeeModel){
        let alertController = UIAlertController(title: Literal.editAlertTitle, message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields?[0].text = item.getName()
        alertController.textFields?[1].text = String(item.getAge())
        alertController.textFields?[2].text = String(describing: item.getExperience())
        
        
        let saveAction = UIAlertAction(title: Literal.saveTitle, style: .default) { [weak self] _ in
            let nameTF = alertController.textFields?[0]
            let ageTF = alertController.textFields?[1]
            let expTF = alertController.textFields?[2]
            
            guard let name = nameTF?.text else { return }
            guard let age = ageTF?.text else { return }
            guard let expText = expTF?.text else { return }
            guard let exp = Int(expText) else { return }
            self?.editHandler?(name, age, exp)
        }
        
        let cancelAction = UIAlertAction(title: Literal.cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setNavBar(){
        self.navigationItem.title = Literal.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Literal.imageSystemName), style: .plain, target: self, action: #selector(addNewEmployee))
    }
}

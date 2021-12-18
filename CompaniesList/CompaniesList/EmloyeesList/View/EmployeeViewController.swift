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
    func setNavBar()
    var onTouchedHandler: ((String, String, String) -> Void)? { get set }
    var fetchRequestHandler: (() -> Void)? { get set }
}

final class EmployeeViewController: UIViewController {
    
    
    var onTouchedHandler: ((String, String, String) -> Void)?
    var fetchRequestHandler: (() -> Void)?
    
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
    
    @objc private func addNewEmployee() {
        showAlert()
    }
    
}

//MARK: IEmployeeViewController
extension EmployeeViewController: IEmployeeViewController {
    
    func showAlert(){
        let alertController = UIAlertController(title: "Добавьте сотрудника", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields?[0].placeholder = "Имя"
        alertController.textFields?[1].placeholder = "Возраст"
        alertController.textFields?[2].placeholder = "Стаж"
    
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            let nameTF = alertController.textFields?[0]
            let ageTF = alertController.textFields?[1]
            let expTF = alertController.textFields?[2]
            
            guard let name = nameTF?.text else { return }
            guard let age = ageTF?.text else { return }
            guard let exp = expTF?.text else { return }
            self?.onTouchedHandler?(name, age, exp)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setNavBar(){
        self.navigationItem.title = "Employees"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewEmployee))
    }
}

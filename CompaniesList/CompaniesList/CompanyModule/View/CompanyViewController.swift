//
//  CompanyViewController.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 16.12.2021.
//

import UIKit
import CoreData

protocol ICompanyViewController: AnyObject {
    func showAlert()
    func setNavBar()
    var onTouchedHandler: ((String) -> Void)? { get set }
    var fetchRequestHandler: (() -> Void)? { get set }
}

final class CompanyViewController: UIViewController {
    
    
    var onTouchedHandler: ((String) -> Void)?
    var fetchRequestHandler: (() -> Void)?
    
    private var companyView: CompanyView
    private var presenter: ICompanyPresenter?
    
    struct Dependencies {
        let presenter: ICompanyPresenter
    }
    
    init(dependencies: Dependencies) {
        self.companyView = CompanyView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.companyView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchRequestHandler?()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(companyView)
        self.view.backgroundColor = .systemGreen
        
    }
    
    @objc private func addNewCompany() {
        showAlert()
    }
    
}

//MARK: ICompanyViewController
extension CompanyViewController: ICompanyViewController {
    
    func showAlert(){
        let alertController = UIAlertController(title: "Добавьте компанию", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            guard let text = textField.text else { return }
            self?.onTouchedHandler?(text)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setNavBar(){
        self.navigationItem.title = "Companies List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewCompany))
    }
}

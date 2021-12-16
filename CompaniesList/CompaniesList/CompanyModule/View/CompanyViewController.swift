//
//  CompanyViewController.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 16.12.2021.
//

import UIKit

protocol ICompanyViewController: AnyObject {
    func showAlert()
}

final class CompanyViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(companyView)
        self.view.backgroundColor = .systemGray
    }
    
    
}

//MARK: ICompanyViewController
extension CompanyViewController: ICompanyViewController {
    
    func showAlert(){
        let alertController = UIAlertController(title: "Добавьте компанию", message: nil, preferredStyle: .alert)
        guard let textField = alertController.textFields?.first, textField.text != "" else { return }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

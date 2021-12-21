//
//  DetailTableView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import UIKit

class DetailTableView: UIView {

    private var tableView: UITableView = UITableView()
 
        var onTouchedHandler: (() -> Void)?
        
   override init(frame: CGRect) {
            super.init(frame: frame)
       
       self.tableView.dataSource = self
       self.tableView.delegate = self
       self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
       self.addView()
       self.setConstraint()
        }

required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


        private func addView() {
            self.addSubview(self.tableView)
        }

        private func setConstraint() {
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        }
    }

    extension DetailTableView: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
            cell.textLabel?.text = "Тип кузова какой то"
            cell.selectionStyle = .none
            return cell
        }

}

extension DetailTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.indexPathForSelectedRow?.forEach {_ in
               if let cell = tableView.cellForRow(at: indexPath) as? DetailTableViewCell {
                
                   cell.radioButtonImage.image = UIImage(systemName: "circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
               }
           }
        
        self.onTouchedHandler?()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? DetailTableViewCell {
         
            cell.radioButtonImage.image = UIImage(systemName: "circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            
        }
    }
}

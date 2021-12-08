//
//  TitleView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 03.12.2021.
//

import UIKit

final class ListView: UIView {
    
    private enum Constants {
        static let labelTitle = "Выберите"
        static let labelText = "Марку машины"
        static let labelFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let titleFont = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    
    let collectionView = ListCollectionView()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.labelTitle
        label.font = Constants.titleFont
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = Constants.labelText
        label.font = Constants.labelFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(labelTitle)
        self.addSubview(label)
        self.addSubview(collectionView)
    }
    
    private func setConstraint(){
        self.setLabelTitle()
        self.setLabel()
        self.setCollectionView()
    }
}

//MARK: - ListViewLayout

extension ListView {
    private func setLabelTitle() {
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    }
    
    private func setLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
        self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        self.label.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: 43).isActive = true
    }
    
    private func setCollectionView(){
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true

        self.collectionView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 20).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 1.5).isActive = true
    }
}

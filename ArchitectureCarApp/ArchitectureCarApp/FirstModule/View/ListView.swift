//
//  TitleView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 03.12.2021.
//

import UIKit

final class ListView: UIView {
    
    private enum Literal {
        static let labelTitle = "Выберите"
        static let labelText = "Марку машины"
    }
    
    private enum Fonts {
        static let labelFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let titleFont = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        static let leadingLabelSpacing = CGFloat(2)
        static let topLabelSpacing = CGFloat(43)
        static let topCollectionViewSpacing = CGFloat(20)
        static let heightCollectionView = CGFloat(1.5)
    }
    
    let collectionView = ListCollectionView()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = Literal.labelTitle
        label.font = Fonts.titleFont
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = Literal.labelText
        label.font = Fonts.labelFont
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
        self.labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
    
    private func setLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
        self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingLabelSpacing).isActive = true
        self.label.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: Metrics.topLabelSpacing).isActive = true
    }
    
    private func setCollectionView(){
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: Metrics.topCollectionViewSpacing).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.heightCollectionView).isActive = true
    }
}

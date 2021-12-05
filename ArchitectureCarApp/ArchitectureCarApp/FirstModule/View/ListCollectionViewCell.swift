//
//  ListCollectionViewCell.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 03.12.2021.
//

import UIKit


final class ListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "cell"
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        imageView.image = image
        return imageView
    }()
    
    private var markLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.text = "Some mark"
        return label
    }()
    
    private lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Select"
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .gray
        divider.contentMode = .scaleToFill
        return divider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(icon)
        self.addSubview(markLabel)
        self.addSubview(selectLabel)
        self.addSubview(dividerView)
    }
    
    private func setConstraint(){
        setIcon()
        setMarkLabel()
        setSelectLabel()
        setDividerView()
    }
    
    private func setIcon(){
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = false
        self.icon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        self.icon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        self.icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
    }
    
    private func setMarkLabel(){
        self.markLabel.translatesAutoresizingMaskIntoConstraints = false
        self.markLabel.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setSelectLabel(){
        self.selectLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setDividerView(){
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.dividerView.topAnchor.constraint(equalTo: self.markLabel.bottomAnchor, constant: 16).isActive = false
        self.dividerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.dividerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
}

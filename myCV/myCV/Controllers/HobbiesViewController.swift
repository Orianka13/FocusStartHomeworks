//
//  HobbiesViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

final class HobbiesViewController: UIViewController{
    var hobbies = Hobbies()
    var photoCollectionView = PhotoCollectionView()
    
    private lazy var titleLabel: UILabel = {
        let text = hobbies.label
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 30)
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        view.backgroundColor = mainBackgroundColor
    }
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(photoCollectionView)
    }
    private func setConstraints(){
        setTitle()
        setCollectionView()
    }
    
    private func setTitle(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / 15).isActive = true
    }
    
    private func setCollectionView(){
        self.photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        self.photoCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = false
        self.photoCollectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
    }
}

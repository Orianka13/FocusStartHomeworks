//
//  HobbiesViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

final class HobbiesViewController: UIViewController {
    
    private let hobbies = Hobbies()
    private let photoCollectionView = PhotoCollectionView()
    
    private enum TextSettings {
        static let mainTextColor = UIColor(ciColor: .white)
        static let numberOfLines = 0
    }
    private enum Fonts {
        static let titleFont = UIFont(name: "ChalkboardSE-Regular", size: 30)
        static let mainTextFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
    }
    private enum MainColor {
        static let mainBackgroundColor: UIColor = UIColor(red: 87/255, green: 64/255, blue: 67/255, alpha: 1)
    }
    private enum Metrics {
        static let titleHight = CGFloat(15)
        static let defaultSpacing = CGFloat(20)
        static let zeroSpacing = CGFloat(0)
        static let photoCollectionBottom = CGFloat(-100)
    }
    
    private lazy var titleLabel: UILabel = {
        let text = hobbies.label
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = Fonts.titleFont
        textLabel.textColor = TextSettings.mainTextColor
        textLabel.numberOfLines = TextSettings.numberOfLines
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        view.backgroundColor = MainColor.mainBackgroundColor
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
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / Metrics.titleHight).isActive = true
    }
    
    private func setCollectionView(){
        self.photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Metrics.photoCollectionBottom).isActive = true
        self.photoCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = false
        self.photoCollectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metrics.defaultSpacing).isActive = true
    }
}

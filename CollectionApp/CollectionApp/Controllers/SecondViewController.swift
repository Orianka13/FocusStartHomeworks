//
//  SecondViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    private enum constants {
        static let buttonTitle = "Show description.."
        static let buttonColor: UIColor = .darkGray
        static let buttonCornerRadius = CGFloat(8)
        
        static let mainBackgroundColor: UIColor = .black
        static let textColor: UIColor = .white
        
        static let topSpacing = CGFloat(20)
        static let bottomSpacing = CGFloat(-20)
        
        static let buttonWidth = CGFloat(180)
        static let buttonHeight = CGFloat(40)
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var showMore: UIButton = {
        let button = UIButton()
        button.setTitle(constants.buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = constants.buttonColor
        button.layer.cornerRadius = constants.buttonCornerRadius
        button.addTarget(self, action: #selector(showDescription), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = constants.mainBackgroundColor
        
        addSubviews()
        setConstraints()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = constants.textColor
        }
    }
    
    @objc private func showDescription() {
        let thirdVC = ThirdViewController()
        for (key, value) in descriptionData.filmDescription {
            if key == self.navigationItem.title {
                thirdVC.textView.text = value
            }
        }
        self.navigationController?.present(thirdVC, animated: true, completion: nil)
    }
    
    private func addSubviews(){
        view.addSubview(imageView)
        view.addSubview(showMore)
    }
    private func setConstraints(){
        setImage()
        setShowMoreButton()
    }
    
    private func setImage(){
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constants.topSpacing).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 1.5).isActive = false
    }
    
    private func setShowMoreButton(){
        self.showMore.translatesAutoresizingMaskIntoConstraints = false
        self.showMore.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: constants.topSpacing).isActive = true
        self.showMore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.showMore.widthAnchor.constraint(equalToConstant: constants.buttonWidth).isActive = true
        self.showMore.heightAnchor.constraint(equalToConstant: constants.buttonHeight).isActive = true
        self.showMore.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: constants.bottomSpacing).isActive = true
    }
}


//
//  CustomView.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import UIKit

final class CustomView: UIView
{
    var onTouchedHandler: (() -> Void)?
    
    private enum Constants {
        static let buttonTitle = "Show description.."
        static let buttonColor: UIColor = .darkGray
        static let buttonCornerRadius = CGFloat(8)
        
        static let topSpacing = CGFloat(20)
        static let bottomSpacing = CGFloat(-20)
        
        static let buttonWidth = CGFloat(180)
        static let buttonHeight = CGFloat(40)
        
        static let filmName = "Deadpool"
    }
    
    private lazy var imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var showMore: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.buttonColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(showDescription), for: .touchUpInside)
        return button
    }()
    
    func configView() {
        self.addSubview(self.imageView)
        self.addSubview(self.showMore)
        setConstraints()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: String) {
        self.imageView.image = UIImage(named: image)
    }
    
    private func setConstraints(){
        setImageView()
        setShowMoreButton()
    }
    
    @objc func showDescription() {
        self.onTouchedHandler?()
    }
    
    private func setImageView(){
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.topSpacing).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 1.5).isActive = false
    }
    
    private func setShowMoreButton(){
        self.showMore.translatesAutoresizingMaskIntoConstraints = false
        self.showMore.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Constants.topSpacing).isActive = true
        self.showMore.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.showMore.widthAnchor.constraint(equalToConstant: Constants.buttonWidth).isActive = true
        self.showMore.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        self.showMore.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: Constants.bottomSpacing).isActive = true
    }
}

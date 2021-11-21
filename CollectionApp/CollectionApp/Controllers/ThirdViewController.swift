//
//  ThirdViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class ThirdViewController: UIViewController {
    
    private enum Constants {
        static let textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 25)
        static let textColor: UIColor = .white
        static let numberOfLines = 0
        
        static let closeImageName = "xmark"
        
        static let mainBackgroundColor: UIColor = .darkGray
        
        static let mainSpacing = CGFloat(20)
        static let trailingSpacing = CGFloat(-20)
    }
    
    private lazy var textView: UILabel = {
        let textLabel = UILabel(frame: .zero)
        textLabel.font = Constants.textFont
        textLabel.textColor = Constants.textColor
        textLabel.textAlignment = .center
        textLabel.numberOfLines = Constants.numberOfLines
        return textLabel
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: Constants.closeImageName), for: .normal)
        closeButton.addTarget(self, action: #selector(goBackButton), for: .touchUpInside)
        closeButton.tintColor = Constants.textColor
        return closeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.mainBackgroundColor
        
        addSubviews()
        setConstraints()
    }
    
    @objc private func goBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func setTextData(value: String) {
        self.textView.text = value
    }
    
    private func addSubviews(){
        view.addSubview(textView)
        view.addSubview(closeButton)
    }
    
    private func setConstraints(){
        setTextView()
        setCloseButton()
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.mainSpacing).isActive = false
        self.textView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.textView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.mainSpacing).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingSpacing).isActive = true
    }
    
    private func setCloseButton(){
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.mainSpacing).isActive = true
        self.closeButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.mainSpacing).isActive = true
    }
}

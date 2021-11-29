//
//  DescriptionView.swift
//  Architecture
//
//  Created by Олеся Егорова on 28.11.2021.
//

import UIKit

class DescriptionView: UIView {
    
    var onTouchedHandler: (() -> Void)?
    
    private let viewModel = ThirdViewModel()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        
        self.viewModel.data.setNotify { [weak self] text in
                    self?.textView.text = text
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        self.addSubview(textView)
        self.addSubview(closeButton)
    }
    
    private func setConstraints(){
        setTextView()
        setCloseButton()
    }
    
    @objc private func goBackButton() {
        self.onTouchedHandler?()
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.mainSpacing).isActive = false
        self.textView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.textView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.mainSpacing).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingSpacing).isActive = true
    }
    
    private func setCloseButton(){
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.mainSpacing).isActive = true
        self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.mainSpacing).isActive = true
    }
}

//
//  DescriptionView.swift
//  Architecture
//
//  Created by Олеся Егорова on 28.11.2021.
//

import UIKit

final class DescriptionView: UIView {
    
    private enum Literal {
        static let closeImageName = "xmark"
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 25)
    }
    
    private enum Metrics {
        static let mainSpacing = CGFloat(20)
        static let trailingSpacing = CGFloat(-20)
        static let numberOfLines = 0
    }
    
    private enum Colors {
        static let textColor: UIColor = .white
        static let mainBackgroundColor: UIColor = .darkGray
    }
    
    var onTouchedHandler: (() -> Void)?
    
    private let viewModel = ThirdViewModel()
    
    private lazy var textView: UILabel = {
        let textLabel = UILabel(frame: .zero)
        textLabel.font = Fonts.textFont
        textLabel.textColor = Colors.textColor
        textLabel.textAlignment = .center
        textLabel.numberOfLines = Metrics.numberOfLines
        return textLabel
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: Literal.closeImageName), for: .normal)
        closeButton.addTarget(self, action: #selector(goBackButton), for: .touchUpInside)
        closeButton.tintColor = Colors.textColor
        return closeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
        self.setConstraints()
        
        self.viewModel.data.setNotify { [weak self] text in
            self?.textView.text = text
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Private extension

private extension DescriptionView {
    
    func addSubviews(){
        self.addSubview(textView)
        self.addSubview(closeButton)
    }
    
    func setConstraints(){
        self.makeTextViewConstraints()
        self.makeCloseButtonConstraints()
    }
    
    @objc func goBackButton() {
        self.onTouchedHandler?()
    }
    
    func makeTextViewConstraints(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.mainSpacing).isActive = false
        self.textView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.textView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.mainSpacing).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Metrics.trailingSpacing).isActive = true
    }
    
    func makeCloseButtonConstraints(){
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.mainSpacing).isActive = true
        self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.mainSpacing).isActive = true
    }
}

//
//  PosterView.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import UIKit

protocol IPosterView: UIView {
    
    var onTouchedHandler: (() -> Void)? { get set }
    
    func setImage(image: String)
}


final class PosterView: UIView {
    
    private enum Literal {
        static let buttonTitle = "Show description.."
    }
    
    private enum Metrics {
        
        static let buttonCornerRadius = CGFloat(8)
        
        static let topSpacing = CGFloat(20)
        static let bottomSpacing = CGFloat(-20)
        
        static let buttonWidth = CGFloat(180)
        static let buttonHeight = CGFloat(40)
    }
    
    private enum Colors {
        static let buttonColor: UIColor = .darkGray
    }
    
    var onTouchedHandler: (() -> Void)?
    
    private lazy var imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var showMore: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.buttonColor
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.addTarget(self, action: #selector(showDescription), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private extension
private extension PosterView {
    
    func configView() {
        self.addSubview(self.imageView)
        self.addSubview(self.showMore)
        setConstraints()
    }
    
    func setConstraints(){
        makeImageViewConstraints()
        makeShowMoreButtonConstraints()
    }
    
    @objc func showDescription() {
        self.onTouchedHandler?()
    }
    
    func makeImageViewConstraints(){
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.topSpacing).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 1.5).isActive = false
    }
    
    func makeShowMoreButtonConstraints(){
        self.showMore.translatesAutoresizingMaskIntoConstraints = false
        self.showMore.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Metrics.topSpacing).isActive = true
        self.showMore.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.showMore.widthAnchor.constraint(equalToConstant: Metrics.buttonWidth).isActive = true
        self.showMore.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight).isActive = true
        self.showMore.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: Metrics.bottomSpacing).isActive = true
    }
}

//MARK: IPosterView

extension PosterView: IPosterView {
    
    func setImage(image: String) {
        self.imageView.image = UIImage(named: image)
    }
}

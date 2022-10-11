//
//  ViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 10.11.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    let info = Info()
    
    private enum ButtonSettings {
        static let buttonCornerRadius = CGFloat(10)
        static let buttonTopSpacing = CGFloat(10)
        static let buttonWidth = CGFloat(100)
        static let buttonHeight = CGFloat(40)
        static let buttonAlpha = CGFloat(0.8)
    }
    private enum TextSettings {
        static let mainTextColor = UIColor(ciColor: .white)
        static let numberOfLines = 0
    }
    private enum Fonts {
        static let titleFont = UIFont(name: "ChalkboardSE-Regular", size: 30)
        static let mainTextFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        static let buttonFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    private enum MainColor {
        static let mainBackgroundColor: UIColor = UIColor(red: 87/255, green: 64/255, blue: 67/255, alpha: 1)
    }
    private enum Metrics {
        static let titleHight = CGFloat(15)
        static let photoCenterY = CGFloat(-150)
        static let photoHeight = CGFloat(2.5)
        static let defaultSpacing = CGFloat(20)
        static let trailingSpacing = CGFloat(-20)
        static let textHeight = CGFloat(6)
    }
    
    private lazy var titleLabel: UILabel = {
        let text = info.label
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = Fonts.titleFont
        textLabel.textColor = TextSettings.mainTextColor
        textLabel.numberOfLines = TextSettings.numberOfLines
        return textLabel
    }()
    
    lazy var photoView: UIImageView = {
        let image = UIImage(named: info.photoImage.first ?? "me")
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var textView: UILabel = {
        let text = info.text.first
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = Fonts.mainTextFont
        textLabel.textColor = TextSettings.mainTextColor
        textLabel.textAlignment = .center
        textLabel.numberOfLines = TextSettings.numberOfLines
        return textLabel
    }()
    
    lazy var showMoreTF: UITextField = {
        let text = info.button.first
        let showMoreTF = UITextField(frame: .zero)
        showMoreTF.text = text
        showMoreTF.font = Fonts.buttonFont
        showMoreTF.textColor = MainColor.mainBackgroundColor
        showMoreTF.textAlignment = .center
        showMoreTF.backgroundColor = .systemGray3
        showMoreTF.alpha = ButtonSettings.buttonAlpha
        showMoreTF.layer.cornerRadius = ButtonSettings.buttonCornerRadius
        return showMoreTF
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        choicePoint()
        
        view.backgroundColor = MainColor.mainBackgroundColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(photoView)
        view.addSubview(textView)
        view.addSubview(showMoreTF)
    }
    private func setConstraints(){
        setTitle()
        setPhotoView()
        setTextView()
        setShowMoreButton()
    }
    
    private func setTitle(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / Metrics.titleHight).isActive = true
    }
    
    private func setPhotoView(){
        self.photoView.translatesAutoresizingMaskIntoConstraints = false
        self.photoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: Metrics.photoCenterY).isActive = false
        self.photoView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.photoView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / Metrics.photoHeight).isActive = true
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.photoView.bottomAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Metrics.trailingSpacing).isActive = true
        self.textView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / Metrics.textHeight).isActive = true
    }
    
    private func setShowMoreButton(){
        self.showMoreTF.translatesAutoresizingMaskIntoConstraints = false
        self.showMoreTF.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: ButtonSettings.buttonTopSpacing).isActive = true
        self.showMoreTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.showMoreTF.widthAnchor.constraint(equalToConstant: ButtonSettings.buttonWidth).isActive = true
        self.showMoreTF.heightAnchor.constraint(equalToConstant: ButtonSettings.buttonHeight).isActive = true
    }
    
}


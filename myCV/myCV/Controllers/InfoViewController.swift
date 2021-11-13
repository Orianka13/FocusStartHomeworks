//
//  ViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 10.11.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    let info = Info()
    
   private lazy var titleLabel: UILabel = {
        let text = info.label
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 30)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
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
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var showMoreTF: UITextField = {
        let text = info.button.first
        let showMoreTF = UITextField(frame: .zero)
        showMoreTF.text = text
        showMoreTF.font = .systemFont(ofSize: 15, weight: .regular)
        showMoreTF.textColor = .black
        showMoreTF.backgroundColor = .brown
        return showMoreTF
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        choicePoint()
    }
    
    func setupTopBar() {
        self.navigationItem.title = "Обо мне"
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
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / 15).isActive = true
    }
    
    private func setPhotoView(){
        self.photoView.translatesAutoresizingMaskIntoConstraints = false
        self.photoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = false
        self.photoView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.photoView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 2.5).isActive = true
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.photoView.bottomAnchor, constant: 20).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.textView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 6).isActive = true
    }
    
    private func setShowMoreButton(){
        self.showMoreTF.translatesAutoresizingMaskIntoConstraints = false
        self.showMoreTF.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 10).isActive = true
        self.showMoreTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.showMoreTF.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.showMoreTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}


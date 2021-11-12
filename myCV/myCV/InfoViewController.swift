//
//  ViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 10.11.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let info = Info()
    
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
        textLabel.font = .systemFont(ofSize: 15, weight: .regular)
        textLabel.textColor = .black
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
  
    private func addSubviews(){
        view.addSubview(photoView)
        view.addSubview(textView)
        view.addSubview(showMoreTF)
    }
    private func setConstraints(){
        setPhotoView()
        setTextView()
        setShowMoreButton()
    }
    
    private func setPhotoView(){
        self.photoView.translatesAutoresizingMaskIntoConstraints = false
        self.photoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        self.photoView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.photoView.bottomAnchor, constant: 30).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 30).isActive = true
        self.textView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setShowMoreButton(){
        self.showMoreTF.translatesAutoresizingMaskIntoConstraints = false
        self.showMoreTF.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 30).isActive = true
        self.showMoreTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.showMoreTF.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.showMoreTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}


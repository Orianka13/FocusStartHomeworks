//
//  ThirdViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class ThirdViewController: UIViewController {
    
    lazy var textView: UILabel = {
        let textLabel = UILabel(frame: .zero)
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(goBackButton), for: .touchUpInside)
        return closeButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        addSubviews()
        setConstraints()
    }
    
    @objc private func goBackButton() {
        dismiss(animated: true, completion: nil)
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
        self.textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = false
        self.textView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.textView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setCloseButton(){
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.closeButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
}

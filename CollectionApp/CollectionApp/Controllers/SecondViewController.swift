//
//  SecondViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let showMore: UIButton = {
        let button = UIButton()
        button.setTitle("Show description..", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(showDescription), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        addSubviews()
        setConstraints()
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
        self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 1.5).isActive = false
    }
    
    private func setShowMoreButton(){
        self.showMore.translatesAutoresizingMaskIntoConstraints = false
        self.showMore.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20).isActive = true
        self.showMore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.showMore.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.showMore.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.showMore.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}


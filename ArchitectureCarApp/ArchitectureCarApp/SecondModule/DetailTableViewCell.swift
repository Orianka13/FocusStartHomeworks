//
//  DetailTableViewCell.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    private lazy var radioButtonImage: UIImageView = {
        let image = UIImage(systemName: "circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addView() {
        self.addSubview(radioButtonImage)
    }
    private func setConstraint() {
        setRadioButtonImage()
    }
    
    func setOnImage(){
        self.radioButtonImage.image = UIImage(systemName: "circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        
    }
    func setOffImage(){
        self.radioButtonImage.image = UIImage(systemName: "circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    }
    
    func updateText(text: String) {
        self.textLabel?.text = text
    }

    private func setRadioButtonImage(){
        self.radioButtonImage.translatesAutoresizingMaskIntoConstraints = false
        self.radioButtonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.radioButtonImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        self.radioButtonImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        self.radioButtonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
}

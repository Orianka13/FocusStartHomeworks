//
//  DetailTableViewCell.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import UIKit

protocol IDetailTableViewCell {
    func setOnImage()
    func setOffImage()
    func updateText(text: String)
}

final class DetailTableViewCell: UITableViewCell {
    
    private enum Literal {
        static let cellId = "cell"
        static let radioButtonOffImage = "circle"
        static let radioButtonOnImage = "circle.fill"
    }
    
    private enum Metrics {
        static let radioButtonSize = CGFloat(16)
        static let zeroSpacing = CGFloat(0)
    }
    
    static let reuseIdentifier = Literal.cellId
    
    private lazy var radioButtonImage: UIImageView = {
        let image = UIImage(systemName: Literal.radioButtonOffImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
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
}

//MARK: Private extension
private extension DetailTableViewCell {
    
    func addView() {
        self.addSubview(radioButtonImage)
    }
    func setConstraint() {
        self.makeRadioButtonImageConstraints()
    }
    
    func makeRadioButtonImageConstraints(){
        self.radioButtonImage.translatesAutoresizingMaskIntoConstraints = false
        self.radioButtonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.radioButtonImage.widthAnchor.constraint(equalToConstant: Metrics.radioButtonSize).isActive = true
        self.radioButtonImage.heightAnchor.constraint(equalToConstant: Metrics.radioButtonSize).isActive = true
        self.radioButtonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
}

//MARK: IDetailTableViewCell
extension DetailTableViewCell: IDetailTableViewCell {
    
    func setOnImage(){
        self.radioButtonImage.image = UIImage(systemName: Literal.radioButtonOnImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        
    }
    func setOffImage(){
        self.radioButtonImage.image = UIImage(systemName: Literal.radioButtonOffImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    }
    
    func updateText(text: String) {
        self.textLabel?.text = text
    }
}

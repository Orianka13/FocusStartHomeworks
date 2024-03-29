//
//  CollectionCell.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
  
    private enum Constants {
        static let labelFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        static let numberOfLines = 0
        static let textColor: UIColor = .white
        
        static let errorMessage = "not implemnted"
        
        static let zeroSpacing = CGFloat(0)
        static let inset = CGFloat(10)
        static let bottomSpacing = CGFloat(-40)
        
        static let mainBackgroundColor: UIColor = .black
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Constants.labelFont
        label.textAlignment = .center
        label.numberOfLines = Constants.numberOfLines
        label.textColor = Constants.textColor
        return label
    }()
    
    private lazy var posterView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMessage)
    }
    
    func setCellData(film: Film){
        self.label.text = film.name
        self.posterView.image = UIImage(named: film.poster)
        self.contentView.backgroundColor = Constants.mainBackgroundColor
    }
    
    private func addSubviews(){
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(posterView)
    }
    
    private func setConstraints(){
        setLabel()
        setPosterView()
    }
    
}

//MARK: - CollectionViewCellLayout

extension CollectionCell {
    
    private func setLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.inset).isActive = true
        self.label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.inset).isActive = true
        self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.inset).isActive = false
        self.label.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: Constants.zeroSpacing).isActive = true
        self.label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.zeroSpacing).isActive = true
    }
    
    private func setPosterView(){
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
        
        self.posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.inset).isActive = true
        self.posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.inset).isActive = true
        self.posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.inset).isActive = true
        self.posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomSpacing).isActive = true
    }
}





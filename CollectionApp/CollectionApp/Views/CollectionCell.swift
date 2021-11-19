//
//  CollectionCell.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    
    let label: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let posterView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
}

//MARK: - CollectionViewCellLayout

extension CollectionCell {
    
    private func configure() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.posterView.translatesAutoresizingMaskIntoConstraints = false
     
        contentView.addSubview(label)
        contentView.addSubview(posterView)
        
        let inset = CGFloat(10)
        
        self.label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        self.label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = false
        self.label.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: inset).isActive = true
        self.label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset).isActive = true
        
        self.posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        self.posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        self.posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        self.posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
    }
}





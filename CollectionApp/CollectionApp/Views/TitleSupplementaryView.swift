//
//  TitleSupplementaryView.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {
    
    private enum constants {
        static let textColor: UIColor = .white
        static let textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        
        static let inset = CGFloat(10)
        static let leadingSpacing = CGFloat(20)
        static let bottomSpacing = CGFloat(0)
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = constants.textColor
        label.font = constants.textFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        setLabel()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - TitleViewLayout

extension TitleSupplementaryView {
    
    private func setLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constants.leadingSpacing).isActive = true
        self.label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constants.inset).isActive = true
        self.label.topAnchor.constraint(equalTo: topAnchor, constant: constants.inset).isActive = true
        self.label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constants.bottomSpacing).isActive = true
    }
}


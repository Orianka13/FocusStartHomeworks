//
//  TitleSupplementaryView.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {
    
    private enum Metrics {
        static let inset = CGFloat(10)
        static let leadingSpacing = CGFloat(20)
        static let bottomSpacing = CGFloat(0)
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
    }
    
    private enum Colors {
        static let textColor: UIColor = .white
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textColor
        label.font = Fonts.textFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        self.makeLabelConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateLabel(section: ViewSection) {
        self.label.text = section.title
    }
}

//MARK: - TitleViewLayout

extension TitleSupplementaryView {
    
    private func makeLabelConstraints() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.leadingSpacing).isActive = true
        self.label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.inset).isActive = true
        self.label.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.inset).isActive = true
        self.label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Metrics.bottomSpacing).isActive = true
    }
}


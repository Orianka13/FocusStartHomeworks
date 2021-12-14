//
//  ListCollectionViewCell.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 03.12.2021.
//

import UIKit

protocol IListCollectionViewCell {
    func setMarkLabelText(text: String)
    var labelHandler: ((String?) -> String)? { get set }
}

final class ListCollectionViewCell: UICollectionViewCell {
    
    private enum Literal {
        static let iconImageName = "circle.fill"
        static let cellId = "cell"
        static let selectLabelText = "Select"
    }
    
    private enum Fonts {
        static let markLabelFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let selectLabelFont = UIFont.systemFont(ofSize: 14)
    }
    
    private enum Colors {
        static let dividerViewColor: UIColor = .opaqueSeparator
    }
    
    private enum Metrics {
        static let iconSize = CGFloat(16)
        static let zeroSpacing = CGFloat(0)
        static let leadingMarkLabelSpacing = CGFloat(16)
        static let topDividerViewSpacing = CGFloat(16)
        static let heightDividerView = CGFloat(1)
    }

    static let reuseIdentifier = Literal.cellId
    
    var labelHandler: ((String?) -> String)?
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: Literal.iconImageName)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        imageView.image = image
        return imageView
    }()
    
    private var markLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.markLabelFont
        return label
    }()
    
    private lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.selectLabelFont
        label.text = Literal.selectLabelText
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = Colors.dividerViewColor
        divider.contentMode = .scaleToFill
        return divider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addView()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
    
//MARK: Private extension

private extension ListCollectionViewCell {
    
    func addView(){
        self.addSubview(icon)
        self.addSubview(markLabel)
        self.addSubview(selectLabel)
        self.addSubview(dividerView)
    }
    
    func setConstraint(){
        self.makeIconConstraints()
        self.makeMarkLabelConstraints()
        self.makeSelectLabelConstraints()
        self.makeDividerViewConstraints()
    }
    
    func makeIconConstraints(){
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = false
        self.icon.widthAnchor.constraint(equalToConstant: Metrics.iconSize).isActive = true
        self.icon.heightAnchor.constraint(equalToConstant: Metrics.iconSize).isActive = true
        self.icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
    
    func makeMarkLabelConstraints(){
        self.markLabel.translatesAutoresizingMaskIntoConstraints = false
        self.markLabel.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: Metrics.leadingMarkLabelSpacing).isActive = true
    }
    
    func makeSelectLabelConstraints(){
        self.selectLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
    
    func makeDividerViewConstraints(){
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.dividerView.topAnchor.constraint(equalTo: self.markLabel.bottomAnchor, constant: Metrics.topDividerViewSpacing).isActive = false
        self.dividerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.dividerView.heightAnchor.constraint(equalToConstant: Metrics.heightDividerView).isActive = true
    }
}

//MARK: IListCollectionViewCell

extension ListCollectionViewCell: IListCollectionViewCell {
    func setMarkLabelText(text: String){
        self.markLabel.text = text
    }
}

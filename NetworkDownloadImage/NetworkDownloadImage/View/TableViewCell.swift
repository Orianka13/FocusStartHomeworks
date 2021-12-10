//
//  TableViewCell.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

protocol ITableViewCell {
    func setImage()
}

final class TableViewCell: UITableViewCell {
    
    private enum Literal {
        static let cellId = "cell"
    }
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
    }
    
    static let reuseIdentifier = Literal.cellId
    
    private lazy var image: UIImageView = {
        let image = UIImage()
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
private extension TableViewCell {
    
    func addView() {
        self.addSubview(image)
    }
    func setConstraint() {
        self.makeImageConstraints()
    }
    
    func makeImageConstraints(){
        self.image.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: ITableViewCell
extension TableViewCell: ITableViewCell {
    func setImage(){
     
    }
}


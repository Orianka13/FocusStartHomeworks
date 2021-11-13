//
//  CollectionViewCell.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCellView: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func addImages(name: String){
        DispatchQueue.main.async {
            self.photoCellView.image = UIImage(named: name)
        }
    }
}

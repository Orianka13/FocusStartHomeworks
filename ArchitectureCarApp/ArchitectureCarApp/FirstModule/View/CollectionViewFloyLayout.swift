//
//  CollectionViewFloyLayout.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 03.12.2021.
//

import UIKit

final class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private enum Metrics {
        static let itemHight = CGFloat(35)
        static let topSpacing = CGFloat(2)
        static let bottomSpacing = CGFloat(0)
    }
    
    override func prepare() {
        super.prepare()

        guard let collectionView = self.collectionView else { return }

        self.itemSize = CGSize(width: collectionView.frame.size.width, height: Metrics.itemHight)

        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing * Metrics.topSpacing,
                                         left: self.minimumInteritemSpacing,
                                         bottom: Metrics.bottomSpacing,
                                         right: self.minimumInteritemSpacing)
        self.sectionInsetReference = .fromSafeArea
    }
}

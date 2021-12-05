//
//  CollectionViewFloyLayout.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 03.12.2021.
//

import UIKit

final class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()

        guard let collectionView = self.collectionView else { return }

        self.itemSize = CGSize(width: collectionView.frame.size.width, height: 35)

        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing * 2,
                                         left: self.minimumInteritemSpacing,
                                         bottom: 0,
                                         right: self.minimumInteritemSpacing)
        self.sectionInsetReference = .fromSafeArea
    }
}

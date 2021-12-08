//
//  ListCollectionView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation
import UIKit
 
final class ListCollectionView: UICollectionView {
    
    var onTouchedHandler: ((IndexPath) -> Void)?
    var loadHandler: ((ListCollectionViewCell?, IndexPath) -> Void)?
    
    init() {
        let layout = CollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        
        self.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
//MARK: UICollectionViewDataSource

extension ListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Mark.allMarks.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier, for: indexPath) as! ListCollectionViewCell
        
        self.loadHandler?(cell, indexPath)
        
        return cell
    }
}
 
//MARK: UICollectionViewDelegate

extension ListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.onTouchedHandler?(indexPath)
        
    }
}


 


//
//  PhotoCollectionView.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

let reuseIdentifier = "cell"

class PhotoCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    var hobbies = Hobbies()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        dataSource = self
        delegate = self
        
        backgroundColor = .white
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        reloadData()
        translatesAutoresizingMaskIntoConstraints = false
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hobbies.imageGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let name = hobbies.imageGallery[indexPath.row]
        cell.addImages(name: name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("lkjhgvfcx")
    }
 
}
 //MARK: - UICollectionViewDelegateFlowLayout

extension PhotoCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

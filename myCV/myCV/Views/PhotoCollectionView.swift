//
//  PhotoCollectionView.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

final class PhotoCollectionView: UICollectionView {
    let hobbies = Hobbies()
    
    private enum CellIdentifier {
        static let reuseIdentifier = "cell"
    }
    private enum MainColor {
        static let mainBackgroundColor: UIColor = UIColor(red: 87/255, green: 64/255, blue: 67/255, alpha: 1)
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        
        backgroundColor = MainColor.mainBackgroundColor
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        register(nib, forCellWithReuseIdentifier: CellIdentifier.reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UICollectionViewDataSource

extension PhotoCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hobbies.imageGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let name = hobbies.imageGallery[indexPath.row]
        cell.addImages(name: name)
        cell.textLabel.text = hobbies.text[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotoCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

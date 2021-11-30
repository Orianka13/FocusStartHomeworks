//
//  CollectionViewLayout.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import UIKit

extension CollectionViewController {
    
    private enum Metrics {
        static let headerElementKind = "header-element-kind"
        
        static let spacing = CGFloat(0)
        static let fractionalWidthItem = CGFloat(0.5)
        static let fractionalHeightItem = CGFloat(1.0)
        
        static let fractionalWidthGroup = CGFloat(0.85)
        static let heightGroup = CGFloat(300)
        
        static let fractionalWidthHeader = CGFloat(1.0)
        static let heightHeader = CGFloat(44)
        
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Metrics.spacing
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Metrics.fractionalWidthItem), heightDimension: .fractionalHeight(Metrics.fractionalHeightItem)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: Metrics.spacing, leading: Metrics.spacing, bottom: Metrics.spacing, trailing: Metrics.spacing)
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metrics.fractionalWidthGroup),
                                                   heightDimension: .absolute(Metrics.heightGroup)),
                subitems: [leadingItem])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metrics.fractionalWidthHeader),
                                                   heightDimension: .estimated(Metrics.heightHeader)),
                elementKind: CollectionViewController.Metrics.headerElementKind,
                alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            return section
            
        }, configuration: config)
        return layout
    }
}

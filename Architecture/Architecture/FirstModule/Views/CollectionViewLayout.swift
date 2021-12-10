//
//  CollectionViewLayout.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import UIKit

final class CollectionViewLayout {
    
    private enum Literal {
        static let headerElementKind = "header-element-kind"
    }
    
    private enum Metrics {
        static let spacing = CGFloat(0)
        static let fractionalWidthItem = CGFloat(0.5)
        static let fractionalHeightItem = CGFloat(1.0)
        
        static let fractionalWidthGroup = CGFloat(0.85)
        static let heightGroup = CGFloat(300)
        
        static let fractionalWidthHeader = CGFloat(1.0)
        static let heightHeader = CGFloat(44)
    }
    
    static func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Metrics.spacing
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
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
                elementKind: Literal.headerElementKind,
                alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            return section
            
        }, configuration: config)
        return layout
    }
}

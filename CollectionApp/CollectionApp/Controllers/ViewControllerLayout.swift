//
//  ViewControllerLayout.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class FirstViewController: UIViewController {
    
    private enum constants {
        static let headerElementKind = "header-element-kind"
        static let navItem = "BEST FILMS"
        
        static let spacing = CGFloat(0)
        static let fractionalWidthItem = CGFloat(0.5)
        static let fractionalHeightItem = CGFloat(1.0)
        
        static let fractionalWidthGroup = CGFloat(0.85)
        static let heightGroup = CGFloat(300)
        
        static let fractionalWidthHeader = CGFloat(1.0)
        static let heightHeader = CGFloat(44)
        
        static let mainBackgroundColor: UIColor = .black
        
        static var identifierOffset = 0
        static let itemsPerSection = 4
        
        static let errorMessage = "unknown section kind"
    }
    
    private enum SetCellContent: Int, CaseIterable {
        case movies, cartoons, TVShows
        func manageCell() -> MyCell {
            switch self {
            case .movies:
                return MyCell(poster: moviesDataCell.posterMovies, name: moviesDataCell.nameMovies)
            case .cartoons:
                return MyCell(poster: cartoonsDataCell.posterCartoons, name: cartoonsDataCell.nameCartoons)
            case .TVShows:
                return MyCell(poster: TVShowsDataCell.posterShows, name: TVShowsDataCell.nameShows)
            }
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
        self.navigationItem.title = constants.navItem
    }
}

//MARK: - UICollectionViewLayout

extension FirstViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = constants.spacing
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(constants.fractionalWidthItem), heightDimension: .fractionalHeight(constants.fractionalHeightItem)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: constants.spacing, leading: constants.spacing, bottom: constants.spacing, trailing: constants.spacing)
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(constants.fractionalWidthGroup),
                                                   heightDimension: .absolute(constants.heightGroup)),
                subitems: [leadingItem])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(constants.fractionalWidthHeader),
                                                   heightDimension: .estimated(constants.heightHeader)),
                elementKind: FirstViewController.constants.headerElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
            
        }, configuration: config)
        return layout
    }
}

//MARK: - UICollectionViewDataSource

extension FirstViewController {
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = constants.mainBackgroundColor
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { (cell, indexPath, identifier) in
            guard let sectionKind = SetCellContent(rawValue: indexPath.section) else {
                return print(constants.errorMessage)
            }
            
            let myCell = sectionKind.manageCell()
            cell.label.text = myCell.name[indexPath.row]
            cell.posterView.image = UIImage(named: myCell.poster[indexPath.row])
            cell.contentView.backgroundColor = constants.mainBackgroundColor
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.row)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: FirstViewController.constants.headerElementKind) {
            (supplementaryView, string, indexPath) in
            let sectionKind = SetCellContent(rawValue: indexPath.section)!
            supplementaryView.label.text = String(describing: sectionKind)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        
        SetCellContent.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
            let maxIdentifier = constants.identifierOffset + constants.itemsPerSection
            snapshot.appendItems(Array(constants.identifierOffset..<maxIdentifier))
            constants.identifierOffset += constants.itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let secondVC = SecondViewController()
        guard let sectionKind = SetCellContent(rawValue: indexPath.section) else {
            return print(constants.errorMessage)
        }
        
        let myCell = sectionKind.manageCell()
        secondVC.imageView.image = UIImage(named: myCell.poster[indexPath.row])
        secondVC.navigationItem.title = myCell.name[indexPath.row]
        navigationController?.pushViewController(secondVC, animated: true)
    }
}


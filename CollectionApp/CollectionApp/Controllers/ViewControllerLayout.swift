//
//  ViewControllerLayout.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class FirstViewController: UIViewController {
    
    private enum Constants {
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
    
    }
    
    private enum SectionContent: Int, CaseIterable {
        case movies, cartoons, TVShows
        func setFilmDataCell() -> Film {
            switch self {
            case .movies:
                return Film(poster: MoviesDataCell.posterMovies, name: MoviesDataCell.nameMovies)
            case .cartoons:
                return Film(poster: CartoonsDataCell.posterCartoons, name: CartoonsDataCell.nameCartoons)
            case .TVShows:
                return Film(poster: TVShowsDataCell.posterShows, name: TVShowsDataCell.nameShows)
            }
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
        self.navigationItem.title = Constants.navItem
    }
}

//MARK: - UICollectionViewLayout

extension FirstViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Constants.spacing
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.fractionalWidthItem), heightDimension: .fractionalHeight(Constants.fractionalHeightItem)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: Constants.spacing, leading: Constants.spacing, bottom: Constants.spacing, trailing: Constants.spacing)
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionalWidthGroup),
                                                   heightDimension: .absolute(Constants.heightGroup)),
                subitems: [leadingItem])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.fractionalWidthHeader),
                                                   heightDimension: .estimated(Constants.heightHeader)),
                elementKind: FirstViewController.Constants.headerElementKind,
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
        collectionView.backgroundColor = Constants.mainBackgroundColor
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { (cell, indexPath, identifier) in
            guard let sectionKind = SectionContent(rawValue: indexPath.section) else { return }
            
            let myCell = sectionKind.setFilmDataCell()
            cell.label.text = myCell.name[indexPath.row]
            cell.posterView.image = UIImage(named: myCell.poster[indexPath.row])
            cell.contentView.backgroundColor = Constants.mainBackgroundColor
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.row)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: FirstViewController.Constants.headerElementKind) {
            (supplementaryView, string, indexPath) in
            let sectionKind = SectionContent(rawValue: indexPath.section)!
            supplementaryView.label.text = String(describing: sectionKind)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        
        SectionContent.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
            let maxIdentifier = Constants.identifierOffset + Constants.itemsPerSection
            snapshot.appendItems(Array(Constants.identifierOffset..<maxIdentifier))
            Constants.identifierOffset += Constants.itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let secondVC = SecondViewController()
        guard let sectionKind = SectionContent(rawValue: indexPath.section) else { return }
        
        let myCell = sectionKind.setFilmDataCell()
        secondVC.imageView.image = UIImage(named: myCell.poster[indexPath.row])
        secondVC.navigationItem.title = myCell.name[indexPath.row]
        navigationController?.pushViewController(secondVC, animated: true)
    }
}


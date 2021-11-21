//
//  ViewControllerLayout.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class FirstViewController: UIViewController {
    
    private enum CellIdentifier {
        static let reuseIdentifier = "cell"
    }
    
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
    
    private var sections = Section.allSections
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Film>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Film>
    
    private lazy var dataSource = makeDataSource()
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        
        applySnapshot(animatingDifferences: false)
        self.navigationItem.title = Constants.navItem
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.reuseIdentifier)
        
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
    
    func makeDataSource() -> DataSource {
        
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { (cell, indexPath, film) in
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let film = section.films[indexPath.row]
            
            cell.label.text = film.name
            cell.posterView.image = UIImage(named: film.poster)
            cell.contentView.backgroundColor = Constants.mainBackgroundColor
            
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, film: Film) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.row)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: FirstViewController.Constants.headerElementKind) {
            (supplementaryView, string, indexPath) in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.label.text = section.title
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
            snapshot.appendItems(section.films, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

//MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let secondVC = SecondViewController()
        let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let film = section.films[indexPath.row]
        
        
        secondVC.imageView.image = UIImage(named: film.poster)
        secondVC.navigationItem.title = film.name
        navigationController?.pushViewController(secondVC, animated: true)
    }
}


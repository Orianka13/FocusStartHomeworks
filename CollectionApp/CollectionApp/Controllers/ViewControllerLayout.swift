//
//  ViewControllerLayout.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class OrthogonalScrollBehaviorViewController: UIViewController {
    static let headerElementKind = "header-element-kind"
    
    enum SetCellContent: Int, CaseIterable {
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
        navigationItem.title = "Best films"
    }
}

//MARK: - UICollectionViewLayout

extension OrthogonalScrollBehaviorViewController {
    
    func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
            
            let orthogonallyScrolls = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous != .none
            let containerGroupFractionalWidth = orthogonallyScrolls ? CGFloat(0.85) : CGFloat(1.0)
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionalWidth),
                                                   heightDimension: .absolute(280)),
                subitems: [leadingItem])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(44)),
                elementKind: OrthogonalScrollBehaviorViewController.headerElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
            
        }, configuration: config)
        return layout
    }
}

//MARK: - UICollectionViewDataSource

extension OrthogonalScrollBehaviorViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .red
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { (cell, indexPath, identifier) in
            guard let sectionKind = SetCellContent(rawValue: indexPath.section) else {
                return print("unknown section kind")
            }
            let myCell = sectionKind.manageCell()
            cell.label.text = myCell.name[indexPath.row]
            cell.posterView.image = UIImage(named: myCell.poster[indexPath.row])
            cell.contentView.backgroundColor = .blue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 4
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: 1)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: OrthogonalScrollBehaviorViewController.headerElementKind) {
            (supplementaryView, string, indexPath) in
            let sectionKind = SetCellContent(rawValue: indexPath.section)!
            supplementaryView.label.text = String(describing: sectionKind)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 4
        SetCellContent.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - UICollectionViewDelegate

extension OrthogonalScrollBehaviorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondVC = SecondViewController()
        guard let sectionKind = SetCellContent(rawValue: indexPath.section) else {
            return print("unknown section kind")
        }
        let myCell = sectionKind.manageCell()
        secondVC.imageView.image = UIImage(named: myCell.poster[indexPath.row])
        secondVC.navigationItem.title = myCell.name[indexPath.row]
        navigationController?.pushViewController(secondVC, animated: true)
    }
}


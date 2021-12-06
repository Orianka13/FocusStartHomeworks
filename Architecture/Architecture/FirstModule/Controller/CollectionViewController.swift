//
//  ViewControllerLayout.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class CollectionViewController: UIViewController {
    
    private enum Constants {
        static let headerElementKind = "header-element-kind"
        static let navItem = "BEST FILMS"
        static let filmName = "Deadpool"
        static let defaultSectionTitle = "movies"
        
        static let mainBackgroundColor: UIColor = .black
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Film>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Film>
    
    private lazy var dataSource = makeDataSource()
    private let sections = Section.allSections
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHierarchy()
        self.applySnapshot(animatingDifferences: false)
        self.navigationItem.title = Constants.navItem
    }
}

//MARK: - UICollectionViewDataSource

extension CollectionViewController {
    
    private func configureHierarchy() {
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.backgroundColor = Constants.mainBackgroundColor
        view.addSubview(self.collectionView)
        self.collectionView.delegate = self
    }
    
    private func makeDataSource() -> DataSource {
        
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { [weak self] (cell, indexPath, film) in
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let film = section?.films[indexPath.row]
            let viewModel = ViewFilm(poster: film?.poster ?? Constants.filmName, name: film?.name ?? Constants.filmName)
            cell.updateCellData(film: viewModel)
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, film: Film) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.row)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: CollectionViewController.Constants.headerElementKind) { [weak self]
            (supplementaryView, string, indexPath) in
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let viewModel = ViewSection(title: section?.title ?? Constants.defaultSectionTitle, films: [ViewFilm(poster: Constants.filmName, name: Constants.filmName)])
            supplementaryView.updateLabel(section: viewModel)
        }
        
        self.dataSource.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        return self.dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(self.sections)
        
        self.sections.forEach { section in
            snapshot.appendItems(section.films, toSection: section)
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

//MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let film = section.films[indexPath.row]
        
        let controller = Assembly.build(film: film)
       
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}


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
        static let filmName = "Deadpool"
        static let defaultSectionTitle = "movies"
        
        static let mainBackgroundColor: UIColor = .black
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Film>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Film>
    
    private lazy var dataSource = makeDataSource()
    private var sections = Section.allSections
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        
        applySnapshot(animatingDifferences: false)
        self.navigationItem.title = Constants.navItem
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
        
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { [weak self] (cell, indexPath, film) in
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let film = section?.films[indexPath.row]
            
            cell.updateCellData(film: film ?? Film(poster: Constants.filmName, name: Constants.filmName))
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, film: Film) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.row)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: FirstViewController.Constants.headerElementKind) { [weak self]
            (supplementaryView, string, indexPath) in
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            supplementaryView.updateLabel(section: section ?? Section(title: Constants.defaultSectionTitle, films: [Film(poster: Constants.filmName, name: Constants.filmName)]))
        }
        
        dataSource.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(
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
        
        secondVC.setImageData(film: film)
    
        navigationController?.pushViewController(secondVC, animated: true)
    }
}


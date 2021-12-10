//
//  ViewControllerLayout.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class CollectionViewController: UIViewController {
    
    private enum Literal {
        static let headerElementKind = "header-element-kind"
        static let navItem = "BEST FILMS"
        static let filmName = "Deadpool"
        static let defaultSectionTitle = "movies"
    }
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .black
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Film>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Film>
    
    private lazy var dataSource = updateDataSource()
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHierarchy()
        self.applySnapshot(animatingDifferences: false)
        self.navigationItem.title = Literal.navItem
    }
}

//MARK: - UICollectionViewDataSource

private extension CollectionViewController {
    
    func configureHierarchy() {
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewLayout.createLayout())
        self.collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView?.backgroundColor = Colors.mainBackgroundColor
        guard let collectionView = self.collectionView else { return }
        view.addSubview(collectionView)
        self.collectionView?.delegate = self
    }
    
    func updateDataSource() -> DataSource {
        
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, Int> { [weak self] (cell, indexPath, film) in
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let film = section?.films[indexPath.row]
            cell.updateCellData(film: film ?? Film(poster: film?.poster ?? Literal.filmName, name: film?.name ?? Literal.filmName))
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: self.collectionView ?? UICollectionView()) {
            (collectionView, indexPath, film) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.row)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: CollectionViewController.Literal.headerElementKind) { [weak self]
            (supplementaryView, string, indexPath) in
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.updateLabel(section: section ?? Section(title: section?.title ?? Literal.defaultSectionTitle, films: [Film(poster: Literal.filmName, name: Literal.filmName)]))
        }
        
        self.dataSource.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView?.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        return self.dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        let sections = Section.allSections()
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
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
        
        let controller = createNewModule(film: film)
       
        self.pushVC(controller: controller)
        
    }
}

//MARK: Private extension
private extension CollectionViewController {
    
    func createNewModule(film: Film) -> UIViewController {
        return Assembly.build(film: film)
    }
    
    func pushVC(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


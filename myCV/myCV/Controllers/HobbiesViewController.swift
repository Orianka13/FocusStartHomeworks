//
//  HobbiesViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

class HobbiesViewController: UIViewController{
    var hobbies = Hobbies()
    var photoCollectionView = PhotoCollectionView()
    
    private lazy var titleLabel: UILabel = {
         let text = hobbies.label
         let textLabel = UILabel(frame: .zero)
         textLabel.text = text
         textLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 30)
         textLabel.textColor = .black
         textLabel.numberOfLines = 0
         return textLabel
     }()
    
    lazy var photoView: UIImageView = {
        let image = UIImage(named: hobbies.imageGallery.first ?? "knit")
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var textView: UILabel = {
        let text = hobbies.text.first
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
    }
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(photoView)
        view.addSubview(textView)
        view.addSubview(photoCollectionView)
    }
    private func setConstraints(){
        setTitle()
        setPhotoView()
        setTextView()
        setCollectionView()
    }
    
    private func setTitle(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / 15).isActive = true
    }
    
    private func setPhotoView(){
        self.photoView.translatesAutoresizingMaskIntoConstraints = false
        self.photoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = false
        self.photoView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.photoView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 2.5).isActive = true
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.photoView.bottomAnchor, constant: 10).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.textView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 8).isActive = true
    }
    
    private func setCollectionView(){
        self.photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        self.photoCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func updateViews(indexPath: IndexPath){
        let item = indexPath.row
        print("Выбрали картинку под индексом: \(item)")
        self.photoView.image = UIImage(named: hobbies.imageGallery[item])
        self.textView.text = hobbies.text[item]
    }
}

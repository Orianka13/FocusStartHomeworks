//
//  DetailView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit

final class DetailView: UIView {
    
    var onTouchedButtonHandler: (() -> Void)?
    
    let tableView = DetailTableView()
    
    private lazy var image: UIImageView = {
        let image = UIImage(named: "audiSedan")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.text = "Цена"
        return label
    }()
    
    private lazy var priceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "2 346 372 $"
        return label
    }()
    
    private lazy var bodyTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.text = "Выберите тип кузова"
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Рассчитать цену", for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInadicator = UIActivityIndicatorView()
        activityInadicator.isHidden = true
        return activityInadicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.image)
        self.addSubview(self.priceLabel)
        self.addSubview(self.priceCountLabel)
        self.addSubview(self.bodyTypeLabel)
        self.addSubview(self.tableView)
        self.addSubview(self.button)
        
        self.priceCountLabel.addSubview(self.activityIndicator)
    }
    
    private func setConstraint(){
        self.setImage()
        self.setPriceLabel()
        self.setPriceCountLabel()
        self.setBodyTypeLabel()
        self.setTableView()
        self.setButton()
        self.setActivityIndicator()
    }
    
    func setContent(image: String, price: String){
        self.image.image = UIImage(named: image)
        self.priceCountLabel.text = price
    }
    
    @objc private func touchedButton() {
        self.onTouchedButtonHandler?()
    }
    
    func updateView(image: String) {
        self.image.image = UIImage(named: image)
        self.priceCountLabel.text = "- --- --- $"
    }
    
    func updatePrice(price: String) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.priceCountLabel.text = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.priceCountLabel.text = price
        })
    }
}
//MARK: - TitleViewLayout

extension DetailView {
    private func setImage() {
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
        self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: self.frame.size.height / 3 ).isActive = true
    }
    
    private func setPriceLabel() {
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 23).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setPriceCountLabel(){
        self.priceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceCountLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 8).isActive = true
        self.priceCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.priceCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setBodyTypeLabel(){
        self.bodyTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bodyTypeLabel.topAnchor.constraint(equalTo: self.priceCountLabel.bottomAnchor, constant: 23).isActive = true
        self.bodyTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.bodyTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setTableView(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.bodyTypeLabel.bottomAnchor, constant: 18).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 5).isActive = true
    }
    
    private func setButton() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -95).isActive = false
        self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setActivityIndicator() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.priceCountLabel.centerXAnchor).isActive = false
        self.activityIndicator.leadingAnchor.constraint(equalTo: self.priceCountLabel.leadingAnchor, constant: 20).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalTo: self.priceCountLabel.heightAnchor).isActive = true
    }
}

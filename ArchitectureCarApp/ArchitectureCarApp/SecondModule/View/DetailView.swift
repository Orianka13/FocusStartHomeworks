//
//  DetailView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit

protocol IDetailView {
    func setContent(image: String, price: String)
    func updateView(image: String)
    func updatePrice(price: String)
    var onTouchedButtonHandler: (() -> Void)? { get set }
    func getTableView() -> DetailTableView
}

final class DetailView: UIView {
    
    private enum Colors {
        static let buttonColor: UIColor = .systemGreen
        static let buttonTextColor: UIColor = .white
    }
    
    private enum Literal {
        static let priceLabelText = "Цена"
        static let bodyTypeLabelText = "Выберите тип кузова"
        static let buttonTitle = "Рассчитать цену"
        static let priceCountLabelText = "- --- --- $"
        static let noText = ""
    }
    
    private enum Fonts {
        static let priceLabelFont = UIFont.systemFont(ofSize: 24, weight: .medium)
        static let priceCountLabelFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let bodyTypeLabelFont = UIFont.systemFont(ofSize: 24, weight: .medium)
        static let buttonFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    private enum Metrics {
        static let buttonCornerRadius = CGFloat(25)
        static let zeroSpacing = CGFloat(0)
        static let imageHeight = CGFloat(3)
        static let topPriceLabelSpacing = CGFloat(23)
        static let topPriceCountLabelSpacing = CGFloat(8)
        static let topBodyTypeLabelSpacing = CGFloat(23)
        static let topTableViewSpacing = CGFloat(18)
        static let heightTableView = CGFloat(5)
        static let topButtonSpacing = CGFloat(20)
        static let bottomButtonSpacing = CGFloat(95)
        static let heightButton = CGFloat(51)
        static let leadingActivityIndicatorSpacing = CGFloat(20)
    }
    
    var onTouchedButtonHandler: (() -> Void)?
    
    private var tableView = DetailTableView()
    
    private lazy var image: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.priceLabelFont
        label.text = Literal.priceLabelText
        return label
    }()
    
    private lazy var priceCountLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.priceCountLabelFont
        return label
    }()
    
    private lazy var bodyTypeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bodyTypeLabelFont
        label.text = Literal.bodyTypeLabelText
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.buttonColor
        button.setTitle(Literal.buttonTitle, for: .normal)
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.titleLabel?.textColor = Colors.buttonTextColor
        button.titleLabel?.font = Fonts.buttonFont
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
        fatalError()
    }
}

//MARK: Private extension

private extension DetailView {
    
    func addView(){
        self.addSubview(image)
        self.addSubview(priceLabel)
        self.addSubview(priceCountLabel)
        self.addSubview(bodyTypeLabel)
        self.addSubview(tableView)
        self.addSubview(button)
        
        self.priceCountLabel.addSubview(activityIndicator)
        
    }
    
    @objc func touchedButton() {
        self.onTouchedButtonHandler?()
    }
}

//MARK: IDetailView
extension DetailView: IDetailView {
    
    func getTableView() -> DetailTableView {
        return self.tableView
    }
    
    func setContent(image: String, price: String) {
        self.image.image = UIImage(named: image)
        self.priceCountLabel.text = price
    }
    
    func updateView(image: String) {
        self.image.image = UIImage(named: image)
        self.priceCountLabel.text = Literal.priceCountLabelText
    }
    
    func updatePrice(price: String) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.priceCountLabel.text = Literal.noText
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.priceCountLabel.text = price
        })
    }
}

//MARK: TitleViewLayout

private extension DetailView {
    
    func setConstraint(){
        self.makeImageConstraints()
        self.makePriceLabelConstraints()
        self.makePriceCountLabelConstraints()
        self.makeBodyTypeLabelConstraints()
        self.makeTableViewConstraints()
        self.makeButtonConstraints()
        self.makeActivityIndicatorConstraints()
    }
    
    func makeImageConstraints() {
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
        self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.imageHeight ).isActive = true
    }
    
    func makePriceLabelConstraints() {
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: Metrics.topPriceLabelSpacing).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
    
    func makePriceCountLabelConstraints(){
        self.priceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceCountLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: Metrics.topPriceCountLabelSpacing).isActive = true
        self.priceCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.priceCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
    
    func makeBodyTypeLabelConstraints(){
        self.bodyTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bodyTypeLabel.topAnchor.constraint(equalTo: self.priceCountLabel.bottomAnchor, constant: Metrics.topBodyTypeLabelSpacing).isActive = true
        self.bodyTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.bodyTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
    
    func makeTableViewConstraints(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.bodyTypeLabel.bottomAnchor, constant: Metrics.topTableViewSpacing).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.heightTableView).isActive = true
    }
    
    func makeButtonConstraints() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: Metrics.topButtonSpacing).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.bottomButtonSpacing).isActive = false
        self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: Metrics.heightButton).isActive = true
    }
    
    func makeActivityIndicatorConstraints() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.priceCountLabel.centerXAnchor).isActive = false
        self.activityIndicator.leadingAnchor.constraint(equalTo: self.priceCountLabel.leadingAnchor, constant: Metrics.leadingActivityIndicatorSpacing).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalTo: self.priceCountLabel.heightAnchor).isActive = true
    }
}

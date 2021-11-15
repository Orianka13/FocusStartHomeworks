//
//  ExperienceViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

final class ExperienceViewController: UIViewController {
    
    private let experience = Experience()
    
    private enum TextSettings {
        static let mainTextColor = UIColor(ciColor: .white)
        static let numberOfLines = 0
    }
    private enum Fonts {
        static let titleFont = UIFont(name: "ChalkboardSE-Regular", size: 30)
        static let mainTextFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
    }
    private enum MainColor {
        static let mainBackgroundColor: UIColor = UIColor(red: 87/255, green: 64/255, blue: 67/255, alpha: 1)
    }
    private enum Metrics {
        static let titleHight = CGFloat(15)
        static let defaultSpacing = CGFloat(20)
        static let trailingSpacing = CGFloat(-20)
    }
    
    private lazy var titleLabel: UILabel = {
        let text = experience.label
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = Fonts.titleFont
        textLabel.textColor = TextSettings.mainTextColor
        textLabel.numberOfLines = TextSettings.numberOfLines
        return textLabel
    }()
    
    private lazy var textView: UILabel = {
        let text = experience.text
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = Fonts.mainTextFont
        textLabel.textColor = TextSettings.mainTextColor
        textLabel.numberOfLines = TextSettings.numberOfLines
        return textLabel
    }()
    
    private lazy var switcher: UISwitch = {
        let switcher = UISwitch(frame: .zero)
        switcher.onTintColor = TextSettings.mainTextColor
        switcher.addTarget(self, action: #selector(hidePSText), for: .touchUpInside)
        return switcher
    }()
    
    private lazy var psTextView: UILabel = {
        let text = experience.psText
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = Fonts.mainTextFont
        textLabel.textColor = TextSettings.mainTextColor
        textLabel.numberOfLines = TextSettings.numberOfLines
        textLabel.isHidden = true
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        view.backgroundColor = MainColor.mainBackgroundColor
    }
    
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(switcher)
        view.addSubview(psTextView)
    }
    private func setConstraints(){
        setTitle()
        setTextView()
        setSwitcher()
        setPSTextView()
    }
    
    @objc private func hidePSText(){
        psTextView.isHidden = !psTextView.isHidden
    }
    
    private func setTitle(){
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / Metrics.titleHight).isActive = true
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Metrics.trailingSpacing).isActive = true
    }
    
    private func setSwitcher(){
        self.switcher.translatesAutoresizingMaskIntoConstraints = false
        self.switcher.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.switcher.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metrics.defaultSpacing).isActive = true
    }
    
    private func setPSTextView(){
        self.psTextView.translatesAutoresizingMaskIntoConstraints = false
        self.psTextView.topAnchor.constraint(equalTo: self.switcher.bottomAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.psTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metrics.defaultSpacing).isActive = true
        self.psTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Metrics.trailingSpacing).isActive = true
    }
    
}

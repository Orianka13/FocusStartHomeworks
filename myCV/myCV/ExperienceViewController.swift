//
//  ExperienceViewController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

class ExperienceViewController: UIViewController {
    
    let experience = Experience()
    
   private lazy var titleLabel: UILabel = {
        let text = experience.label
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 30)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    private lazy var textView: UILabel = {
        let text = experience.text
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    private lazy var switcher: UISwitch = {
        let switcher = UISwitch(frame: .zero)
        switcher.tintColor = .brown
        switcher.addTarget(self, action: #selector(hidePSText), for: .touchUpInside)
        return switcher
    }()
    
    private lazy var psTextView: UILabel = {
        let text = experience.psText
        let textLabel = UILabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.isHidden = true
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
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
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.size.height / 15).isActive = true
    }
    
    private func setTextView(){
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
    }
    
    private func setSwitcher(){
        self.switcher.translatesAutoresizingMaskIntoConstraints = false
        self.switcher.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 20).isActive = true
        self.switcher.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
    }
    
    private func setPSTextView(){
        self.psTextView.translatesAutoresizingMaskIntoConstraints = false
        self.psTextView.topAnchor.constraint(equalTo: self.switcher.bottomAnchor, constant: 20).isActive = true
        self.psTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        self.psTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
    }

}

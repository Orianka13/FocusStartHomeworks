//
//  PickerViewManager.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import Foundation

import UIKit

extension InfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return info.button.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return info.button[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedPoint = info.button[row]
        self.showMoreTF.text = selectedPoint
        self.photoView.image = UIImage(named: info.photoImage[row])
        self.textView.text = info.text[row]
    }
    
    func choicePoint() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        self.showMoreTF.inputView = elementPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: info.button[row], attributes: [NSAttributedString.Key.foregroundColor: mainBackgroundColor])
        return attributedString
    }
}

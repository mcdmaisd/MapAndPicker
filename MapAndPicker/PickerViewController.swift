//
//  ViewController.swift
//  MapAndPicker
//
//  Created by ilim on 2025-01-08.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var totalCountLabel: UILabel!
    @IBOutlet private var resultTextView: UITextView!
    
    private let list = Array(Constants.range)
    private let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        configureUI()
    }
    
    private func configureUI() {
        textField.inputView = pickerView
        resultTextView.isEditable = false
        resultTextView.textColor = .lightGray
        totalCountLabel.font = .boldSystemFont(ofSize: 30)
        totalCountLabel.numberOfLines = 0
    }
    
    private func convertNumberToClap(_ str: String) -> (String, Int) {
        var words: [Character] = []
        var counts = 0
        
        for char in str {
            if Constants.syg.contains(String(char)) {
                counts += 1
                words.append(Character(Constants.clap))
            } else {
                words.append(char)
            }
        }
        
        return (String(words), counts)
    }
    
    private func getResultOf369(_ row: Int) {
        let maxNumber = list.count - row
        let stringList = Array(1...maxNumber).map { String($0) }
        var resultList: [String] = []
        var totalCount = 0
        
        for str in stringList {
            let result = convertNumberToClap(str)
            resultList.append(result.0)
            totalCount += result.1
        }
        
        let string = resultList.joined(separator: Constants.separator)
        
        totalCountLabel.text = "\(maxNumber)까지 총 박수는 \(totalCount)번 입니다."
        resultTextView.text = string
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        list.reversed().map { String($0) }[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getResultOf369(row)
    }
}

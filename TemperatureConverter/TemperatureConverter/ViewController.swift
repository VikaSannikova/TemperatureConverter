//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by user on 16.03.2021.
//

import UIKit



class ViewController: UIViewController {
    enum Types {
        case Celsium,Kelvin,Forengeit
    }
    let types_array = ["Celsius", "Kelvin", "Fahrenheit"]
   
    @IBOutlet weak var input_textfield: UITextField!
    @IBOutlet weak var result_label: UILabel!
    @IBOutlet weak var picker_view: UIPickerView!
    

    @IBAction func editInputTextView(_ sender: Any) {
        calculate(textField: input_textfield, pickerView: picker_view, label: result_label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_view.dataSource = self
        picker_view.delegate = self
    }
    
    func calculate (textField: UITextField, pickerView: UIPickerView, label: UILabel) {
        if let textInput = textField.text {
            if textInput.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                let number = textInput.toDouble()!
                let from = types_array[Int(pickerView.selectedRow(inComponent: 0).description) ?? 0]
                let to = types_array[Int(pickerView.selectedRow(inComponent: 1).description) ?? 0]
                label.text = String(format: "%f", castTemperature(what: number, from: from, to: to))
            } else {
                label.text = "Result"
            }
        } else {
            print("textfield is nil")
        }
    }
}

extension ViewController:UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types_array.count
    }
}


func castTemperature(what:Double, from:String, to:String) -> Double {
    switch from {
    case "Celsius":
        switch to {
        case "Celsius":
            return what
        case "Kelvin":
            return what + 273.15
        case "Fahrenheit":
            return what * 9 / 5 + 32
        default:
            return what
        }
    case "Kelvin":
        switch to {
        case "Celsius":
            return what - 273.15
        case "Kelvin":
            return what
        case "Fahrenheit":
            return what * 9 / 5 - 459.67
        default:
            return what
        }
    case "Fahrenheit":
        switch to {
        case "Celsius":
            return (what - 32) * 5 / 9
        case "Kelvin":
            return (what + 459.67) * 5 / 9
        case "Fahrenheit":
            return what
        default:
            return what
        }
    default:
        return what
    }
}



extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types_array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        calculate(textField: input_textfield, pickerView: pickerView, label: result_label)
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

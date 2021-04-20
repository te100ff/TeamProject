//
//  ViewController.swift
//  TeamProject
//
//  Created by Stanislav Testov on 16.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = okButton.frame.height/2
        
    }


    
    }

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        }
    
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var doneButton = UIBarButtonItem()
        
        switch textField {
        case nameTF, surnameTF:
            doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: textField,
                action: #selector(resignFirstResponder)
            )
        default:
            textField.inputView = datePicker
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.locale = .current
            
            doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: nil,
                action: #selector(doneDatePressed(_:))
            )
        }
        
        toolBar.items = [space, doneButton]
        
        textField.inputAccessoryView = toolBar
        
        
    }
    
    
//    @objc func clearPressed() {
//        nameTF.text = ""
//        view.endEditing(true)
//    }
    
    
    
    @objc func doneDatePressed(_ sender: UIBarButtonItem) {
        let formater = DateFormatter()
        formater.dateStyle = .long
        formater.timeStyle = .none

        birthdayTF.text = formater.string(from: datePicker.date)
        view.endEditing(true)
    }

}


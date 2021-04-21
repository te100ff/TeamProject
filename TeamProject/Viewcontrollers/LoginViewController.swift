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
        okButton.alpha = 0.3
    }
    //подготовка сегвея
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let greetingVC = segue.destination as! UITabBarController
        
        guard let viewControlers = greetingVC.viewControllers else { return }
        
        for viewController in viewControlers {
            if let welcomeVC = viewController as? WelcomeViewController {
                //
            } else if let aboutVC = viewController as? AboutViewController {
                //
            } else if let zodiacVC = viewController as? ZodiacViewController {
                //
            }  else if let navigationVC = viewController as? UINavigationController {
                let friendsVC = navigationVC.topViewController as! BioViewController
                //
            }
        }
    }
    */
    
    @IBAction func okButtonPressed() {
        okPressed(textFields: nameTF, surnameTF, birthdayTF)
    }
    
    
    
}

extension LoginViewController: UITextFieldDelegate  {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        textFieldSetup(textField: textField)
        
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
            datePicker.locale = Locale(identifier: "ru_RU")
            
            doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: nil,
                action: #selector(doneDatePressed)
            )
        }
        
        toolBar.items = [space, doneButton]
        
        textField.inputAccessoryView = toolBar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.shadowOpacity = 0
        okButtonChange(textFields: nameTF, surnameTF, birthdayTF)
    }

    
    @objc func doneDatePressed() {
        let formater = DateFormatter()
        formater.dateStyle = .long
        formater.timeStyle = .none
        formater.locale = Locale(identifier: "ru_RU")
        formater.setLocalizedDateFormatFromTemplate("MMMM d y")
        
        birthdayTF.text = formater.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    private func textFieldSetup(textField: UITextField) {
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = .zero
       textField.layer.shadowRadius = 10
        textField.layer.shadowColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    
    private func okPressed(textFields: UITextField... ) {
        textFields.forEach { textField in
            guard let text = textField.text, !text.isEmpty else {
                showAlert(title: "Внимание", message: "Заполните все поля", textField: textField)
                return
            }
            
        }
    }
    
    private func okButtonChange(textFields: UITextField... ) {
        for textField in textFields {
            guard let text = textField.text, !text.isEmpty else { return }
            continue
        }
            okButton.layer.shadowOpacity = 1
            okButton.layer.shadowOffset = .zero
            okButton.layer.shadowRadius = 10
            okButton.layer.shadowColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            okButton.alpha = 1
    }
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}


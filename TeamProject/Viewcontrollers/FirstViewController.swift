//
//  ViewController.swift
//  TeamProject
//
//  Created by Stanislav Testov on 16.04.2021.
//

import UIKit

class FirstViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    @IBOutlet var labels: [UILabel]!
    
    // MARK: - Private properties
    private let datePicker = UIDatePicker()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = okButton.frame.height/2
        okButton.alpha = 0.3
        assignbackground()
        labelsSetup()
    }
    
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let greetingVC = segue.destination as! UITabBarController
     
     guard let viewControlers = greetingVC.viewControllers else { return }
     
     for viewController in viewControlers {
     if let welcomeVC = viewController as? UIViewController {
     //
     } else if let aboutVC = viewController as? UIViewController {
     //
     } else if let zodiacVC = viewController as? UIViewController {
     //
     }  else if let navigationVC = viewController as? UINavigationController {
     let friendsVC = navigationVC.topViewController as! UITableViewController
     //
     }
     }
     }
    
    // MARK: - IB Actions
    @IBAction func okButtonPressed() {
        okPressed(textFields: nameTF, surnameTF, birthdayTF)
    }
    
    // MARK: - Private methods (button pressed)
    private func okPressed(textFields: UITextField... ) {
        textFields.forEach { textField in
            guard let text = textField.text, !text.isEmpty else {
                showAlert(title: "Внимание", message: "Заполните все поля")
                return
            }
        }
    }
    
    
}

// MARK: - Textfields and keyboards setup
extension FirstViewController: UITextFieldDelegate  {
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
    
}

// MARK: - Graphics and effects setup
extension FirstViewController {
    private func okButtonChange(textFields: UITextField... ) {
        for textField in textFields {
            guard let text = textField.text, !text.isEmpty else { return }
            continue
        }
        okButton.layer.shadowOpacity = 1
        okButton.layer.shadowOffset = .zero
        okButton.layer.shadowRadius = 20
        okButton.layer.shadowColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        okButton.alpha = 1
    }
    
    func assignbackground(){
        let background = UIImage(named: "stars")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func labelsSetup() {
        for label in labels {
            label.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.layer.shadowOpacity = 1
            label.layer.shadowRadius = 15
            label.layer.shadowOffset = .zero
        }
    }
    
    private func textFieldSetup(textField: UITextField) {
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = .zero
        textField.layer.shadowRadius = 10
        textField.layer.shadowColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    
    // MARK: - Allert setup
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    
    
}


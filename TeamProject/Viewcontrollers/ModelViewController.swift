//
//  ModelViewController.swift
//  TeamProject
//
//  Created by Виталий Оранский on 21.04.2021.
//

import UIKit

class ModelViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var zodiacLabel: UILabel!
    @IBOutlet weak var zodiacImageView: UIImageView!
    @IBOutlet weak var zodiacDiscription: UILabel!
    
    
    
    var person: Person!
    var testText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = person.name
        lastNameLabel.text = person.lastName
        dateLabel.text = person.dayOfBirth
        zodiacLabel.text = person.zodiac.rawValue
        zodiacDiscription.text = person.zodiacDiscription

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  BasicExample
//
//  Created by Filip Stefansson on 2020-10-09.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add AutocompleteField to main view
        let textfield = AutocompleteField(frame: CGRect(x: 20, y: 100, width: self.view.bounds.width - 40, height: 40))

        textfield.font = UIFont(name: "Courier", size: 20)
        textfield.defaultTextAttributes.updateValue(5, forKey: .kern)

        textfield.placeholder = "Start typing George..."

        // add suggestions to textfield
        textfield.suggestions = [
            "George Washington",
            "Thomas Jefferson",
            "John Adams",
            "Theodore Roosevelt",
            "John F. Kennedy",
            "George W. Bush",
        ]

        // set delegate and add to view
        textfield.delegate = self
        self.view.addSubview(textfield)
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        // fill out the rest when user hits return
        let textField = tf as! AutocompleteField
        textField.text = textField.suggestion
        textField.resignFirstResponder()

        return true
    }
}


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
        
        self.addNameFieldExample()
        self.addEmailFieldExample()
    }
    
    /// Example  showing a field with a custom font and borderStyle
    private func addNameFieldExample() {
        // add AutocompleteField to main view
        let textfield = AutocompleteField(frame: CGRect(x: 20, y: 100, width: self.view.bounds.width - 40, height: 50))

        textfield.font = UIFont(name: "American Typewriter", size: 20)
        textfield.placeholder = "Name"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no

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
    
    /// Example showing how the delimiter option can be used for emails
    private func addEmailFieldExample() {
        // add AutocompleteField to main view
        let textfield = AutocompleteField(frame: CGRect(x: 20, y: 160, width: self.view.bounds.width - 40, height: 50))

        textfield.font = UIFont(name: "American Typewriter", size: 20)
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .emailAddress
        textfield.autocapitalizationType = .none
        
        // adda delimiter so we only show suggestions after the @ character
        textfield.delimiter = "@"

        // add email providers as suggestions
        textfield.suggestions = [
            "gmail.com",
            "icloud.com",
            "outlook.com",
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


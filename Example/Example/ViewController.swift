//
//  ViewController.swift
//  Example
//
//  Created by Filip Stefansson on 05/11/15.
//  Copyright © 2015 Filip Stefansson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITextFieldDelegate {
    
    // the fields
    @IBOutlet weak var basicField: AutocompleteField!
    @IBOutlet weak var customField: AutocompleteField!
    @IBOutlet weak var emailField: AutocompleteField!
    
    // the content view for code example
    @IBOutlet weak var codeView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set delegates
        basicField.delegate  = self
        customField.delegate = self
        emailField.delegate  = self
        
        // autocomplete suggestions
        let suggestions = ["Abraham Lincoln", "John Doe", "John Smith", "Awesome"]
        basicField.suggestions = suggestions
        customField.suggestions = suggestions
        
        // change event for email field
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.emailChanged(_:)),
            name: NSNotification.Name.UITextFieldTextDidChange,
            object: emailField)
        
        
        // add code example
        let textField = AutocompleteField(frame: CGRect(x: 0, y: 0, width: self.codeView.frame.size.width, height: self.codeView.frame.size.height), suggestions: ["abraham"])
        
        textField.padding = 8
        textField.placeholder = "Try typing 'A'"
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.codeView.addSubview(textField)
        
        // auto layout
        let vertivalConstraint = textField.centerYAnchor.constraint(equalTo: self.codeView.centerYAnchor)
        let leadingConstraint = textField.leadingAnchor.constraint(equalTo: self.codeView.leadingAnchor, constant: 10)
        let trailingConstraint = textField.trailingAnchor.constraint(equalTo: self.codeView.trailingAnchor, constant: -10)
        let heightConstraint = textField.heightAnchor.constraint(equalToConstant: 37)
        NSLayoutConstraint.activate([leadingConstraint, vertivalConstraint, trailingConstraint, heightConstraint])
    }
    
    func emailChanged(_ notification: Notification)
    {
        if let text = self.emailField.text
        {
            if text.characters.count > 0
            {
                // Check if the user has started writing the suffix yet.
                var suffix = "@gmail.com"
                let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@",options: [.caseInsensitive])
                let result = regex.firstMatch(in: text, options:[], range: NSMakeRange(0, text.characters.count))
                
                if let range = result?.range
                {
                    // If user has started writing the suffix, only suggest what's left of it
                    let regSuffix = text.substring(with: (text.characters.index(text.startIndex, offsetBy: range.length - 1) ..< text.endIndex))
                    suffix = suffix.replacingOccurrences(of: regSuffix, with: "")
                }
                
                self.emailField.suggestion = text + suffix
            }
            else
            {
                // Remove suggestion if the field is empty
                self.emailField.suggestion = ""
            }
        }
        
    }
    
    // MARK: - UITextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // set field text to the suggestion text on return
        if let field = textField as? AutocompleteField
        {
            field.text = field.suggestion
        }
        return true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


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
        let suggestions = ["Abraham Lincoln", "John Doe", "John Smith"]
        basicField.suggestions = suggestions
        customField.suggestions = suggestions
        
        // change event for email field
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "emailChanged:",
            name: UITextFieldTextDidChangeNotification,
            object: emailField)
        
        
        // add code example
        let textField = AutocompleteField(frame: CGRectMake(0, 0, self.codeView.frame.size.width, self.codeView.frame.size.height), suggestions: ["abraham"])
        
        textField.padding = 8
        textField.placeholder = "Try typing 'A'"
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.codeView.addSubview(textField)
        
        // auto layout
        let vertivalConstraint = textField.centerYAnchor.constraintEqualToAnchor(self.codeView.centerYAnchor)
        let leadingConstraint = textField.leadingAnchor.constraintEqualToAnchor(self.codeView.leadingAnchor, constant: 10)
        let trailingConstraint = textField.trailingAnchor.constraintEqualToAnchor(self.codeView.trailingAnchor, constant: -10)
        let heightConstraint = textField.heightAnchor.constraintEqualToAnchor(nil, constant: 37)
        NSLayoutConstraint.activateConstraints([leadingConstraint, vertivalConstraint, trailingConstraint, heightConstraint])
    }
    
    func emailChanged(notification: NSNotification)
    {
        if let text = self.emailField.text
        {
            if text.characters.count > 0
            {
                // Check if the user has started writing the suffix yet.
                var suffix = "@gmail.com"
                let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@",options: [.CaseInsensitive])
                let result = regex.firstMatchInString(text, options:[], range: NSMakeRange(0, text.characters.count))
                
                if let range = result?.range
                {
                    // If user has started writing the suffix, only suggest what's left of it
                    let regSuffix = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(range.length - 1), end: text.endIndex))
                    suffix = suffix.stringByReplacingOccurrencesOfString(regSuffix, withString: "")
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
    func textFieldShouldReturn(textField: UITextField) -> Bool
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


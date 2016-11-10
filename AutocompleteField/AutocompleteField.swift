//
//  AutocompleteField.swift
//  Example
//
//  Created by Filip Stefansson on 05/11/15.
//  Copyright © 2015 Filip Stefansson. All rights reserved.
//

import Foundation
import UIKit


public enum AutocompleteType {
    case Word
    case Sentence
}


@IBDesignable public class AutocompleteField: UITextField
{
    // MARK: - public properties
    
    // left/right padding
    @IBInspectable public var padding : CGFloat = 0
    
    // the color of the suggestion. Matches the default placeholder color
    @IBInspectable public var completionColor : UIColor = UIColor(white: 0, alpha: 0.22)
    
    // Array of suggestions
    public var suggestions : [String] = [""]
    
    // The current suggestion shown. Can also be used to force a suggestion
    public var suggestion : String? {
        didSet {
            if let val = suggestion {
                setLabelContent(val)
            }
        }
    }
    
    // Move the suggestion label up or down. Sometimes there's a small difference, and this can be used to fix it.
    public var pixelCorrection : CGFloat = 0
    
    // Update the suggestion when the text is changed using 'field.text'
    override public var text : String? {
        didSet {
            if let text = text {
                self.setLabelContent(text)
            }
        }
    }
    
    // The type of autocomplete that should be used
    public var autocompleteType : AutocompleteType = .Word
    
    
    // MARK: - private properties
    
    // the suggestion label
    private var label = UILabel()
    
    
    // MARK: - init functions
    
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        
        createNotification()
        setupLabel()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        createNotification()
        setupLabel()
    }
    
    /**
        Create an instance of a AutocompleteField.
        - parameter 
            frame: The fields frame
            suggestion: Array of autocomplete strings
     */
    public init(frame: CGRect, suggestions: [String])
    {
        super.init(frame: frame)
        
        self.suggestions = suggestions
        createNotification()
        setupLabel()
    }
    
    
    // ovverride to set frame of the suggestion label whenever the textfield frame changes.
    public override func layoutSubviews()
    {
        self.label.frame = CGRect(x: self.padding, y: self.pixelCorrection, width: self.frame.width - (self.padding * 2), height: self.frame.height)
        super.layoutSubviews()
    }
    
    // MARK: - public methods
    public func currentSuggestion() -> NSString?
    {
        return self.suggestion as NSString?
    }
    
    
    // MARK: - private methods
    
    /**
        Create a notification whenever the text of the field changes.
    */
    private func createNotification()
    {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AutocompleteField.textChanged(notification:)),
            name: NSNotification.Name.UITextFieldTextDidChange,
            object: self)
    }
    
    /**
        Sets up the suggestion label with the same font styling and alignment as the textfield.
    */
    private func setupLabel()
    {
        setLabelContent()
        
        self.label.lineBreakMode = .byClipping

        // If the textfield has one of the default styles, we need to create some padding
        // otherwise there will be a offset in x-led.
        switch self.borderStyle
        {
            case .roundedRect, .bezel, .line:
                self.padding = 8
                break;
            default:
            break;
        }
        
        self.addSubview(self.label)
    }
    
    
    /**
        Set content of the suggestion label.
        - parameter text: Suggestion text
    */
    private func setLabelContent(_ text : String = "")
    {
        var text = text
        // label string
        if(text.characters.count < 1) {
            label.attributedText = nil
            return
        }
        
        // only return first word if in word mode
        if(self.autocompleteType == .Word)
        {
            
            let words = self.text!.components(separatedBy: " ")
            let suggestionWords = text.components(separatedBy: " ")
            var string : String = ""
            for i in 0 ..< words.count
            {
                string = string.appending(suggestionWords[i]) + " "
            }
            text = string
        }
        
        // create an attributed string instead of the regular one. 
        // In this way we can hide the letters in the suggestion that the user has already written.
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: [
                NSFontAttributeName:UIFont(
                    name: self.font!.fontName,
                    size: self.font!.pointSize
                    )!,
                NSForegroundColorAttributeName: self.completionColor
            ]
        )
        
        // Hide the letters that are under the fields text.
        // If the suggestion is abcdefgh and the user has written abcd
        // we want to hide those letters from the suggestion.
        if let inputText = self.text
        {
            attributedString.addAttribute(NSForegroundColorAttributeName,
                value: UIColor.clear,
                range: NSRange(location:0, length:inputText.characters.count)
            )
        }
        
        label.attributedText = attributedString
        label.textAlignment = self.textAlignment
    }
    
    /**
        Scans through the suggestions array and finds a suggestion that 
        matches the searchTerm.
        - parameter searchTerm: What to search for
        - returns A string or nil
     */
    private func suggestionToShow(_ searchTerm : String) -> String
    {
        var returnString = ""
        for suggestion in self.suggestions
        {
            // Search the suggestion array. User lowercase on both to get a match. 
            // Also, if the match is exact we move on.
            if( (suggestion != searchTerm) &&
                 suggestion.lowercased().hasPrefix(searchTerm.lowercased()))
            {
                var suggestionToReturn = searchTerm
                suggestionToReturn = suggestionToReturn + suggestion.substring(with: Range(suggestion.index(after: searchTerm.characters.endIndex) ..< suggestion.endIndex))
                returnString = suggestionToReturn
                break
            }
        }
        self.suggestion = returnString
        return returnString
    }
    
    
    // MARK: - Events
    
    /**
        Triggered whenever the field text changes.
        - parameter notification: The NSNotifcation attached to the event
    */
    func textChanged(notification: NSNotification)
    {
        if let text = self.text
        {
            let suggestion = suggestionToShow(text)
            setLabelContent(suggestion)
        }
    }
    
    // ovverride to set padding
    public override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return CGRect(x: bounds.origin.x + self.padding, y: bounds.origin.y,
                      width: bounds.size.width - (self.padding * 2), height: bounds.size.height)
    }
    
    // ovverride to set padding
    public override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return self.textRect(forBounds: bounds)
    }
    
    // ovverride to set padding on placeholder
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect
    {
        return self.textRect(forBounds: bounds)
    }
    
    // remove observer on deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

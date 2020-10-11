//
//  AutocompleteField.swift
//
//  Created by Filip Stefansson on 2020-10-09.
//

import Foundation
import UIKit

public enum SuggestionType {
    case Word
    case Sentence
}

@IBDesignable public class AutocompleteField: UITextField
{
    // MARK: - public properties

    /// The list of suggestions that the textfield should use when the user is typing.
    public var suggestions: [String] = [] {
        didSet {
            self.suggestionList = self.allSuggestions()
        }
    }

    /// The color of the autocompletion suggestion.
    @IBInspectable public var suggestionColor: UIColor = UIColor(white: 0, alpha: 0.22)

    /// The current suggestion shown. You can use this as a getter you to retrive
    /// the current suggestion or as a setter to force the textfield to show a specific suggestion.
    public var suggestion: String? {
        didSet {
            if let val = suggestion {
                self.setLabelText(text: val)
            }
        }
    }

    /// Move the suggestion label in x or y. Sometimes there's a small difference between
    /// the suggestion and the real text, and this can be used to fix it.
    public var pixelCorrections: CGPoint = CGPoint(x: 0, y: 0);

    /// The type of autocomplete that should be used
    public var suggestionType: SuggestionType = .Sentence

    /// Set a horizontal padding for the the textfield. Automatically set when using a `borderStyle` of `.roundedRect`, `.bezel` or `.line`, because those have added padding.
    public var horizontalPadding: CGFloat = 0

    // whenever the text value is set, we need to update the suggestion
    // we do this by overriding the `text` property setter.
    override public var text: String? {
        didSet {
            self.textFieldDidChange(self)
        }
    }

    override public var borderStyle: UITextField.BorderStyle {
        didSet {
            setPadding()
        }
    }

    // MARK: - private properties

    private var suggestionList: [String] = []

    /// The suggestion label
    private var label = UILabel()

    // MARK: - init functions

    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setup()
    }

    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setup()
    }

    /// Create an instance of a AutocompleteField.
    ///
    /// - Parameters:
    ///   - frame:       Frame of the textfield.
    ///   - suggestions: The list of suggestions that the textfield should use when the user is typing.
    public init(frame: CGRect, suggestions: [String])
    {
        super.init(frame: frame)
        self.suggestions = suggestions
        self.setup()
    }

    // ovverride to set frame of the suggestion label whenever the textfield frame changes.
    public override func layoutSubviews()
    {
        // use `horizontalPadding` and `pixelCorrections` to calculte new frame
        self.label.frame = CGRect(x: self.horizontalPadding + self.pixelCorrections.x, y: self.pixelCorrections.y, width: self.frame.width - (self.horizontalPadding * 2), height: self.frame.height)
        super.layoutSubviews()
    }

    // MARK: - private methods

    private func setup() {
        self.addTarget(self, action: #selector(AutocompleteField.textFieldDidChange(_:)), for: .editingChanged)

        // create the label we use to
        self.createAutocompleteLabel()
    }

    /// Sets up the suggestion label with the same font styling and alignment as the textfield.
    private func createAutocompleteLabel()
    {
        self.label.lineBreakMode = .byClipping
        self.setPadding()
        self.addSubview(self.label)
    }

    private func setPadding() {
        self.label.lineBreakMode = .byClipping

        // if the textfield has one of the default styles,
        // we need to add some padding, otherwise there will
        // be a offset in x-led.
        switch self.borderStyle
        {
        case .roundedRect, .bezel, .line:
            self.horizontalPadding = 8
            break
        default:
            break
        }
    }

    /// Set content of the suggestion label.
    ///
    /// - parameters:
    ///     - text: Suggestion text
    private func setLabelText(text: String?)
    {
        guard let labelText = text else {
            label.attributedText = nil
            return
        }
        
        // don't show the suggestion if
        // 1. there's no text
        // 2. the text is longer than the suggestion
        if let inputText = self.text {
            if (inputText.count < 1 || inputText.count >= labelText.count) {
                label.attributedText = nil
                return
            }
        }

        let range = NSRange(location: 0, length: labelText.count);

        // create an attributed string instead of the regular one
        // in this way we can hide the letters in the suggestion
        // that the user has already written
        let attributedString = NSMutableAttributedString(
            string: labelText
        )
        attributedString.addAttributes(self.defaultTextAttributes, range: range)
        attributedString.addAttribute(.foregroundColor, value: self.suggestionColor, range: range);

        // hide the letters that are under the fields text
        // if the suggestion is abcdefgh and the user has written abcd
        // we want to hide those letters from the suggestion
        if let inputText = self.text
        {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                value: UIColor.clear,
                range: NSRange(location: 0, length: inputText.count)
            )
        }

        label.attributedText = attributedString
        label.textAlignment = self.textAlignment
    }

    /// This method converts the suggestions list if suggestionType is sentence
    /// and an array with step of an suggestion if suggestionType is word
    private func allSuggestions() -> [String] {
        if (self.suggestionType == .Sentence) {
            return self.suggestions
        }

        var wordSuggestions: [String] = [];

        for suggestion in suggestions {
            let suggestions = suggestion.components(separatedBy: " ")
            for count in 0...suggestions.count - 1 {
                // the string where we will append all items
                var name = ""
                for i in 0...count {
                    if (i > 0) {
                        name = name.appending(" ")
                    }
                    name = name.appending(suggestions[i])
                }
                wordSuggestions.append(contentsOf: [name])
            }
        }

        wordSuggestions = wordSuggestions.sorted { $0.count < $1.count }

        return wordSuggestions
    }

    /// Scans through the suggestions array and finds a suggestion that matches the searchTerm.
    ///
    /// - parameters:
    ///    - searchTerm: what to search for
    /// - returns A string or nil
    private func getSuggestion(text: String?) -> String?
    {
        guard let suggestionText = text else {
            return nil;
        }

        if (text == "") {
            return nil;
        }

        if let suggestion = self.suggestionList.first(where: { $0.hasPrefix(suggestionText) }) {
            return suggestion
        }

        return nil
    }

    // MARK: - Events

    /// Triggered whenever the field text changes.
    ///
    /// - parameters:
    ///     - notification: The NSNotifcation attached to the event
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let suggestion = getSuggestion(text: text) {
            self.suggestion = suggestion
            self.setLabelText(text: suggestion)
        } else {
            self.suggestion = nil
            self.setLabelText(text: nil)
        }
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + self.horizontalPadding, y: bounds.origin.y, width: bounds.size.width - (self.horizontalPadding * 2), height: bounds.size.height);
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

    // remove target on deinit
    deinit {
        self.removeTarget(self, action: #selector(AutocompleteField.textFieldDidChange(_:)), for: .editingChanged)
    }
}

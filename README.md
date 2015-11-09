![AutocompleteField](https://dl.dropboxusercontent.com/u/958499/autocomplete.png?dl=0)

AutocompleteField let's you add word completion to your UITextFields. 

> Autocomplete, or word completion, is a feature in which an application predicts the rest of a word a user is typing.

## How it works

![AutocompleteField](https://dl.dropboxusercontent.com/u/958499/preview.gif?dl=0)

## Installation

### Manual installation

Import `AutocompleteField.swift` into your project.

### CocoaPods

```
platform :ios, '8.0'
pod "AutocompleteField", "~> 1.0" 
```

## Usage

The easiest way is to add a `UITextField` in your Storyboard, and then giving it the `AutocompleteField` subclass. You can use the property editor to change both the padding and the completion color of the textfield.

If you want to add a field using code, there's a custom init method you can use:

```swift
let textField = AutocompleteField(frame: CGRectMake(10, 10, 200, 40), suggestions: ["Abraham", "George", "Franklin"])
view.addSubview(textField)
```

## Customization

AutocompleteField is a subclass of UITextField, so you can modify it in the same way you normally would, without any restrictions. The new properties you can set are:

```swift
// left/right padding
padding: CGFloat 
// the color of the suggestion. Matches the default placeholder color
completionColor : UIColor 
// The current suggestion shown. Can also be used to force a suggestion
suggestion : String
// Array of suggestions
suggestions : [String]
// Move the suggestion label up or down. Sometimes there's a small difference, and this can be used to fix it.
pixelCorrection : CGFloat
```

## Demo

Check out the Example project.

## Todo
- [ ] Smarter suggestions. If both John Doe and John Smith are in the suggestion array, only Joe should be suggested.
- [ ] Tests

## License
AutocompleteField is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for details.
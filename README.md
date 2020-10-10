# AutocompleteField

Subclass of `UITextField` that shows inline suggestions while typing.

![AutocompleteField](/.github/example.gif?raw=true)

# Requirements

- iOS 10.0+
- Swift 4.2+

# Installation

## CocoaPods

```ruby
target 'MyApp' do
  pod 'AutocompleteField', '~> 2.0'
end
```

## Swift Package Manager

Select File > Swift Packages > Add Package Dependency and then enter https://github.com/filipstefansson/AutocompleteField.git in the "Choose Package Repository" dialog.

See [Apple docs](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) for more information.

## Manually

Copy `/Sources/AutocompleteField.swift` to your project. There are no other dependencies.

# Usage

You use this textfield in the same way as the regular `UITextField`, through Storyboards or programmatically:

```swift
let textfield = AutocompleteField(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
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

// add to view
self.view.addSubview(textfield)
```

> [See full example here](/examples/BasicExample/BasicExample/ViewController.swift).

# API

| Property            | Type               | Description                                                                                                                                        |
| ------------------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `suggestionColor`   | `UIColor`          | The color of the suggestion. Defaults to the default placeholder color.                                                                            |
| `suggestion`        | `String`           | The current suggestion shown. Setting this manually will force a suggestion to be shown.                                                           |
| `suggestions`       | `[String]`         | Array of suggestions.                                                                                                                              |
| `autocompleteType`  | `AutocompleteType` | The type of autocomplete that should be used. `.Word` will only hint the the next word in the suggestion and `.Sentence` will show all words.      |
| `pixelCorrections`  | `CGPoint`          | Move the suggestion label up/down left/right. Use this to correct any differences if the suggestion doesn't match the input value for some reason. |
| `horizontalPadding` | `CGFloat`          | Add padding to your textfield. Automatically set when using a `borderStyle` that has padding.                                                      |

# Demo

Check out the [example project](/examples/BasicExample).

# License

`AutocompleteField` is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for details.

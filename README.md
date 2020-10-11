# AutocompleteField

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AutocompleteField.svg)](https://img.shields.io/cocoapods/v/AutocompleteField.svg)
[![Platform](https://img.shields.io/cocoapods/p/AutocompleteField.svg?style=flat)](https://AutocompleteField.github.io/AutocompleteField)

Subclass of `UITextField` that shows inline suggestions while typing.

- Plug and play replacement for `UITextField`.
- Delimiter support. Perfect when autocompleting email addresses.
- Two suggestion modes (word and sentence, see API below).
- Works with custom fonts, borders etc.
- Super lightweight and zero dependencies.

---

![AutocompleteField](/.github/example.gif?raw=true)

# Requirements

- iOS 10.0+
- Swift 4.2+

# Installation

## CocoaPods

Add the following to your `Podfile`:

```ruby
target 'MyApp' do
  pod 'AutocompleteField', '~> 2.0'
end
```

## Swift Package Manager

- Select **File > Swift Packages > Add Package Dependency**.
- Enter `https://github.com/filipstefansson/AutocompleteField.git` in the **Choose Package Repository** dialog.

See [Apple docs](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) for more information.

## Manually

- Copy `/Sources/AutocompleteField.swift` to your project. There are no other dependencies.

# Usage

You use this textfield in the same way as the regular `UITextField`, through Storyboards or programmatically:

```swift
import AutocompleteField

...

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

👉 [See full example here](/examples/BasicExample/BasicExample/ViewController.swift)

# API

| Property            | Type             | Description                                                                                                                                                                    |
| ------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `suggestionColor`   | `UIColor`        | The color of the suggestion. Defaults to the default placeholder color.                                                                                                        |
| `suggestion`        | `String`         | The current suggestion shown. Setting this manually will force a suggestion to be shown.                                                                                       |
| `suggestions`       | `[String]`       | Array of suggestions.                                                                                                                                                          |
| `suggestionType`    | `SuggestionType` | The type of suggestion that should be used. `.Word` will only hint the the next word in the suggestion and `.Sentence` will show the whole suggestion. Defaults to `.Sentence` |
| `pixelCorrections`  | `CGPoint`        | Move the suggestion label up/down left/right. Use this to correct any differences if the suggestion doesn't match the input value for some reason.                             |
| `horizontalPadding` | `CGFloat`        | Add padding to your textfield. Automatically set when using a `borderStyle` that has padding.                                                                                  |

# Demo

Check out the [example project](/examples/BasicExample).

# License

`AutocompleteField` is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for details.

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "AutocompleteField"
  s.version      = "1.1"
  s.summary      = "Add word completion to your UITextFields."

  s.homepage     = "http://iosdev.io/autocompletefield"
  s.screenshots  = "https://camo.githubusercontent.com/9a525a5623198884f545d43c7aa0df857488c2c6/68747470733a2f2f646c2e64726f70626f7875736572636f6e74656e742e636f6d2f752f3935383439392f707265766965772e6769663f646c3d30"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Filip Stefansson" => "filip.stefansson@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/filipstefansson/AutocompleteField.git", :tag => "1.1" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "AutocompleteField/**/*.swift"

end

Pod::Spec.new do |s|
  s.name = "AutocompleteField"
  s.version = "2.0"
  s.summary = "Subclass of UITextField that shows inline suggestions while typing."
  s.homepage = "https://github.com/filipstefansson/AutocompleteField"
  s.screenshots = "https://raw.githubusercontent.com/filipstefansson/AutocompleteField/master/.github/example.gif?raw=1"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Filip Stefansson" => "filip.stefansson@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = "10.0"
  s.source = { :git => "https://github.com/filipstefansson/AutocompleteField.git", :tag => "2.0" }
  s.source_files = "Sources/**/*.swift"
end

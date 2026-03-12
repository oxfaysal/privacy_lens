#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint privacy_lens.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'privacy_lens'
  s.version          = '1.0.3'
  s.summary          = 'A lightweight Flutter widget to mask sensitive data from screen captures and recordings.'
  s.description      = <<-DESC
A lightweight, zero-dependency Flutter widget that allows you to mask sensitive information (such as credit card numbers, passwords, or personal data) from unauthorized screen captures and screen recordings.
                       DESC
  s.homepage         = 'https://github.com/oxfaysal/privacy_lens'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Faysal' => 'loomixdev@gmail.com' }
  s.source           = { :path => '.' }
  
  # যেহেতু কোনো নেটিভ সোর্স কোড নেই, তাই নিচের লাইনটি এভাবে রাখো
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
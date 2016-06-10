Pod::Spec.new do |spec|
  spec.name         = 'PDAutoSlideScrollView'
  spec.version      = '1.0.0'
  spec.license      = 'MIT'
  spec.summary      = 'AutoSlideScrollView'
  spec.homepage     = 'https://github.com/JackLiu1002/PDAutoSlideScrollView'
  spec.author       = 'Jack Liu'
  spec.platform     = :ios, "5.1.1"
  spec.source       = { :git => 'https://github.com/JackLiu1002/PDAutoSlideScrollView.git', :tag => '1.0.0'}
  spec.source_files = 'PDAutoSlideScrollView/PDAutoSlideScrollView/*.{h,m}'
  spec.frameworks = 'UIKit'
  spec.requires_arc = true
end
Pod::Spec.new do |spec|
  spec.name         = 'BTIKit'
  spec.version      = '1.0.0'
  spec.summary      = 'A handful of helpful classes and categories for generic iOS development.'
  spec.homepage     = 'https://github.com/BriTerIdeas/BTIKit'
  spec.author       = { 'Brian Slick' => 'brianslick@mac.com' }
  spec.source       = { :git => 'https://github.com/BriTerIdeas/BTIKit.git', :tag => "v#{spec.version}" }
  spec.description  = 'A handful of helpful classes and categories for generic iOS development.'
  spec.source_files = 'BTIKit/*.{h,m}'
  spec.requires_arc = true
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.frameworks = 'Foundation', 'UIKit'
end
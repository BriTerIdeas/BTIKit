#
# Be sure to run `pod lib lint BTIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name            = 'BTIKit'
  s.version         = '1.6'
  s.summary         = 'A handful of helpful classes and categories for generic iOS development.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description     = <<-DESC
                    A handful of helpful categories and classes for generic iOS development.
                    DESC

  s.homepage        = 'https://github.com/BriTerIdeas/BTIKit'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Brian Slick' => 'brianslick@mac.com' }
  s.source          = { :git => 'https://github.com/BriTerIdeas/BTIKit.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.source_files = 'BTIKit/*.{h,m}', 'BTIKit/**/*.{h,m}'

#  s.frameworks 'Foundation', 'UIKit'

end

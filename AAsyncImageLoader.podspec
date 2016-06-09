#
# Be sure to run `pod lib lint AAsyncImageLoader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AAsyncImageLoader'
  s.version          = '0.1.1'
  s.summary          = 'An asynchronous image loader, with some magic and an UIImageView category for drop-in integration.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library will allow you to load image from the web to any UIImageView thanks to the UIImageView category.
It is also a more capable low level loading library to get UIImage from the Internet allowing you to control the logic you want to put there.
                       DESC

  s.homepage         = 'https://github.com/jrmgx/AAsyncImageLoader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jérôme Gx' => 'jerome@gangneux.net' }
  s.source           = { :git => 'https://github.com/jrmgx/AAsyncImageLoader.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AAsyncImageLoader/Classes/**/*'
  
  # s.resource_bundles = {
  #     'AAsyncImageLoader' => ['AAsyncImageLoader/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

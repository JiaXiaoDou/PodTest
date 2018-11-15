#
# Be sure to run `pod lib lint PodTest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PodTest'
  s.version          = '1.0.0'
  s.summary          = 'v1.0.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  从前有座山，山上有座庙，庙里有个老和尚和小和尚，老和尚在给小和尚讲故事，故事说的是：从前有座上，上上有座庙……
                       DESC

  s.homepage         = 'https://github.com/JiaXiaoDou/PodTest'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JiaXiaoDou' => 'liusijia@socian.com.cn' }
  s.source           = { :git => 'https://github.com/JiaXiaoDou/PodTest.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PodTest/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PodTest' => ['PodTest/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

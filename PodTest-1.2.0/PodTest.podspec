Pod::Spec.new do |s|
  s.name = "PodTest"
  s.version = "1.2.0"
  s.summary = "v1.2.0"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"JiaXiaoDou"=>"liusijia@socian.com.cn"}
  s.homepage = "https://github.com/JiaXiaoDou/PodTest"
  s.description = "\u{4ece}\u{524d}\u{6709}\u{5ea7}\u{5c71}\u{ff0c}\u{5c71}\u{4e0a}\u{6709}\u{5ea7}\u{5e99}\u{ff0c}\u{5e99}\u{91cc}\u{6709}\u{4e2a}\u{8001}\u{548c}\u{5c1a}\u{548c}\u{5c0f}\u{548c}\u{5c1a}\u{ff0c}\u{8001}\u{548c}\u{5c1a}\u{5728}\u{7ed9}\u{5c0f}\u{548c}\u{5c1a}\u{8bb2}\u{6545}\u{4e8b}\u{ff0c}\u{6545}\u{4e8b}\u{8bf4}\u{7684}\u{662f}\u{ff1a}\u{4ece}\u{524d}\u{6709}\u{5ea7}\u{4e0a}\u{ff0c}\u{4e0a}\u{4e0a}\u{6709}\u{5ea7}\u{5e99}\u{2026}\u{2026}"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/PodTest.embeddedframework/PodTest.framework'
end

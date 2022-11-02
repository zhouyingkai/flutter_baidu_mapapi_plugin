#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_baidu_mapapi_utils.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_baidu_mapapi_utils'
  s.version          = '3.1.0'
  s.summary          = 'A new Flutter plugin for BaiduMap utils.'
  s.description      = <<-DESC
A new Flutter plugin for BaiduMap utils.
                       DESC
  s.homepage         = 'https://lbsyun.baidu.com/index.php?title=flutter/loc'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Baidu Map SDK team' => 'lbsyun.baidu@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'flutter_baidu_mapapi_base'
  s.dependency 'BaiduMapKit/Utils','6.5.1'
  s.platform = :ios, '8.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
   s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end

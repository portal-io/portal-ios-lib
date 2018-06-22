Pod::Spec.new do |s|
    s.name         = 'WVRImage'
    s.version      = '1.1.5'
    s.summary      = 'WVRImage files'
    s.homepage     = 'http://git.moretv.cn/whaley-vr-ios-lib/WVRImage'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'http://git.moretv.cn/whaley-vr-ios-lib/WVRImage.git', :tag => s.version}
    s.vendored_frameworks = 'WVRImage/Classes/SDWebImage.framework'
    s.frameworks   = 'UIKit', 'Foundation'
    s.requires_arc = true
end
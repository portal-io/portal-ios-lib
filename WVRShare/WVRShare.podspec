Pod::Spec.new do |s|
    s.name         = 'WVRShare'
    s.version      = '0.0.4'
    s.summary      = 'WVRShare files'
    s.homepage     = 'https://git.moretv.cn/whaley-vr-ios-lib/WVRShare'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://git.moretv.cn/whaley-vr-ios-lib/WVRShare.git', :tag => s.version}
    
    s.source_files = ['WVRShare/Classes/**/*']
    
    s.dependency 'UMengUShare/UI',             '~> 6.4'
    s.dependency 'UMengUShare/Social/Sina',    '~> 6.4'
    s.dependency 'UMengUShare/Social/WeChat',  '~> 6.4'
    s.dependency 'UMengUShare/Social/QQ',      '~> 6.4'
    s.dependency 'WVRBI'
    s.dependency 'WVRAppContext'
    s.dependency 'WVRWidget'


    s.framework = 'UIKit', 'Foundation'
    
    s.requires_arc = true
end
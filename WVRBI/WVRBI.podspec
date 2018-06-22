Pod::Spec.new do |s|
    s.name         = 'WVRBI'
    s.version      = '0.0.2'
    s.summary      = 'WVRBI files'
    s.homepage     = 'http://git.moretv.cn/whaley-vr-ios-lib/WVRBI'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'http://git.moretv.cn/whaley-vr-ios-lib/WVRBI.git', :tag => s.version}
    s.source_files = 'WVRBI/Classes/*/**.{h,m}'
    s.requires_arc = true
    
    s.dependency 'UMengAnalytics-NO-IDFA'
    s.dependency 'YYModel'
    s.dependency 'WVRCache'
    s.dependency 'WVRAppContext'
end
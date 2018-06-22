Pod::Spec.new do |s|
    s.name         = 'WVRCache'
    s.version      = '0.0.3'
    s.summary      = 'WVRCache files'
    s.homepage     = 'http://git.moretv.cn/whaley-vr-ios-lib/WVRCache'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'http://git.moretv.cn/whaley-vr-ios-lib/WVRCache.git', :tag => s.version}
    s.source_files = 'WVRCache/Classes/**/**.{h,m}'
    s.requires_arc = true

    s.dependency 'FMDB'

end

Pod::Spec.new do |s|
    s.name         = 'WVRNetModel'
    s.version      = '0.0.4'
    s.summary      = 'WVRNetModel files'
    s.homepage     = 'http://git.moretv.cn/whaley-vr-ios-lib/WVRNetModel'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'http://git.moretv.cn/whaley-vr-ios-lib/WVRNetModel.git', :tag => s.version}
    s.source_files = 'WVRNetModel/Classes/*.{h,m}'
    s.requires_arc = true
    s.dependency 'YYModel'
    s.dependency 'LKDBHelper'
    s.dependency 'WVRUtil'	
end

Pod::Spec.new do |s|
    s.name         = 'WVRUtil'
    s.version      = '0.0.1'
    s.summary      = 'WVRUtil files'
    s.homepage     = 'https://git.moretv.cn/whaley-vr-ios-lib/WVRUtil'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'

    s.source       = {:git => 'https://git.moretv.cn/whaley-vr-ios-lib/WVRUtil.git', :tag => s.version}
    
    s.source_files = ['WVRUtil/Classes/**/*.{h,m}', 'WVRUtil/Classes/*.h']
    s.resources = ['WVRUtil/Classes/nation.db']
    
    s.requires_arc = true
    s.frameworks = ['Foundation', 'UIKit']

    s.dependency 'FMDB'
    s.dependency 'CocoaHTTPServer'
    
end

    

    

    
Pod::Spec.new do |s|
    s.name         = 'WVRSocketIO'
    s.version      = '0.0.1'
    s.summary      = 'WVRSocketIO files'
    s.homepage     = 'https://shen.qingbo@git.moretv.cn/whaley-vr-ios-lib/WVRSocketIO'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://shen.qingbo@git.moretv.cn/whaley-vr-ios-lib/WVRSocketIO.git', :tag => s.version}
    s.vendored_frameworks = ['WVRSocketIO/Classes/SocketIO/SocketIO.framework']
    # s.source_files = 'WVRSocketIO/Source/**/*.{swift}'

    # s.requires_arc = true
    # s.pod_target_xcconfig = { "OTHER_LDFLAGS" => "-ObjC -all_load" }
    # .swift-version = "2.3"
    # s.xcconfig = "-l"
    # s.framework = 'SocketIO'
    # s.xcconfig = {
    #     "OTHER_LDFLAGS": "-lz"
    # }
end

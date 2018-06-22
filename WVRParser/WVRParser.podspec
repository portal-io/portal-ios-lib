Pod::Spec.new do |s|
    s.name         = 'WVRParser'
    s.version      = '0.0.5'
    s.summary      = 'WVRParser framework'
    s.homepage     = 'https://git.moretv.cn/whaley-vr-ios-lib/WVRParser'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://git.moretv.cn/whaley-vr-ios-lib/WVRParser.git', :tag => s.version}
    # s.source_files = ['WVRParser/Classes/**/*']

    # 无依赖  0.0.5版本因为版权问题移除华数解析库
    # _Wasu   = { :spec_name => "WasuPlayUtil", :source_files => ['WVRParser/Classes/WasuPlayUtil/*/*.{h,m}'], :vendored_libraries => 'WVRParser/Classes/WasuPlayUtil/*.a' }

    # 仅外部依赖
    _WhaleyParser   = { :spec_name => "WVRParseUrl", :source_files => ['WVRParser/Classes/WVRParseUrl/*.{h,m}'], :vendored_frameworks => 'WVRParser/Classes/WVRParseUrl/*.framework', :dependency => [{:name => 'WVRAppContext', :version => '~> 0.1.2'}] }

    $animations = [_WhaleyParser] #[_Wasu, _WhaleyParser]
    
    $animations.each do |spec|
        s.subspec spec[:spec_name] do |ss|

            if spec[:source_files]
              ss.source_files = spec[:source_files]
            end
            if spec[:sub_dependency]
              spec[:sub_dependency].each do |dep|
                  ss.dependency "WVRParser/#{dep[:spec_name]}"
              end
            end
            if spec[:vendored_frameworks]
                ss.vendored_frameworks = spec[:vendored_frameworks]
            end
            if spec[:vendored_libraries]
                ss.vendored_libraries = spec[:vendored_libraries]
            end
            if spec[:dependency]
                spec[:dependency].each do |dep|
                    ss.dependency dep[:name]
                end
            end
        end
    end
    
    s.requires_arc = true
    s.framework = 'Foundation', 'Security'
    s.dependency 'WVRAppContext'
end

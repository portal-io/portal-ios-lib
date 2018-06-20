Pod::Spec.new do |s|
    s.name         = 'WVRAppContext'
    s.version      = '0.4.4'
    s.summary      = 'WVRAppContext files'
    s.homepage     = 'https://git.moretv.cn/whaley-vr-ios-lib/WVRAppContext'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://git.moretv.cn/whaley-vr-ios-lib/WVRAppContext.git', :tag => s.version}
    # s.source_files = ['WVRAppContext/Core/**/*']

    # 无依赖
    _Define   = { :spec_name => "Define",:source_files => ['WVRAppContext/Core/Define/**/*'] }
    _Color    = { :spec_name => "Color",:source_files => ['WVRAppContext/Core/Color/**/*'] }
    _Frame    = { :spec_name => "Frame",:source_files => ['WVRAppContext/Core/Frame/**/*'] }
    _Const    = { :spec_name => "Const",:source_files => ['WVRAppContext/Core/Const/**/*'] }
    _String   = { :spec_name => "String",:source_files => ['WVRAppContext/Core/String/**/*'] }

    # 仅外部依赖
    _WVRProgressHUD   = { :spec_name => "WVRProgressHUD",:source_files => ['WVRAppContext/Core/WVRProgressHUD/**/*'],
                 :sub_dependency => [_Frame] }

    # 仅内部依赖
    _Font   = { :spec_name => "Font", :source_files => ['WVRAppContext/Core/Font/**/*'], :sub_dependency => [_Frame] }
    
    # 内外都有依赖
    _Debug   = { :spec_name => "Debug",:source_files => ['WVRAppContext/Core/Debug/**/*'], :sub_dependency => [_Define], :dependency => [{:name => 'CocoaLumberjack', :version => '~> 3.2.0'}] }
    _Category   = { :spec_name => "Category",:source_files => ['WVRAppContext/Core/Category/**/*'],
                :sub_dependency => [_Define, _WVRProgressHUD], :dependency => [{:name => 'Toast', :version => '~> 3.0'}] }
    _AppContext   = { :spec_name => "AppContext",:source_files => ['WVRAppContext/Core/Model/**/*','WVRAppContext/Core/**.{h,m}'], 
                    :sub_dependency => [_Debug, _Const, _Frame, _Category, _Color, _Font], :dependency => [{:name => "Reachability", :version => "~> 3.2"}, {:name => "SAMKeychain", :version => "~> 1.5"}, {:name => "Reachability", :version => "~> 3.2"}] }
    
    $animations = [_Define, _Const, _Debug, _Frame, _String, _Font, _Color, _Category, _WVRProgressHUD, _AppContext]
    
    $animations.each do |spec|
        s.subspec spec[:spec_name] do |ss|

            if spec[:source_files]
              ss.source_files = spec[:source_files]
            end
            if spec[:sub_dependency]
              spec[:sub_dependency].each do |dep|
                  ss.dependency "WVRAppContext/#{dep[:spec_name]}"
              end
            end
            if spec[:dependency]
                spec[:dependency].each do |dep|
                    ss.dependency dep[:name]
                end
            end

        end
    end
    # s.dependency 'SAMKeychain',       '~> 1.5'
    # s.dependency 'Toast',             '~> 3.0'
    # s.dependency 'Reachability',        '~> 3.2'
    # s.dependency 'CocoaLumberjack',     '~> 3.2.0'

    s.framework = 'UIKit', 'Foundation'
    
    s.requires_arc = true
end

Pod::Spec.new do |s|
    s.name         = 'WVRNet'
    s.version      = '0.2.3'
    s.summary      = 'WVRNet files'
    s.homepage     = 'http://git.moretv.cn/whaley-vr-ios-lib/WVRNet'
    s.license      = 'MIT'
    s.authors      = {'whaleyvr' => 'vr-iosdev@whaley.cn'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'http://git.moretv.cn/whaley-vr-ios-lib/WVRNet.git', :tag => s.version}
    
    s.source_files = 'WVRNet/WVRNetworking/**/*.{h,m}'
    
    s.requires_arc = true

    s.dependency 'AFNetworking'
    s.dependency 'YYModel'
    s.dependency 'ReactiveObjC'
end


# WVRNetPublic  = { :spec_name => "Public",:source_files => ['WVRNet/WVRNetworking/**.{h,m}'] }
#     WVRNetSessionProtocol   = { :spec_name => "SessionProtocol",:source_files => ['WVRNet/WVRNetworking/SessionProtocol/**/*'] }
#     WVRNetAPIProxy   = { :spec_name => "APIProxy", :source_files => ['WVRNet/WVRNetworking/APIProxy/**/*']}
#     WVRNetBaseAPIManager   = { :spec_name => "BaseAPIManager", :source_files => ['WVRNet/WVRNetworking/BaseAPIManager/**/*'], :sub_dependency => [] }
#     WVRNetCategories   = { :spec_name => "Categories", :source_files => ['WVRNet/WVRNetworking/Categories/**/*'], :sub_dependency => [] }
#     WVRNetConfig   = { :spec_name => "Config" ,:source_files => ['WVRNet/WVRNetworking/Config/**/*']}
#     WVRNetCacheComponents   = { :spec_name => "CacheComponents" ,:source_files => ['WVRNet/WVRNetworking/CacheComponents/**/*'],
#                         :sub_dependency=>[WVRNetCategories,WVRNetConfig]}
    
#     WVRNetNetLogger   = { :spec_name => "NetLogger" ,:source_files => ['WVRNet/WVRNetworking/NetLogger/**/*']}
#     WVRNetServices   = { :spec_name => "Services" ,:source_files => ['WVRNet/WVRNetworking/Services/**/*']}
#     WVRNetRequestGenerator   = { :spec_name => "RequestGenerator" ,:source_files => ['WVRNet/WVRNetworking/RequestGenerator/**/*'], 
#                             :sub_dependency => [WVRNetSessionProtocol,WVRNetConfig,WVRNetServices,WVRNetCategories]}
#     WVRNetResponse   = { :spec_name => "Response" ,:source_files => ['WVRNet/WVRNetworking/Response/**/*'], 
#                             :sub_dependency => [WVRNetBaseAPIManager,WVRNetCategories]}
    

#     $animations = [WVRNetPublic ,WVRNetSessionProtocol, WVRNetAPIProxy, 
#                     WVRNetBaseAPIManager,WVRNetCacheComponents ,WVRNetCategories,

#                     WVRNetConfig, WVRNetNetLogger, WVRNetRequestGenerator, WVRNetResponse, WVRNetServices ]

#     $animations.each do |spec|
#         s.subspec spec[:spec_name] do |ss|

#             # specname = spec[:spec_name]

#             # sources = ["WVRUIFrame/Core/#{specname}/**/*"]

#             # ss.source_files = sources

#             if spec[:source_files]
#               ss.source_files = spec[:source_files]
#             end
#             if spec[:sub_dependency]
#               spec[:sub_dependency].each do |dep|
#                   ss.dependency "WVRNet/#{dep[:spec_name]}"
#               end
#             end
#             if spec[:dependency]
#                 spec[:dependency].each do |dep|
#                     ss.dependency dep[:name], dep[:version]
#                 end
#             end

#         end
#     end
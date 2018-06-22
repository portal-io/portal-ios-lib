#
#  Be sure to run `pod spec lint PortalIosLibrary.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "PortalIosLibrary"
  s.version      = "0.0.9"
  s.summary      = "for portal-ios project."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                  this is for portal-ios project.
                   DESC

  s.homepage     = "https://github.com/portal-io/portal-ios-library"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "qbshen" => "2837915131@qq.com" }
  # Or just: s.author    = "qbshen"
  # s.authors            = { "qbshen" => "shen.qingbo@whaley.cn" }
  # s.social_media_url   = "http://twitter.com/qbshen"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "9.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/portal-io/portal-ios-library.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.subspec 'WVRAppContext' do |cur|
  cur.source_files = 'WVRAppContext/WVRAppContext/Core/**/*.{h,m}'
  cur.dependency "Toast", "~> 3.0"
  cur.dependency "CocoaLumberjack", "~> 3.2.0"
  cur.dependency "SAMKeychain", "~> 1.5"
  cur.dependency "Reachability", "~> 3.2"
  end
  # s.source_files  = "Classes", "Classes/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  
  s.subspec 'WVRNet' do |cur|
  cur.source_files = 'WVRNet/WVRNet/WVRNetworking/**/*.{h,m}'

  cur.dependency 'AFNetworking'
  cur.dependency 'YYModel'
  cur.dependency 'ReactiveObjC'
  end

  s.subspec 'WVRUtil' do |cur|
  cur.source_files = ['WVRUtil/WVRUtil/Classes/**/*.{h,m}', 'WVRUtil/WVRUtil/Classes/*.h']
  cur.resources = ['WVRUtil/WVRUtil/Classes/nation.db']
  
  cur.dependency 'FMDB'
  cur.dependency 'CocoaHTTPServer'
  end

  s.subspec 'WVRParser' do |cur|
  _WhaleyParser   = { :spec_name => "WVRParseUrl", :source_files => ['WVRParser/WVRParser/Classes/WVRParseUrl/*.{h,m}'], :vendored_frameworks => 'WVRParser/WVRParser/Classes/WVRParseUrl/*.framework' }

    $animations = [_WhaleyParser] #[_Wasu, _WhaleyParser]
    
    $animations.each do |spec|
        cur.subspec spec[:spec_name] do |ss|

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
  
    cur.framework = 'Foundation', 'Security'
    cur.dependency 'PortalIosLibrary/WVRAppContext'
  end

  s.subspec 'WVRCache' do |cur|
  cur.source_files = 'WVRCache/WVRCache/Classes/**/**.{h,m}'

  cur.dependency 'FMDB'
  end

  s.subspec 'WVRImage' do |cur|
    cur.vendored_frameworks = 'WVRImage/WVRImage/Classes/SDWebImage.framework'

  end
  s.subspec 'WVRBI' do |cur|
    cur.source_files = 'WVRBI/WVRBI/Classes/*/**.{h,m}'
    cur.dependency 'UMengAnalytics-NO-IDFA'
    cur.dependency 'YYModel'
    cur.dependency 'PortalIosLibrary/WVRCache'
    cur.dependency 'PortalIosLibrary/WVRAppContext'
  end

  s.subspec 'WVRShare' do |cur|
    cur.source_files = ['WVRShare/WVRShare/Classes/**/*']
    
    cur.dependency 'UMengUShare/UI',             '~> 6.4'
    cur.dependency 'UMengUShare/Social/Sina',    '~> 6.4'
    cur.dependency 'UMengUShare/Social/WeChat',  '~> 6.4'
    cur.dependency 'UMengUShare/Social/QQ',      '~> 6.4'
    cur.dependency 'PortalIosLibrary/WVRBI'
    cur.dependency 'PortalIosLibrary/WVRAppContext'
    # cur.dependency 'PortalIosLibrary/WVRWidget'
  end
  s.subspec 'WVRSocketIO' do |cur|
    cur.vendored_frameworks = ['WVRSocketIO/WVRSocketIO/Classes/SocketIO/SocketIO.framework']
  end
  s.subspec 'WVRNetModel' do |cur|
    cur.source_files = 'WVRNetModel/WVRNetModel/Classes/*.{h,m}'
    cur.requires_arc = true
    cur.dependency 'YYModel'
    cur.dependency 'LKDBHelper'
    cur.dependency 'PortalIosLibrary/WVRUtil'
  end

  # s.subspec 'WVRPlayer' do |cur|
  # cur.source_files = ['WVRPlayer/WVRPlayer/Classes/**/*.{h,m}']

  # cur.vendored_frameworks = ['WVRPlayer/WVRPlayer/Classes/Player/WhaleyVRPlayer.framework']
  # cur.resources = ['WVRPlayer/WVRPlayer/Classes/Player/WVRPlayerBundle.bundle']
  
  # cur.dependency 'WVRBI'
  # cur.dependency 'WVRParser'
  # cur.dependency 'WVRAppContext'
  # end
end

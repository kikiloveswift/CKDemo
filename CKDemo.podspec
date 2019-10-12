Pod::Spec.new do |s|

  s.name         = "CKDemo"
  s.version      = "0.0.1"
  s.summary      = "CKDemo for use"
  s.description  = "CKDemo for use"
  s.homepage     = "https://gitlab.com/konglee873/usercollectionview"
  s.author       = { "konglee873" => "konglee873@gmail.com" }
  s.source       = { :git => "git@github.com:kingleekong/CKDemo.git", :tag => "#{s.version}"}
  s.source_files = [
    "Classes/**/**/*.{swift,h,m,c,mm}",
  ]
  s.resource = 'Resources/*.bundle'
  s.license      = "MIT"
  s.platform     = :ios
  s.ios.deployment_target = '9.0'

  
  s.public_header_files = [
    'Classes/Context/ProductComponentContext.h',
    'Classes/Context/ImageDownloader.h',
  ]
  
  s.requires_arc = true
  
  s.dependency 'Masonry'
  s.dependency 'ReactiveObjC'
  s.dependency 'ComponentKit'
  s.dependency 'SDWebImage'
  s.dependency 'YYModel'
  

end

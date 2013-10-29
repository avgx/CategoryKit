Pod::Spec.new do |s|
  s.name         = "CategoryKit"
  s.version      = "0.0.1"
  s.summary      = "A lot of the useful categories for built-in objective-c classes"
  s.license      = 'MIT'
  s.authors      = { 'Ivan Lisovoy' => 'lisovoy.i@gmail.com', 'Denis Kotenko' => 'd3niskt@gmail.com' }                            
  s.platform     = :ios, '5.0'
  s.homepage     = 'https://github.com/kshin/CategoryKit'
  s.source       = { :git => 'https://github.com/kshin/CategoryKit.git', :tag => 'v0.0.1' }  
  s.source_files = 'CategoryKit', 'CategoryKit/**/*.{h,m}'
  s.requires_arc = true
end

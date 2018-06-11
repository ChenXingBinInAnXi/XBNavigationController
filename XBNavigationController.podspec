Pod::Spec.new do |s|

  s.name         = "XBNavigationController"
  s.version      = "1.0.0"
  s.summary      = "XBNavigationController for html"
  s.description  = <<-DESC
                     here is description
                   DESC
  s.homepage     = "https://github.com/ChenXingBinInAnXi/XBNavigationController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "ChenXingBinInAnXi" => "635824674@qq.com" }
  s.source       = { :git => "https://github.com/ChenXingBinInAnXi/XBNavigationController.git", :tag => s.version }
  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.source_files  = "XBNavigationController/XBNavigationController/*.swift"
end

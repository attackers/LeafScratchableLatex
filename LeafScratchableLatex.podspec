

Pod::Spec.new do |s|

 
  s.name         = "LeafScratchableLatex"
  s.version      = "0.0.7"
  s.summary      = "一个用于做九宫格的手势解锁功能"
  s.description  = <<-DESC
		一个用于做九宫格的手势解锁功能
                   DESC

  s.homepage     = "https://github.com/attackers"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "attackers" => "305296172@qq.com" }

  s.platform     = :ios, "9.0"

  s.ios.deployment_target = "9.0"
 
  s.source       = { :git => "https://github.com/attackers/LeafScratchableLatex.git", :tag => "#{s.version}" }

  s.source_files  = "LeafScratchableLatex", "LeafScratchableLatex/*.{h,swift}"
  s.ios.source_files = "LeafScratchableLatex/*.swift"
  s.frameworks = "UIKit", "CoreGraphics"
  s.swift_version = "4.2"
	
end

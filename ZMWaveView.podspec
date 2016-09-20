
Pod::Spec.new do |s|

s.name         = "ZMWaveView"
s.version      = "0.1.1"
s.summary      = "柱状波形动画"

s.homepage     = "https://github.com/zengxianshu/WaveView"

s.license      = "MIT"

s.author       = { "zengXianShu" => "zengxianshu0@163.com" }
s.platform     = :ios, "9.0"

s.source       = { :git => "https://github.com/zengxianshu/WaveView.git", :tag => s.version }

s.source_files = "Pods/WaveView/*.swift"

s.requires_arc = true

s.xcconfig     = { 'SWIFT_VERSION' => '3.0' }

end

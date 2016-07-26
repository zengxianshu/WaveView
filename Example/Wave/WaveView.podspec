
Pod::Spec.new do |s|

s.name         = "WaveView"
s.version      = "0.0.1"
s.summary      = "柱状波形动画"

s.homepage     = "https://github.com/zengxianshu/Wave_pods"

s.license      = "MIT"

s.author       = { "zengXianShu" => "zengxianshu0@163.com" }
s.platform     = :ios, "8.0"

s.source       = { :git => "https://github.com/zengxianshu/Wave_pods.git", :tag => s.version }

s.source_files  = "Pods/**/*"

s.requires_arc = true

end

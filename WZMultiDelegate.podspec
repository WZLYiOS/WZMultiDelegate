Pod::Spec.new do |spec|

spec.name         = 'WZMultiDelegate'
spec.version      = '1.0.1'
spec.summary      = '多重代理'

spec.description  = <<-DESC
利用消息转发实现多重代理
DESC

spec.homepage     = 'https://github.com/WZLYiOS/WZMultiDelegate'
spec.license      = 'MIT'
spec.author       = { 'qiuqixiang' => '739140860@qq.com' }
spec.source       = { :git => 'https://github.com/WZLYiOS/WZMultiDelegate.git', :tag => spec.version.to_s }

spec.swift_version         = '5.0'
spec.ios.deployment_target = '9.0'
spec.requires_arc = true
spec.static_framework = true

spec.source_files = 'WZMultiDelegate/Core/*.{h,m}'



end

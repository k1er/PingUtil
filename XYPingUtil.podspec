Pod::Spec.new do |s|

s.name                  = 'XYPingUtil'

s.version               = '0.1.1'

s.ios.deployment_target = '8.0'
s.osx.deployment_target = "10.11"

s.license               = 'MIT'

s.homepage              = 'https://github.com/k1er'

s.author                = { "Rudy Yang" => "anke603@163.com" }

s.summary               = '测试ping值的小工具'

s.source                = { :git => 'https://github.com/k1er/PingUtil.git', :tag => s.version }

s.source_files          = "PingUtil/*.{h,m}"

#s.resources             = "XYPingUtil/source.bundle"

s.frameworks            = 'Foundation'

s.library               = 'z'

s.requires_arc          = true

end

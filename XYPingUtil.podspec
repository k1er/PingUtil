Pod::Spec.new do |spec|

spec.name                  = 'SGExtension'

spec.version               = '1.0.2'

spec.ios.deployment_target = '8.0'
spec.osx.deployment_target = "10.11"

spec.license               = 'MIT'

spec.homepage              = 'https://github.com/k1er'

spec.author                = { "Rudy Yang" => "anke603@163.com" }

spec.summary               = '各种工具的合集'

spec.source                = { :git => 'https://github.com/iOSSinger/SGExtension.git', :tag => spec.version }

spec.source_files          = "PingUtil/**/{*.h,*.m}"

#spec.resources             = "SGExtension/source.bundle"

spec.frameworks            = 'Foundation'

spec.library               = 'z'

spec.requires_arc          = true

end

Pod::Spec.new do |s|
    s.name = 'PieceCore'
    s.version = '0.0.1'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.summary = 'This is piece library for iOS.'
    s.homepage = 'https://jokapi.jp'
    s.author = "jokerpiece"
    s.source = { :git => "https://github.com/jokerpiece/PieceCore.git", :tag => "#{s.version}"}
    s.platform  = :ios, "7.0"
    s.source_files = "PieceCore/**/*.{h,m}"
    s.resources = "PieceCore/Resources/**/*.{png, jpg}"
    s.frameworks = 'IOKit', 'QuartzCore','CoreLocation','MapKit'
    s.dependency 'AFNetworking', '> 2'
    s.dependency 'SDWebImage'
    s.dependency 'UIColor+MLPFlatColors'
end

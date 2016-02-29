Pod::Spec.new do |s|
    s.name = 'PieceCore'
    s.version = '0.0.61'
    s.license = { :type => 'GPL v3', :file => 'LICENSE' }
    s.summary = 'This is piece library for iOS.'
    s.homepage = 'https://jokapi.jp'
    s.author = "jokerpiece"
    s.source = { :git => "https://github.com/jokerpiece/PieceCore.git", :tag => "#{s.version}"}
    s.platform  = :ios, "7.0"
    s.source_files = "PieceCore/**/*.{h,m}"
    s.resources = "PieceCore/Resources/**/*.{png, jpg,gif}","PieceCore/**/*.xib"
    s.frameworks = 'IOKit', 'QuartzCore','CoreLocation','MapKit','Social','Accounts'
    s.dependency 'AFNetworking', '2.6.3'
    s.dependency 'UIActivityIndicator-for-SDWebImage'
    s.dependency 'UIColor+MLPFlatColors'
    s.dependency 'SVProgressHUD', '~> 1.0'
    #s.dependency 'Nex8Tracking'
    s.dependency 'HCYoutubeParser'
    s.dependency 'Google/Analytics', '~> 1.0.0'
    s.dependency 'PayPal-iOS-SDK'

end

Pod::Spec.new do |s|
    s.name             = 'FormX'
    s.version          = '0.1.7'
    s.summary          = 'FormX SDK for iOS'
    s.homepage         = 'https://github.com/oursky/formx-sdk'
    s.author           = { 'FormX' => 'hello@formx.ai' }
    s.ios.deployment_target = '11.0'
    s.swift_version = ['5.0', '5.1', '5.2']
    s.dependency "OpenCV", "4.6.0"

    s.source       = { :http => "https://github.com/oursky/formx-sdk/releases/download/0.1.7/FormX.xcframework.zip" }
    s.vendored_frameworks = 'FormX.xcframework'
end

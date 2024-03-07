Pod::Spec.new do |s|
    s.name             = 'FormX'
    s.version          = '0.4.5'
    s.summary          = 'FormX SDK for iOS'
    s.homepage         = 'https://github.com/oursky/formx-sdk'
    s.author           = { 'FormX' => 'hello@formx.ai' }
    s.swift_version = ['5.0', '5.1', '5.2']

    s.source       = { :http => "https://github.com/oursky/formx-sdk/releases/download/0.4.5/FormX.xcframework.zip" }
    s.vendored_frameworks = 'FormX.xcframework'
  
    s.ios.deployment_target = '14.0'
    s.ios.frameworks = ["Accelerate"]
    s.libraries = 'c++'

    s.prepare_command = <<-CMD
        curl -O -L "#{s.source[:http]}"
        unzip -o FormX.xcframework.zip
        rm FormX.xcframework.zip
    CMD
end

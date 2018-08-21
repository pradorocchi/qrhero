Pod::Spec.new do |s|
s.name             = 'QRhero'
s.version          = '1.0.0'
s.summary          = 'QR Code'
s.description      = <<-DESC
Scan and create QR codes
DESC
s.homepage         = 'https://github.com/velvetroom/qrhero'
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { 'iturbide' => 'qrhero@iturbi.de' }
s.platform         = :ios, '9.0'
s.source           = { :git => 'https://github.com/velvetroom/qrhero.git', :tag => "v#{s.version}" }
s.source_files     = 'Source/*.swift'
s.swift_version    = '4.2'
s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
s.prefix_header_file = false
s.static_framework = true
end

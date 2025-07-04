Pod::Spec.new do |spec|
  spec.name             = 'bureau-id-fraud-sdk'
  spec.version          = '2.0.4'
  
  spec.summary          = 'Identify and prevent fraudulent activity accurately and immediately.'
  spec.description      = 'Device Fingerprinting helps you understand your user’s unique harware with their device data & processes them in backend to generate a fingerprint id.'
  
  spec.homepage         = 'https://www.bureau.id/products/bureau-device-intelligence-behaviorial-biometrics'
  spec.license = 'MIT'
  spec.authors          = {'Bureau-Inc' => 'techops@bureau.id'}
  spec.ios.deployment_target = "12.0"

  spec.source           = { :git => 'https://github.com/Bureau-Inc/bureau-id-fraud-sdk.git', :tag => spec.version.to_s }
  
  spec.vendored_frameworks = '**/*.xcframework'
  spec.swift_version = '5.0'
  
  spec.dependency 'Sentry'
  spec.dependency 'SwiftProtobuf', '>= 1.20.0', '< 2.0'


  
end

Pod::Spec.new do |spec|
  spec.name             = 'bureau-id-fraud-sdk'
  spec.version          = '1.0.0'
  spec.homepage         = 'https://github.com/Bureau-Inc/bureau-id-fraud-sdk.git'
  spec.authors          = {'Bureau-Inc' => 'techops@bureau.id'}
  spec.summary          = 'Device Fingerprinting helps you understand your user’s unique harware with their device data. It efficiently syncs the data in the background, processes them and the data processed can be used to generate a fingerprint id.'
  spec.source           = { :git => 'https://github.com/Bureau-Inc/bureau-id-fraud-sdk.git', :tag => spec.version.to_s }
  spec.vendored_frameworks = '**/*.xcframework'
  spec.dependency 'Sentry', '8.21.0'
  spec.dependency 'SwiftProtobuf', '1.25.2'
  spec.ios.deployment_target = "11.0"
end

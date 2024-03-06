#
# Be sure to run `pod lib lint SwiftyArchitectureMacros.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyArchitectureMacros'
  s.version          = '0.1.0'
  s.summary          = 'Swift macros provided by SwiftArchitecture.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Mioke/SwiftyArchitectureMacros'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Klein' => 'mioke0428@gmail.com' }
  s.source           = { :git => 'https://github.com/Mioke/SwiftyArchitectureMacros.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_versions = '5.9'

  s.preserve_paths = 'Package.swift', 'Products/**/*', 'Sources/**/*', 'Tests/**/*'

  product_folder = "${PODS_BUILD_DIR}/Products/SwiftyArchitectureMacros"

  # --sdk \\"`xcrun --show-sdk-path`\\"
  script = <<-SCRIPT.squish
  env -i PATH="$PATH" "$SHELL" -l -c
  "swift build -c release --product SwiftyArchitectureMacros
  --package-path \\"$PODS_TARGET_SRCROOT\\"
  --scratch-path \\"#{product_folder}\\""
  SCRIPT

  s.script_phase = {
    :name => 'Build SwiftyArchitectureMacros macro plugin',
    :script => script,
    :input_files => Dir.glob("{Package.swift, Sources/**/*}").map {
      |path| "$(PODS_TARGET_SRCROOT)/#{path}"
    },
    :output_files => ["#{product_folder}/release/SwiftyArchitectureMacros"],
    :execution_position => :before_compile
  }

  xcode_config = {
    'OTHER_SWIFT_FLAGS' => <<-FLAGS.squish
    -Xfrontend -load-plugin-executable
    -Xfrontend #{product_folder}/release/SwiftyArchitectureMacros#SwiftyArchitectureMacros
    FLAGS
  }
  s.user_target_xcconfig = xcode_config # <-- add to the `Host project`.
#  s.pod_target_xcconfig = xcode_config

  # s.resource_bundles = {
  #   'SwiftyArchitectureMacros' => ['SwiftyArchitectureMacros/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

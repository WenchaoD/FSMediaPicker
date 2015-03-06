#
# Be sure to run `pod lib lint FSMediaPicker.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FSMediaPicker"
  s.version          = "0.0.1"
  s.summary          = "Use the smallest code to pick image and video"
 s.description       = "An integration of UIActionSheet, UIAlertController and UIImagePickerController which allows you to pick media(image/video) effortlessly, with cirlular crop supported, and written in Objective-C"
  s.homepage         = "https://github.com/f33chobits/FSMediaPicker"
  s.screenshots      = "https://cloud.githubusercontent.com/assets/5186464/6525012/1544d590-c43b-11e4-8ed2-8cf8eef14009.gif", "https://cloud.githubusercontent.com/assets/5186464/6524931/11bfd51a-c43a-11e4-8197-ced99a29df69.gif","https://cloud.githubusercontent.com/assets/5186464/6525058/bc2e6736-c43b-11e4-811c-5d3f3ba82e26.png","https://cloud.githubusercontent.com/assets/5186464/6525153/0de85dec-c43d-11e4-9b73-298bd2fa9b9a.png"
  s.license          = 'MIT'
  s.author           = { "Wenchao Ding" => "f33chobits@gmail.com" }
  s.source           = { :git => "https://github.com/f33chobits/FSMediaPicker.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FSMediaPicker' => ['Pod/Assets/*']
  }

  s.frameworks = 'UIKit', 'MobileCoreServices'

end

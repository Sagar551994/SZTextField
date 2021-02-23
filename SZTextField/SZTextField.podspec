#
#  Be sure to run `pod s lint SZTextField.pods' to ensure this is a
#  valid s and to remove all comments including this before submitting the s.
#
#  To learn more about Pods attributes see https://guides.cocoapods.org/syntax/pods.html
#  To see working Podss in the CocoaPods repo see https://github.com/CocoaPods/ss/
#

Pod::Spec.new do |s|

  s.name         = "SZTextField"
  s.version      = "1.0.0"
  s.summary      = "'SZTextField' is lightweight SwiftUI framework"
  s.description  = <<-DESC
  'SZTextField' is lightweight SwiftUI framework, that allows to create bottom line to round rectangle shap and customisable floating label textfield!
                   DESC

  s.homepage     = "https://github.com/Sagar551994/SZTextField"
  s.license      = "MIT"
  s.author             = { "Sagar Zalavadiya" => "sagar.zalavadiya5@gmail.com" }
  s.source       = { :git => "https://github.com/Sagar551994/SZTextField.git", :tag => "#{s.version}" }
  s.social_media_url   = "https://www.instagram.com/mr.iosdeveloper"
  
  s.ios.deployment_target = "13.0"
  s.source_files = 'SZTextField/**/*.swift'

  s.swift_version = '5.0'
  s.platforms = {
      "ios": "13.0"
  }

end

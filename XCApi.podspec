Pod::Spec.new do |spec|
  spec.name = "XCApi"
  spec.version = "1.0.0"
  spec.summary = "XCBusiness app service Api."
  spec.homepage = "https://github.com/cstars135/XCApi"
  spec.license = { :type => 'MIT', :file  => 'LICENSE' }
  spec.authors = { "Cstars" => "cstars135@163.com" }

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { :path => "." }
  spec.source_files = "Source/**/*.{h,swift}"

  spec.dependency "ReactiveSwift", "~> 1.0.0"
  spec.dependency "SwiftyJSON", "~> 3.1.4"
  spec.dependency "Alamofire", "~> 4.4"
end

Pod::Spec.new do |s|
  s.name             = 'FAParser'
  s.version          = '0.1.0'
  s.summary          = 'JSON Parsing technique using Key Value Coding.'

  s.description      = <<-DESC
1. You can parse JSON using this technique with minimum lines of code.
2. You can archive and unarchive a custom object in User Defaults with minimum lines of code.
                       DESC

  s.homepage         = 'https://github.com/fahidattique55/FAParser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fahid Attique' => 'fahidattique55@gmail.com' }
  s.source           = { :git => 'https://github.com/fahidattique55/FAParser.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'FAParser/Classes/**/*'
  

end

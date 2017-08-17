Pod::Spec.new do |s|
    s.name          =  'TamStatusBarAlertView'
    s.version       =  '0.0.1'
    s.summary       =  'A short description of TamStatusBarAlertView.'
    s.homepage      =  'https://github.com/thatha123/TamStatusBarAlertView'
    s.license       =  'MIT'
    s.authors       = {'Tam' => '1558842407@qq.com'}
    s.platform      =  :ios,'8.0'
    s.source        = {:git => 'https://github.com/thatha123/TamStatusBarAlertView.git',:tag => "v#{s.version}" }
    s.source_files  =  'TamStatusBarAlertViewDemo/TamStatusBarAlertView/*.{h,m}'
    s.requires_arc  =  true
end

  

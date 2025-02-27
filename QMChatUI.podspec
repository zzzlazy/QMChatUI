
#
# Be sure to run `pod lib lint QMChatUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QMChatUI'
  s.version          = '0.5'
  s.summary          = 'A short description of QMChatUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/7moor-tech/QMChatUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '焦林生' => '18515384635@163.com' }
  s.source           = { :git => 'https://github.com/7moor-tech/QMChatUI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  
   s.static_framework = true
   s.requires_arc = true
   s.frameworks = 'UIKit'
   s.dependency 'QMUIComponent', '~> 0.3'
   s.dependency 'QMLineSDK'
   
  s.subspec 'Cell' do |cell|
      cell.source_files = 'QMChatUI/Classes/Cell/*.{h,m}'
      cell.dependency 'QMChatUI/Vendors'
      cell.dependency 'QMChatUI/Models'
     cell.dependency 'QMChatUI/View/CommonProblem'
     cell.dependency 'QMChatUI/View/msgTask'
     cell.dependency 'QMChatUI/View/QMFormView'
     cell.dependency 'QMChatUI/ViewController/QMImageWithWebPage'
  end
  
  s.subspec 'Models' do |model|
       model.source_files = 'QMChatUI/Classes/Models/*.{h,m}'
  end
  
  s.subspec 'Vendors' do |vendor|
    vendor.subspec 'EmojiLabel' do |label|
       label.source_files = 'QMChatUI/Classes/Vendors/EmojiLabel/*.{h,m}'
    end
    vendor.subspec 'Voice' do |voice|
        voice.vendored_libraries = ['QMChatUI/Classes/Vendors/Voice/*.a']
        voice.source_files = 'QMChatUI/Classes/Vendors/Voice/*.{h,m}'
    end
      
  end
  
  s.subspec 'View' do |view|
    view.subspec 'CommonProblem' do |problem|
        problem.source_files = 'QMChatUI/Classes/View/CommonProblem/*.{h,m}'
    end
    view.subspec 'msgTask' do |task|
        task.source_files = 'QMChatUI/Classes/View/msgTask/*.{h,m}'
        task.dependency 'QMChatUI/ViewController/QMImageWithWebPage'
        task.dependency 'QMChatUI/Models'
        task.dependency 'QMChatUI/Vendors'
    end
    view.subspec 'QMChatView' do |chatView|
        chatView.source_files = 'QMChatUI/Classes/View/QMChatView/*.{h,m}'
        chatView.dependency 'QMChatUI/ViewController/QMImageWithWebPage'
        chatView.dependency 'QMChatUI/Cell'
    end
    view.subspec 'QMFormView' do |formView|
        formView.source_files = 'QMChatUI/Classes/View/QMFormView/*.{h,m}'
        formView.dependency 'QMChatUI/ViewController/QMImageWithWebPage'
    end
       
  end
  
  s.subspec 'ViewController' do |vc|
    vc.subspec 'QMChatPage' do |chat|
        chat.source_files = 'QMChatUI/Classes/ViewController/QMChatPage/*.{h,m}'
        chat.dependency 'QMChatUI/Vendors'
        chat.dependency 'QMChatUI/Models'
        chat.dependency 'QMChatUI/Cell'
        chat.dependency 'QMChatUI/View'
    end
    vc.subspec 'QMImageWithWebPage' do |page|
        page.source_files = 'QMChatUI/Classes/ViewController/QMImageWithWebPage/*.{h,m}'
    end
        
  end
  
 s.resource = [
    'QMChatUI/Assets/*.bundle'
 ]
         
   s.pod_target_xcconfig = {'VALID_ARCHS'=>'armv7 x86_64 arm64'}
   
   
   #pod trunk push QMChatUI.podspec --allow-warnings
end

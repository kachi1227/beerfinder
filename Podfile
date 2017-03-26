# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

workspace 'Beerfinder.xcworkspace'
inhibit_all_warnings!
use_frameworks!

def shared_pods
    pod 'Firebase'
    pod 'FirebaseMessaging'
    pod 'Firebase/Auth'
    pod 'AFNetworking'
    pod 'MMDrawerController', '0.6'
    pod 'TSMessages'
    pod 'FBSDKCoreKit'
    pod 'SwiftyJSON'
    pod 'GoogleSignIn'
end

project 'Beerfinder.xcodeproj'
project 'BeerFinderiPad/BeerFinderiPad.xcodeproj'

target 'Beerfinder' do
    project 'Beerfinder'
    shared_pods
end

target 'BeerFinderiPad' do
    project 'BeerFinderiPad/BeerFinderiPad.xcodeproj'
    shared_pods
end

#target 'Beerfinder' do
#  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
#  use_frameworks!
#
#  # Pods for Beerfinder
#    pod 'Firebase'
#    pod 'FirebaseMessaging'
#    pod 'AFNetworking'
#    pod 'MMDrawerController', '0.6'
#    pod 'TSMessages'
#    pod 'FBSDKCoreKit'
#    pod 'SwiftyJSON'
#end

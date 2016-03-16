//
//  YonaInitializer.swift
//  Yona
//
//  Created by Ben Smith on 15/03/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//
import XCTest
import Foundation
class YonaInitializer: NSObject {
    class func YonaSwiftInit()
    {
        var application : XCUIApplication!
        //A closure that will be executed just before executing any of your features
        beforeStart { () -> Void in
            application = XCUIApplication()
        }
        //A Given step definition
        Given("the VPN has not started") { (args, userInfo) -> Void in
            application.launch()
        }
        //Another step definition
        And("I press the button") { (args, userInfo) -> Void in
            //Assume you defined an "I tap on \"(.*)\" button" step previousely, you can call it from your code as well.
            SStep("I tap the \"Clear All Data\" button")
        }
        //Tell Cucumberish the name of your features folder and let it execute them for you...
        Cucumberish.executeFeaturesInDirectory("ExampleFeatures", featureTags: nil)
    }
}
//
//  YonaInitializer.m
//  Yona
//
//  Created by Ben Smith on 15/03/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

//Replace CucumberishExampleUITests with the name of your swift test target
#import "YonaUITests-Bridging-Header.h"
#import "YonaInitializer.swift"

__attribute__((constructor))
void YonaInit()
{
    [YonaInitializer YonaSwiftInit];
}
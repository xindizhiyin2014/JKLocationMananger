//
//  Tool.m
//  JKLocationMananger_Example
//
//  Created by JackLee on 2019/3/20.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

#import "Tool.h"
#import <JKLocationMananger/JKLocationMananger-Swift.h>
@implementation Tool
+ (void)location{
// [JKLocationMananger ]
    
    [JKLocationMananger startLocateWithSuccess:^(NSString * latitude, NSString * longitude) {
        NSLog(@"%@,%@",latitude,longitude);
    } failure:^(NSError * error) {
        NSLog(@"AAA %@",error);
    }];
    
//    [JKLocationMananger locateCityWithSuccess:^(NSString * city) {
//        NSLog(@"city %@",city);
//    } failure:^(NSError * error) {
//        NSLog(@"error %@",error);
//    }];
    
}
@end

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
    [JKLocationMananger locateWithSuccess:^(NSString * city) {
        NSLog(@"AAA %@",city);
    } failure:^(NSError * error) {
        NSLog(@"%@",error);
    }];
}
@end

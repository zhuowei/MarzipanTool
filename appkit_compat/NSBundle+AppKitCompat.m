//
//  NSBundle+NSBundle_AppKitCompat.m
//  HelloMarzipanObjC
//
//  Created by Zhuowei Zhang on 2018-06-06.
//  Copyright © 2018 Zhuowei Zhang. All rights reserved.
//  SPDX-License-Identifier: MIT
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AppKitCompat)
+ (nullable NSString*)currentStringsTableName;
@end

NS_ASSUME_NONNULL_END

@implementation NSBundle (AppKitCompat)
+ (nullable NSString*)currentStringsTableName {
    NSLog(@"Tried to get strings table name; returning nil!");
    return nil;
}
@end

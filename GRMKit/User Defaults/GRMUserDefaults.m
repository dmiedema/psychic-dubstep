//
//  GRMUserDefaults.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMUserDefaults.h"

NSString * const GRMUserDefaultsLatestTappedSuiteName = @"group.GrowlMovement.GMTaplist.LatestTapped";
NSString * const GRMUserDefaultsUserID                = @"GRMUserDefaultsUserID";
NSString * const GRMUserDefaultsLatestTappedStoreID   = @"GRMUserDefaultsLatestTappedStoreID";

@interface GRMUserDefaults()
+ (NSArray *)allSuites;
@end

@implementation GRMUserDefaults
+ (instancetype)latestTappedSuite{
    static GRMUserDefaults *defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[GRMUserDefaults alloc] initWithSuiteName:@""];
    });
    return defaults;
}

+ (void)setObjectInAllSuites:(id)obj forKey:(NSString *)key {
    for (NSUserDefaults *suite in [self allSuites]) {
        [suite setObject:obj forKey:key];
        [suite synchronize];
    }
}

#pragma mark - Private
+ (NSArray *)allSuites {
    static NSArray *suites = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        suites = @[[NSUserDefaults standardUserDefaults], [GRMUserDefaults latestTappedSuite]];
    });
    return suites;
}
@end

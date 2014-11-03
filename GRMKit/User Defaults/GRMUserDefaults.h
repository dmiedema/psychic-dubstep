//
//  GRMUserDefaults.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRMConstants.h"

/**
 *  User defaults suite name corresponding to app group
 */
extern NSString * const GRMUserDefaultsLatestTappedSuiteName;

/**
 *  Key to get users ID
 */
extern NSString * const GRMUserDefaultsUserID;

/**
 *  Key to get users preferred store ID for widget
 */
extern NSString * const GRMUserDefaultsLatestTappedStoreID;


@interface GRMUserDefaults : NSUserDefaults
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)latestTappedSuite;

/**
 *  Set an object in all the suites for a specific key
 *
 *  @param obj to set
 *  @param key to use
 */
+ (void)setObjectInAllSuites:(id)obj forKey:(NSString *)key;
@end

//
//  GRMBaseObject.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
#import <objc/runtime.h>

@implementation GRMBaseObject
+ (NSString *)primaryKey {
    return [[[NSStringFromClass(self.class) substringFromIndex:3] lowercaseString] stringByAppendingString:@"_id"];
}
@end

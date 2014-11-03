//
//  GRMAPI.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMAPI.h"

@implementation GRMAPI
+ (instancetype)manager {
    static GRMAPI *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return shared;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
    }
    return self;
}
@end

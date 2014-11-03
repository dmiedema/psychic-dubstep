//
//  GRMAPI.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMAPI.h"
#import "GRMConstants.h"

@implementation GRMAPI
+ (instancetype)manager {
    static GRMAPI *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] initWithBaseURL:[NSURL URLWithString:GRMAPIBaseURL]];
    });
    return shared;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.requestSerializer  = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setValue:GRMAPIHeaderValue forHTTPHeaderField:GRMAPIHeaderKey];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return self;
}
@end

//
//  GRMDevice.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
@class GRMUser;

@interface GRMDevice : GRMBaseObject

@property NSInteger device_id;

@property NSString *displayName;
@property NSString *push_token;
@property GRMUser *user;

@end

RLM_ARRAY_TYPE(GRMDevice)

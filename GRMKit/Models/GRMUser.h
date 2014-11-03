//
//  GRMUser.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
#import "GRMReview.h"
#import "GRMDevice.h"

@interface GRMUser : GRMBaseObject

@property NSInteger user_id;

@property NSData *avatar;
@property NSString *email;
@property NSString *udid;
@property NSString *username;

@property RLMArray<GRMDevice> *devices;
@property RLMArray<GRMReview> *reviews;

@end

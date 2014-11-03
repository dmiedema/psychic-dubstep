//
//  GRMStore.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"

@interface GRMStore : GRMBaseObject

@property NSInteger store_id;

@property BOOL active;
@property NSString *address;
@property NSString *city;
@property NSString *hours;
@property NSString *ip_address;
@property double latitude;
@property double longitude;
@property NSString *name;
@property NSString *nearby;
@property NSInteger number_of_taps;
@property NSString *phone;
@property NSString *postal_code;
@property NSString *state;


@end

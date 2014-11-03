//
//  GRMBaseObject.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

@interface GRMBaseObject : RLMObject
@property (strong, nonatomic) NSDate *last_updated;
@end

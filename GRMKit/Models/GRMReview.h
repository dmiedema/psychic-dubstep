//
//  GRMReview.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
@class GRMBeer, GRMUser;

@interface GRMReview : GRMBaseObject

@property NSInteger review_id;
@property NSInteger rating;
@property NSString *text;
@property GRMBeer *beer;
@property GRMUser *user;

@end

RLM_ARRAY_TYPE(GRMReview)

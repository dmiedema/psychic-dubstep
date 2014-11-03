//
//  GRMBeer.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
@class GRMBrewery, GRMReview, GRMStyle;

@interface GRMBeer : GRMBaseObject

@property NSInteger beer_id;

@property double abv;
@property double amount;
@property NSString *beer_description;
@property BOOL * favorite;
@property double growler_price;
@property double growlette_price;
@property double halfpint_price;
@property double *ibu;
@property NSString *name;
@property double pint_price;
@property BOOL purchased;
@property NSInteger tap_id;
@property GRMBrewery *brewery;
@property GRMReview *review;
@property GRMStyle *style;

@end

RLM_ARRAY_TYPE(GRMBeer)

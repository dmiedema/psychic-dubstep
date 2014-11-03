//
//  GRMBrewery.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
#import "GRMBeer.h"

@interface GRMBrewery : GRMBaseObject

@property NSInteger brewery_id;

@property NSString * city;
@property NSString *logo_url;
@property NSString *name;
@property NSString *state;

@property RLMArray<GRMBeer> *beers;

@end


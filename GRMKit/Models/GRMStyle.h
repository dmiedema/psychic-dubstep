//
//  GRMStyle.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBaseObject.h"
#import "GRMBeer.h"

@interface GRMStyle : GRMBaseObject

@property NSInteger style_id;

@property NSString *style;

@property RLMArray<GRMBeer> *beers;

@end

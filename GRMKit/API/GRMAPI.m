//
//  GRMAPI.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMAPI.h"
#import "GRMConstants.h"
#import "GRMUserDefaults.h"

@interface GRMAPI()
- (NSError *)errorForNoUserOrPushTokenStored;
- (id)extractDataFromResponse:(id)response;
- (NSString *)dateComponentsInURLFormat:(NSDate *)date;
@end

@implementation GRMAPI

#pragma mark - Init
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

#pragma mark - Implementation
#pragma mark (un)Favoriting
- (void)favoriteBeer:(NSNumber *)beerID completion:(GRMAPIBooleanResponseBlock)completion {
    NSNumber *userID = [NSNumber numberWithInteger:[[GRMUserDefaults standardUserDefaults] integerForKey:GRMUserDefaultsUserID]];
    NSString *token = [[GRMUserDefaults standardUserDefaults] stringForKey:GRMUserDefaultsPushToken];
    
    if (!token || !userID) {
        if (completion) {
            completion(NO, [self errorForNoUserOrPushTokenStored]);
        }
    }
    
    NSDictionary *params = @{@"user_id": userID, @"beer_id": beerID};
    
    [self POST:@"favorite" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) { completion(YES, nil); }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(NO, error); }
    }];
}
- (void)unfavoriteBeer:(NSNumber *)beerID completion:(GRMAPIBooleanResponseBlock)completion {
    NSNumber *userID = [NSNumber numberWithInteger:[[GRMUserDefaults standardUserDefaults] integerForKey:GRMUserDefaultsUserID]];
    NSString *token = [[GRMUserDefaults standardUserDefaults] stringForKey:GRMUserDefaultsPushToken];
    
    if (!token || !userID) {
        if (completion) {
            completion(NO, [self errorForNoUserOrPushTokenStored]);
        }
    }
    
    NSDictionary *params = @{@"user_id": userID, @"beer_id": beerID};
    
    [self POST:@"unfavorite" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) { completion(YES, nil); }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(NO, error); }
    }];
}

#pragma mark Beers
- (void)beerDetails:(NSNumber *)beerID completion:(GRMAPISingleObjectResponseBlock)completion {
    NSString *url = [NSString stringWithFormat:@"beers/%@", beerID];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) { completion([self extractDataFromResponse:responseObject], nil); }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}
- (void)loadAllBeers:(NSDate *)sinceDate completion:(GRMAPIMultipleObjectResponseBlock)completion {
    NSString *url = @"beers";
    
    if (sinceDate) {
        url = [url stringByAppendingString:[self dateComponentsInURLFormat:sinceDate]];
    }
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion([self extractDataFromResponse:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}
- (void)beersForBrewery:(NSNumber *)breweryID completion:(GRMAPIMultipleObjectResponseBlock)completion {
    NSParameterAssert(breweryID);
    
    NSString *url = [NSString stringWithFormat:@"breweries/%@/beers", breweryID];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *beers = [[self extractDataFromResponse:responseObject] valueForKey:@"brews"];
        
        if (completion) { completion(beers, nil); }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}
- (void)beersOnTapForStore:(NSNumber *)storeID completion:(GRMAPIMultipleObjectResponseBlock)completion {
    NSParameterAssert(storeID);
    
    NSString *url = [NSString stringWithFormat:@"stores/%@/ontap", storeID];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *beers = [self extractDataFromResponse:responseObject];
        if (completion) { completion(beers, nil); }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}
- (void)lastTappedBeerForStore:(NSNumber *)storeID completion:(GRMAPISingleObjectResponseBlock)completion {
    
    
//    if (completion) { completion(nil, error); }
}

#pragma mark Brewery
- (void)breweryDetails:(NSNumber *)breweryID completion:(GRMAPISingleObjectResponseBlock)completion {
    NSParameterAssert(breweryID);
    
    NSString *url = [NSString stringWithFormat:@"breweries/%@", breweryID];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion([self extractDataFromResponse:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}
- (void)loadAllBreweries:(NSDate *)sinceDate completion:(GRMAPIMultipleObjectResponseBlock)completion {
    NSString *url = @"breweries";
    
    if (sinceDate) {
        [url stringByAppendingString:[self dateComponentsInURLFormat:sinceDate]];
    }
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion([self extractDataFromResponse:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}

#pragma mark Stores
- (void)loadAllStores:(GRMAPIMultipleObjectResponseBlock)completion {
    NSString *url = @"stores";
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion([self extractDataFromResponse:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}
- (void)storeDetails:(NSNumber *)storeID completion:(GRMAPISingleObjectResponseBlock)completion {
    NSParameterAssert(storeID);
    NSString *url = [NSString stringWithFormat:@"stores/%@", storeID];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion([self extractDataFromResponse:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}

#pragma mark User & Registration
- (void)registerUserWithToken:(NSString *)token completion:(GRMAPISingleObjectResponseBlock)completion {
    NSParameterAssert(token);
    NSString *url = @"users";
    
    NSNumber *userID = [NSNumber numberWithInteger:[[GRMUserDefaults standardUserDefaults] integerForKey:GRMUserDefaultsUserID]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"user_token": token}];
    if (userID) {
        [params addEntriesFromDictionary:@{@"user_id": userID}];
    }
    
    [self POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) { completion(nil, error); }
    }];
}

#pragma mark - Private
- (NSError *)errorForNoUserOrPushTokenStored {
    return [NSError errorWithDomain:@"com.GrowlMovement.GMTaplist" code:-5081 userInfo:@{}];
    return nil;
}
- (id)extractDataFromResponse:(id)response {
    return [response valueForKey:@"data"];
}
- (NSString *)dateComponentsInURLFormat:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [NSString stringWithFormat:@"/%@/%@/%@", @(components.year), @(components.month), @(components.day)];
}
@end

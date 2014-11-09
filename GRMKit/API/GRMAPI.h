//
//  GRMAPI.h
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "AFHTTPSessionManager.h"

/**
 *  Block defined for when a single object is expected as the result of an API call
 *
 *  @param NSDictionary Single JSON object returned
 *  @param NSError      Error object in case something with wrong. @c nil if everything went ok
 */
typedef void(^GRMAPISingleObjectResponseBlock)(NSDictionary *, NSError *);
/**
 *  Block defined for when a collection of objects is expected as the result fo an API call.
 *
 *  @param NSArray Collection of JSON objects returned from API
 *  @param NSError Error object in case something with wrong. @c nil if everything went ok
 */
typedef void(^GRMAPIMultipleObjectResponseBlock)(NSArray *, NSError *);
/**
 *  Block defined for when the response of the API call isn't really cared about and mostly the status code is what we want.
 *
 *  @param BOOL    @c YES if the call was a success, @c NO otherwise
 *  @param NSError Error object in case something with wrong. @c nil if everything went ok
 */
typedef void(^GRMAPIBooleanResponseBlock)(BOOL, NSError *);

@interface GRMAPI : AFHTTPSessionManager

#pragma mark - (un)Favoriting
/**
 *  Favorite a beer when a specific ID
 *
 *  @discussion This will load the current user ID if there is one from GRMUserDefaults. If there is no user ID this will fail.
 *
 *  @param beerID     ID to favorite
 *  @param completion GRMAPIBooleanResponseBlock to execute once call completes
 */
- (void)favoriteBeer:(NSNumber *)beerID completion:(GRMAPIBooleanResponseBlock)completion;

/**
 *  Unfavorite a beer with a specific ID
 *
 *  *  @discussion This will load the current user ID if there is one from GRMUserDefaults. If there is no user ID this will fail.
 *
 *  @param beerID     ID to unfavorite
 *  @param completion GRMAPIBooleanResponseBlock to execute once call completes
 */
- (void)unfavoriteBeer:(NSNumber *)beerID completion:(GRMAPIBooleanResponseBlock)completion;

#pragma mark - User & Registration
/**
 *  Register a new user or add a token to an existing user.
 *
 *  @discussion This will load the current user ID if there is one from GRMUserDefaults & will also load the devices current name from @c UIDevice
 *
 *  @param token      APNS Push token to register
 *  @param completion GRMAPISingleObjectResponseBlock containing user object to execute once call completes
 */
- (void)registerUserWithToken:(NSString *)token completion:(GRMAPISingleObjectResponseBlock)completion;

#pragma mark - Beer Actions
/**
 *  Load details about a specific beer
 *
 *  @param beerID     beer ID to load details for
 *  @param completion GRMAPISingleObjectResponseBlock containing beer object/data to execute once call completes
 */
- (void)beerDetails:(NSNumber *)beerID completion:(GRMAPISingleObjectResponseBlock)completion;

/**
 *  Load all beer data. This call can optionally be restricted to all data that has been created/updated after a specified date
 *
 *  @discussion the since date is available to keep the call as light as possible. The API will only respond with beers that have been updated on or after the since date 
 *
 *  @param sinceDate  date of last request to beers. This parameter may be @c nil
 *  @param completion GRMAPIMultipleObjectResponseBlock containing all beer objects/data that have been created/updated after the @c sinceDate (if one was included). If @c sinceDate was nil, it will include all the avaiable beer data.
 */
- (void)loadAllBeers:(NSDate *)sinceDate completion:(GRMAPIMultipleObjectResponseBlock)completion;

#pragma mark Brewery / Store
/**
 *  Load all beers for a specific brewery
 *
 *  @param breweryID  brewery ID to load beers for
 *  @param completion GRMAPIMultipleObjectResponseBlock containing all beers the specified brewery has
 */
- (void)beersForBrewery:(NSNumber *)breweryID  completion:(GRMAPIMultipleObjectResponseBlock)completion;

/**
 *  Load all beers on tap for a specific store
 *
 *  @param storeID    store ID to load beers for
 *  @param completion GRMAPIMultipleObjectResponseBlock containing all beers on tap for specified store along with tap levels & tap number
 */
- (void)beersOnTapForStore:(NSNumber *)storeID completion:(GRMAPIMultipleObjectResponseBlock)completion;

/**
 *  Load latest tapped beer information for specific store
 *
 *  @param storeID    store ID to load latest tapped beer for
 *  @param completion GRMAPISingleObjectResponseBlock containing latest beer ID that was tapped at specified store
 */
- (void)lastTappedBeerForStore:(NSNumber *)storeID completion:(GRMAPISingleObjectResponseBlock)completion;

#pragma mark - Store Actions
/**
 *  Load information about all available stores
 *
 *  @param completion GRMAPIMultipleObjectResponseBlock containing all the information about all the available stores
 */
- (void)loadAllStores:(GRMAPIMultipleObjectResponseBlock)completion;

/**
 *  Load details about a specific store ID
 *
 *  @param storeID    store ID to load
 *  @param completion GRMAPISingleObjectResponseBlock containing all the information about the specified store
 */
- (void)storeDetails:(NSNumber *)storeID completion:(GRMAPISingleObjectResponseBlock)completion;

#pragma mark - Brewery Actions
/**
 *  Load all brewery data. This call can optionally be restricted to all data that has been created/updated after a specified date
 *
 *  @discussion the since date is available to keep the call as light as possible. The API will only respond with breweries that have been updated on or after the since date
 *
 *  @param sinceDate  date of last request to breweries. This parameter may be @c nil
 *  @param completion GRMAPIMultipleObjectResponseBlock containing all brewery objects/data that have been created/updated after the @c sinceDate (if one was included). If @c sinceDate was nil, it will include all the avaiable brewery data.
 */
- (void)loadAllBreweries:(NSDate *)sinceDate completion:(GRMAPIMultipleObjectResponseBlock)completion;

/**
 *  Load details about specific brewery
 *
 *  @param breweryID  brewery ID to load information for
 *  @param completion GRMAPISingleObjectResponseBlock containing all the information about the specified brewery
 */
- (void)breweryDetails:(NSNumber *)breweryID completion:(GRMAPISingleObjectResponseBlock)completion;

@end

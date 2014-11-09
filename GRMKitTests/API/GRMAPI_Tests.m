//
//  GRMAPI_Tests.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/8/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GRMAPI.h"

@interface GRMAPI (Tests)
- (NSError *)errorForNoUserOrPushTokenStored;
- (id)extractDataFromResponse:(id)response;
- (NSString *)dateComponentsInURLFormat:(NSDate *)date;
@end

@interface GRMAPI_Tests : XCTestCase
@end

@implementation GRMAPI_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_errorForNoUserOrPush_isFormattedCorrectly {
    NSError *error = [[GRMAPI manager] errorForNoUserOrPushTokenStored];
    
    XCTAssertEqual(error.code, -5081, @"error code should be -5081. Instead was %li", (long)error.code);
    XCTAssertTrue([@"com.GrowlMovement.GMTaplist" isEqualToString:error.domain], @"error.domain should be 'com.GrowlMovement.GMTaplist'. Instead was %@", error.domain);
}
- (void)test_extractDataFromResponse {
    NSDictionary *data = [[GRMAPI manager] extractDataFromResponse:[self data]];
    
    XCTAssertNotNil(data, @"value extracted from response should not be nil");
    XCTAssertTrue([data isKindOfClass:NSDictionary.class], @"extracted value should be a dictionary");
}
- (void)test_dateComponentsInURLFormat {
    // sec * min * hours * days * number of years I want
    NSTimeInterval time = 60 * 60 * 24 * 365 * 13.5;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:time];
    // This gives me 2014-06-29
    NSString *formatted = [[GRMAPI manager] dateComponentsInURLFormat:date];
    
    XCTAssertTrue([@"/2014/6/29" isEqualToString:formatted], @"dateComponentsInURLFormat should return items in the order of /[year]/[month]/[day]. Instead was %@", formatted);
}

- (NSDictionary *)data {
    return @{
        @"data": @{
            @"ActiveStatus": @"1",
            @"BrewABV": @"4.5",
            @"BrewDescription": [NSNull null],
            @"BrewFG": [NSNull null],
            @"BrewHops": [NSNull null],
            @"BrewIBU": @"18",
            @"BrewLogo": [NSNull null],
            @"BrewMalts": [NSNull null],
            @"BrewName": @"#4",
            @"BrewOG": [NSNull null],
            @"BrewSRM": [NSNull null],
            @"LastModChange": @"Brew edited.",
            @"LastModTime": @"2014-06-02 17:09:27",
            @"breweriesID": @"184",
            @"brewery": @{
                @"ActiveStatus": @"1",
                @"BreweryCity": @"Portland",
                @"BreweryLogo": [NSNull null],
                @"BreweryName": @"Upright",
                @"BreweryState": @"OR",
                @"BreweryURL": @"www.uprightbrewing.com",
                @"LastModChange": @"Transferred from old kegtable DB",
                @"LastModTime": @"2014-05-25 09:09:21",
                @"id": @"184"
            },
            @"id": @"1",
            @"style": @{
                @"ActiveStatus": @"1",
                @"AddTime": @"2013-08-01 20:37:12",
                @"LastModChange": @"Transferred from old kegtable DB",
                @"LastModTime": @"2014-05-25 08:53:24",
                @"LastModusersID": @"2",
                @"Style": @"Saison",
                @"id": @"115"
            }, 
            @"stylesID": @"115"
        }
    };
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

//
//  GRMBaseObject_Tests.m
//  GM Taplist
//
//  Created by Daniel Miedema on 11/2/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GRMBaseObject.h"

@interface GRMBaseObject_Tests : XCTestCase

@end

@implementation GRMBaseObject_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_PrimaryKey_ReturnsCorrectString {
    NSString *key = [GRMBaseObject primaryKey];
    XCTAssert([key isEqualToString:@"baseobject_id"], @"primary key should '[class]_id'. Instead was %@", key);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

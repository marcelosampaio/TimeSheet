//
//  TimeLine.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "TimeLine.h"

@implementation TimeLine
@synthesize dateReference;


- (id)initWithDate:(NSDate *)inputDate
{
    self = [super init];
    if (self) {
        dateReference=inputDate;
    }
    return self;
}

@end

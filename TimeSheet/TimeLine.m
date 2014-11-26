//
//  TimeLine.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "TimeLine.h"

@implementation TimeLine
@synthesize year,month,day,hour,minute,second;


- (id)initWithYear:(int)p_year month:(int)p_month day:(int)p_day hour:(int)p_hour minute:(int)p_minute second:(int)p_second
{
    self = [super init];
    if (self) {
        year=p_year;
        month=p_month;
        day=p_day;
        hour=p_hour;
        minute=p_minute;
        second=p_second;
    }
    return self;
}

@end

//
//  TimeLine.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "TimeLine.h"

@implementation TimeLine
@synthesize dateTime,rowId,totalHours;

-(id)initWithDateTime:(NSString *)p_DateTime rowId:(int)p_RowId totalHours:(float)p_Total_Hours
{
    self = [super init];
    if (self) {
        dateTime=p_DateTime;
        rowId=p_RowId;
        totalHours=p_Total_Hours;
    }
    return self;
}

-(NSString *)getBrazilianDateFomatWithDate:(NSString *)date {
    // returns only the date
    
    NSArray *components = [date componentsSeparatedByString:@" "];
    // 0- Date
    // 1- Time
    NSString *dateString=[components objectAtIndex:0];
    NSArray *dateComponents=[dateString componentsSeparatedByString:@"-"];
    
    NSMutableString *brazilianDateFormat=[NSMutableString stringWithFormat:@"%@",[dateComponents objectAtIndex:2]];
    [brazilianDateFormat appendFormat:@"/"];
    [brazilianDateFormat appendFormat:@"%@",[dateComponents objectAtIndex:1]];
    [brazilianDateFormat appendFormat:@"/"];
    [brazilianDateFormat appendFormat:@"%@",[dateComponents objectAtIndex:0]];
    
    return brazilianDateFormat;
}

@end

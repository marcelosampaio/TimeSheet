//
//  TimeLine.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLine : NSObject

@property int year;
@property int month;
@property int day;
@property int hour;
@property int minute;
@property int second;


- (id)initWithYear:(int)p_year month:(int)p_month day:(int)p_day hour:(int)p_hour minute:(int)p_minute second:(int)p_second;


@end

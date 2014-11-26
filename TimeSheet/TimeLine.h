//
//  TimeLine.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLine : NSObject

@property (nonatomic,strong) NSString *dateTime;
@property int rowId;
@property float totalHours;

-(id)initWithDateTime:(NSString *)p_DateTime rowId:(int)p_RowId totalHours:(float)p_Total_Hours;


@end

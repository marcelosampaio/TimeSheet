//
//  TimeLine.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLine : NSObject

@property (strong,nonatomic) NSDate *dateReference;

- (id)initWithDate:(NSDate *)a_Date;


@end

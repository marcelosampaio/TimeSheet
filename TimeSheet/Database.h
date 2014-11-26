//
//  Database.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/24/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "TimeLine.h"


@interface Database : NSObject
{
    sqlite3 *db;
}


#pragma mark - Database Methods
// open database
//-(void) openDB;
//-(void) closeDB;
-(void) copyDatabaseToWritableFolder;
-(void) addTimeSheetWithTimeLineObject:(TimeLine *)timeLine;
-(NSMutableArray *)getTimeLineWithYear:(int)year month:(int)month day:(int)day;


@end

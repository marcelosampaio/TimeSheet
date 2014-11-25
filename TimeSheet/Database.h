//
//  Database.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/24/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"


@interface Database : NSObject
{
    sqlite3 *db;
}


#pragma mark - Database Methods
// open database
-(void) openDB;
-(void) closeDB;
-(void) copyDatabaseToWritableFolder;
-(void) addTimeSheetWithReferenceDate:(NSDate *)referenceDate;


@end

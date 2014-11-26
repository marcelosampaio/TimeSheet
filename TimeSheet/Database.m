//
//  Database.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/24/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "Database.h"

#define DATABASE_IDENTIFIER         @"TimeSheet.db"

@interface Database()

@property (nonatomic,strong) Database *database;

@end


@implementation Database

@synthesize database=_database;


#pragma mark - Lazy Instantiation
- (Database *) database
{
    if(!_database)
    {
        _database = [[Database alloc] init];
    }
    return _database;
}



#pragma mark - Database Methods
-(NSString *) dbPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"database Path: %@",[[paths objectAtIndex:0] stringByAppendingPathComponent:DATABASE_IDENTIFIER]);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:DATABASE_IDENTIFIER];
}


-(void) openDB
{
    if (sqlite3_open([[self.database dbPath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Open database failure!");
        return;
    }
}

-(void) closeDB
{
    sqlite3_close(db);
}

-(void) copyDatabaseToWritableFolder
{
    // Testa a existência de cópia editavel
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DATABASE_IDENTIFIER];

    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        return;
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_IDENTIFIER];
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

#pragma mark - Time Sheet Methods
-(void) addTimeSheetWithTimeLineObject:(TimeLine *)timeLine {

    // Open DataBase
    [self openDB];
    
    TimeLine *timeLineObject=timeLine;

    // error variable for database call
    char *err;
    
    // sql string
    NSString *sql=[NSString stringWithFormat:@"insert into TimeSheet (eventDate) values ('%@')",timeLineObject.dateTime];
    
    // execute database command
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database error - (addTimeSheetWithTimeLineObject:) Method");
    }

    // Close DataBase
    [self closeDB];
}

-(NSMutableArray *)getTimeLineWithYear:(int)year month:(int)month day:(int)day {
    
    // Open Database
    [self openDB];
    
    NSString *beginDate=@"";
    NSString *endDate=@"";
    
    if (day==0) {
        beginDate=[NSString stringWithFormat:@"%d-%02d-01 00:00:00",year,month];
        endDate=[NSString stringWithFormat:@"%d-%02d-31 23:59:59",year,month];
    }else{
        beginDate=[NSString stringWithFormat:@"%d-%02d-%02d 00:00:00",year,month,day];
        endDate=[NSString stringWithFormat:@"%d-%02d-%02d 23:59:59",year,month,day];
    }
    
    
    
    NSMutableArray *objectArray=[[NSMutableArray alloc]init];
    
    // Get favorites from database
    NSString *sql = [NSString stringWithFormat:@"select rowId,eventDate from TimeSheet where eventDate between '%@' and '%@' order by eventDate",beginDate,endDate];
    
    NSLog(@"getTimeLineWithYear:     SQL=%@",sql);
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        BOOL firstTime=YES;
        int previousRowId=0;
        int currentRowId=0;
        
        int counter=0;
        
        NSString *previousEventDate=@"";
        NSString *currentEventDate=@"";
        
        NSString *previousEventTime=@"";
        NSString *currentEventTime=@"";
        
        NSString *subTitle=@"";
        float totalHours=0;
        
        while(sqlite3_step(statement)==SQLITE_ROW)
        {
            // rowId
            char *field0 = (char *) sqlite3_column_text(statement, 0);
            NSString *field0Str = [[NSString alloc] initWithUTF8String:field0];
            
            // eventDate
            char *field1 = (char *) sqlite3_column_text(statement, 1);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            
            // --
            NSArray *components = [field1Str componentsSeparatedByString:@" "];
            currentEventDate=[components objectAtIndex:0];
            currentEventTime=[components objectAtIndex:1];
            currentRowId=[field0Str intValue];
            
            if (firstTime) {
                previousEventDate=currentEventDate;
                previousEventTime=currentEventTime;
                previousRowId=currentRowId;
                firstTime=NO;
            }

            counter++;
            //
            float remainder = fmod(counter, 2);
            if (remainder==0) {
                // Compute Extra Time Total Hours
                totalHours=totalHours+[self getTotalHoursWithCurrentTime:currentEventTime previousTime:previousEventTime];
                subTitle=@"";
            }else{
                subTitle=@"Incomplete";
            }

            if (![currentEventDate isEqualToString:previousEventDate]) {
                // Load table view cell
                [objectArray addObject:[[TimeLine alloc]initWithDateTime:previousEventDate rowId:previousRowId totalHours:totalHours]];
                
                previousEventDate=currentEventDate;
//                previousEventTime=currentEventTime;
//                previousRowId=currentRowId;
            }
            previousEventTime=currentEventTime;
            previousRowId=currentRowId;

        } // End While

        // Load last row
        if (!firstTime) {
            NSLog(@"GRAND TOTAL = %f",totalHours);
            [objectArray addObject:[[TimeLine alloc]initWithDateTime:previousEventDate rowId:previousRowId totalHours:totalHours]];
        }
    }
    // Close Database
    [self closeDB];
    
    // return data
    return objectArray;
}

-(float)getTotalHoursWithCurrentTime:(NSString *)currentTime previousTime:(NSString *)previousTime {

    NSArray *currentComponents = [currentTime componentsSeparatedByString: @":"];
    NSArray *previousComponents = [previousTime componentsSeparatedByString: @":"];

    float currentHour=[[currentComponents objectAtIndex:0] intValue];
    float currentMinute=([[currentComponents objectAtIndex:1] intValue]/60.00f);
    float computedCurrentHours=currentHour+currentMinute;
    
    
    float previousHour=[[previousComponents objectAtIndex:0] intValue];
    float previousMinute=([[previousComponents objectAtIndex:1] intValue]/60.00f);
    float computedPreviousHours=previousHour+previousMinute;
    
    
    NSLog(@"COMPUTED: %f",computedCurrentHours-computedPreviousHours);
    return (computedCurrentHours-computedPreviousHours);
    
}


@end

//
//  DataEntryViewController.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "DataEntryViewController.h"
#import "Database.h"
#import "TimeLine.h"

@interface DataEntryViewController ()

@end

@implementation DataEntryViewController
@synthesize datePicker,pickerView;
@synthesize selectedHour,selectedMinute;

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    NSLog(@"Year:%ld",(long)components.year);
    NSLog(@"Month:%ld",(long)components.month);
    NSLog(@"Day:%ld",(long)components.day);
    NSLog(@"Hour:%ld",(long)components.hour);
    NSLog(@"Minute:%ld",(long)components.minute);
    NSLog(@"Second:%ld",(long)components.second);
    
    self.selectedHour=components.hour;
    self.selectedMinute=components.minute;
    
    [self.pickerView selectRow:components.hour inComponent:0 animated:YES];
    [self.pickerView selectRow:components.minute inComponent:1 animated:YES];


}



- (IBAction)save:(id)sender {
    
//    NSLog(@"%@", [NSTimeZone knownTimeZoneNames]);
//    [NSTimeZone timeZoneWithName:@"America/Belem"];

    // Convert to local date
    NSInteger seconds=[[NSTimeZone localTimeZone]secondsFromGMT];
    NSDate *timesheetLocatTime = [self.datePicker.date dateByAddingTimeInterval:seconds];
    
    // Get Date Components
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:timesheetLocatTime];
    NSMutableString *dateString=[NSMutableString stringWithFormat:@"%d",components.year];
    [dateString appendString:@"-"];
    [dateString appendFormat:@"%02d",components.month];
    [dateString appendString:@"-"];
    [dateString appendFormat:@"%02d",components.day];

    // Get Picker's Time
    NSMutableString *timeString=[NSMutableString stringWithFormat:@"%02d",self.selectedHour];
    [timeString appendString:@":"];
    [timeString appendFormat:@"%02d",self.selectedMinute];
    [timeString appendString:@":00"];
    
    // Date & Time
    NSMutableString *dateTimeString=dateString;
    [dateTimeString appendFormat:@" %@",timeString];
    
    // TimeLine Object
    TimeLine *timeLine=[[TimeLine alloc]initWithDateTime:dateTimeString rowId:0 totalHours:0];

    // Database
    Database *database=[[Database alloc]init];
    [database addTimeSheetWithTimeLineObject:timeLine];
    
    
    // Return to Root View Controller
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - PickerView Data Source
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    int result=0;
    if (component==0) {
        result=24;
    }else if (component==1) {
        result=60;
    }
    return result;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%02d",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component==0) {
        self.selectedHour=row;
    }else{
        self.selectedMinute=row;
    }

}

@end

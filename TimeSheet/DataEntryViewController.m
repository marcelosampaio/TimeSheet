//
//  DataEntryViewController.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "DataEntryViewController.h"
#import "Database.h"

@interface DataEntryViewController ()

@end

@implementation DataEntryViewController
@synthesize datePicker,pickerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)save:(id)sender {
    
//    NSLog(@"%@", [NSTimeZone knownTimeZoneNames]);
//    [NSTimeZone timeZoneWithName:@"America/Belem"];
    
    
    NSLog(@"-> DATE PICKER DATE = %@",self.datePicker.date);
    
    // Convert to local time
    NSInteger seconds=[[NSTimeZone localTimeZone]secondsFromGMT];
//    NSTimeInterval timeInterval=seconds;
    NSDate *timesheetLocatTime = [self.datePicker.date dateByAddingTimeInterval:seconds];
    
    NSLog(@"-> LOCAL TIME = %@",timesheetLocatTime);
    
    Database *database=[[Database alloc]init];
    [database addTimeSheetWithReferenceDate:timesheetLocatTime];
    
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

@end

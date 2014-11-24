//
//  DataEntryViewController.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "DataEntryViewController.h"

@interface DataEntryViewController ()

@end

@implementation DataEntryViewController
@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)save:(id)sender {
    NSLog(@"selected date is %@",self.datePicker.date);
}


@end

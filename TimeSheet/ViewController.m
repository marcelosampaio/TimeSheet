//
//  ViewController.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/22/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize totalHours,tableView;
@synthesize source;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.source=[[NSMutableArray alloc]init];
    
    NSLog(@"initial commit");
}

#pragma mark - Table View Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [[UITableViewCell alloc]init];
    
}





@end

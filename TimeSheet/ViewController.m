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

    
    
    // Configure UI
    [self configureUI];
    
    // Load Data
    self.source=[[NSMutableArray alloc]init];
    self.source=[self loadSource];
    
    NSLog(@"Current date=%@",[NSDate date]);
}

#pragma mark - Table View Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
}


-(UITableViewCell *)tableView:(UITableView *)a_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [a_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[self.source objectAtIndex:indexPath.row];
    
    return cell;
    
}

#pragma mark - UI Configuration
-(void)configureUI {
    NSLog(@"configureUI");
    self.navigationItem.title=@"Nov/2014";
    
}

#pragma mark - Working Methods
-(NSMutableArray *)loadSource {
    return [[NSMutableArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth", nil];
}


@end

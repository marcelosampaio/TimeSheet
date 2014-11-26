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
@synthesize database,timeLine,components;

#pragma mark - View Lify Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    // Database Initial Procedures
    [self databaseInitialProcedures];
    
    // Configure UI
    [self configureUI];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Load data from database
    self.source=[[NSMutableArray alloc]init];
    self.timeLine=[[TimeLine alloc]init];
    
    self.source=[self.database getTimeLineWithYear:self.components.year month:self.components.month day:0];
    

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
    
    self.timeLine=[self.source objectAtIndex:indexPath.row];
    
    cell.textLabel.text=timeLine.dateTime;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%f",timeLine.totalHours];
    
    return cell;
    
}

#pragma mark - UI Configuration
-(void)configureUI {
    // Get Date Components of the current date
    self.components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    self.navigationItem.title=[NSString stringWithFormat:@"%d/%d",self.components.month,self.components.year];
}

#pragma mark - DataBase Methods
-(void)databaseInitialProcedures {
    
    self.database=[[Database alloc]init];
    
    // copy database from resource folder to documents folder
    [self.database copyDatabaseToWritableFolder];

}
@end

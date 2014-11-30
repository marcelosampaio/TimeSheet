//
//  ViewController.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/22/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"
#import "CustomEventTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize totalHours,totalOverHours,tableView;
@synthesize source;
@synthesize database,timeLine,components;
@synthesize grandTotalNormalHours,grandTotalOverHours;

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

//    // reset intial some variables
//    self.grandTotalOverHours=0;
//    self.grandTotalNormalHours=0;
    
    // Load data from database
    self.source=[[NSMutableArray alloc]init];
    self.timeLine=[[TimeLine alloc]init];
    
    self.source=[self.database getTimeLineWithYear:self.components.year month:self.components.month day:0];
    [self.tableView reloadData];
    self.totalHours.text=[NSString stringWithFormat:@"Normal: %02.2f",self.grandTotalNormalHours];
    self.totalOverHours.text=[NSString stringWithFormat:@"Over: %02.2f",self.grandTotalOverHours];
    

}


#pragma mark - Table View Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
}


-(UITableViewCell *)tableView:(UITableView *)a_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    CustomEventTableViewCell *cell = (CustomEventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil)  //Instancia celulas suficientes para uma tela
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomEventTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    
    self.timeLine=[self.source objectAtIndex:indexPath.row];
    
    cell.eventDate.text=[self.timeLine getBrazilianDateFomatWithDate:self.timeLine.dateTime];
    float normalHours=0;
    float overHours=0;
    if (timeLine.totalHours>8) {
        normalHours=8;
        overHours=timeLine.totalHours - normalHours;
        cell.overTimeIcon.hidden=YES;
        cell.overTimeIcon.alpha=0.70;
        cell.eventOverHour.hidden=NO;
        cell.overHourLabel.hidden=NO;
        cell.normalHourLabel.hidden=NO;
//        cell.backgroundColor=[UIColor colorWithRed:0.080 green:0.387 blue:0 alpha:0.45];
    }else{
        normalHours=timeLine.totalHours;
        cell.overTimeIcon.hidden=YES;
        cell.eventOverHour.hidden=YES;
        cell.normalHourLabel.hidden=NO;
        cell.overHourLabel.hidden=YES;
    }
    cell.eventNormalHour.text=[NSString stringWithFormat:@"%02.2f",normalHours];
    cell.eventOverHour.text=[NSString stringWithFormat:@"%02.2f",overHours];
    
    // compute grand totals
    self.grandTotalNormalHours=self.grandTotalNormalHours+normalHours;
    self.grandTotalOverHours=self.grandTotalOverHours+overHours;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath: (NSIndexPath *)indexPath {
    return @"Remove";
    //    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)tableView:(UITableView *)a_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.source removeObjectAtIndex:indexPath.row];
        [a_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cell row");
//    return;
//}





#pragma mark - UI Configuration
-(void)configureUI {
    // Get Date Components of the current date
    self.components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    self.navigationItem.title=[NSString stringWithFormat:@"%d/%d",self.components.month,self.components.year];
    
    self.totalHours.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    self.totalOverHours.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
}

#pragma mark - DataBase Methods
-(void)databaseInitialProcedures {
    
    self.database=[[Database alloc]init];
    
    // copy database from resource folder to documents folder
    [self.database copyDatabaseToWritableFolder];

}
@end

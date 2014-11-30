//
//  ViewController.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/22/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "TimeLine.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *totalHours;
@property (weak, nonatomic) IBOutlet UILabel *totalOverHours;

@property (weak, nonatomic) IBOutlet UITableView *tableView;




@property (nonatomic,strong) NSMutableArray *source;

@property (nonatomic,strong) Database *database;
@property (nonatomic,strong) TimeLine *timeLine;

@property (nonatomic,strong) NSDateComponents *components;


@property float grandTotalNormalHours;
@property float grandTotalOverHours;




@end


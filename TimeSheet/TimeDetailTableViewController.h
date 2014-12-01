//
//  TimeDetailTableViewController.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeDetailTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *source;

@property (nonatomic,strong) NSString *eventDateTime;


@end

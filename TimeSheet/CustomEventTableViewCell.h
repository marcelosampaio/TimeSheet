//
//  CustomEventTableViewCell.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/29/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomEventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventNormalHour;
@property (weak, nonatomic) IBOutlet UILabel *eventOverHour;
@property (weak, nonatomic) IBOutlet UIImageView *overTimeIcon;
@property (weak, nonatomic) IBOutlet UILabel *normalHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *overHourLabel;



@end

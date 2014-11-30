//
//  CustomEventTableViewCell.m
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/29/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "CustomEventTableViewCell.h"

@implementation CustomEventTableViewCell

@synthesize eventDate,eventOverHour,eventNormalHour;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DataEntryViewController.h
//  TimeSheet
//
//  Created by Marcelo Sampaio on 11/23/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataEntryViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;





@end

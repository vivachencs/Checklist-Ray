//
//  CXIconPickerViewController.h
//  Checklists
//
//  Created by ChenX on 16/11/7.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXIconPickerViewController;

@protocol iconPickerViewControllerDelegate <NSObject>

- (void)iconPickerViewController:(CXIconPickerViewController *)controller didPickIcon:(NSString *)iconName;

@end

@interface CXIconPickerViewController : UITableViewController

@property (nonatomic, weak) id<iconPickerViewControllerDelegate> delegate;

@end

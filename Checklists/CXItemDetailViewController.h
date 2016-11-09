//
//  CXItemDetailViewController.h
//  Checklists
//
//  Created by ChenX on 16/11/9.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXItemDetailViewController;
@class CXCheckItem;

@protocol itemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewController:(CXItemDetailViewController *)controller didFinishAddingItem:(CXCheckItem *)item;
- (void)itemDetailViewController:(CXItemDetailViewController *)controller didFinishEditingItem:(CXCheckItem *)item;

@end

@interface CXItemDetailViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<itemDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) CXCheckItem *itemToEdit;

@end

//
//  CXListDetailViewController.h
//  Checklists
//
//  Created by ChenX on 16/11/7.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXIconPickerViewController.h"

@class CXListDetailViewController;
@class CXChecklist;

@protocol listDetailViewControllerDelegate <NSObject>

- (void)listDetailViewController:(CXListDetailViewController *)controller didFinishiAddingChecklist:(CXChecklist *)checklist;
- (void)listDetailViewController:(CXListDetailViewController *)controller didFinishiEditingChecklist:(CXChecklist *)checklist;

@end

@interface CXListDetailViewController : UITableViewController<iconPickerViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id<listDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) CXChecklist *checklistToEdit;

@end

//
//  CXChecklistViewController.h
//  Checklists
//
//  Created by ChenX on 16/11/8.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXItemDetailViewController.h"

@class CXChecklist;

@interface CXChecklistViewController : UITableViewController<itemDetailViewControllerDelegate>

@property (nonatomic, strong) CXChecklist *checklist;

@end

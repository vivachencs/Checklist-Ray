//
//  ViewController.h
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXListDetailViewController.h"

@class CXDataModel;

@interface CXAllListViewController : UITableViewController<listDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) CXDataModel *model;

@end


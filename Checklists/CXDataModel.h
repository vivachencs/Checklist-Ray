//
//  CXDataModel.h
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXDataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)saveChecklists;

- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(NSInteger)index;
- (void)sortChecklists;

@end

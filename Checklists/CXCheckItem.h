//
//  CXCheckItem.h
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCheckItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL checked;

- (instancetype)initWithItemName:(NSString *)name checked:(BOOL)checked;
- (void)toggleChecked;

@end

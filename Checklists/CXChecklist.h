//
//  CXChecklist.h
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXChecklist : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, strong) NSMutableArray *items;

- (instancetype)initWithName:(NSString *)name;
- (int)countUncheckedItems;

@end

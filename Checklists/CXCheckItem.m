//
//  CXCheckItem.m
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXCheckItem.h"

@implementation CXCheckItem

- (instancetype)initWithItemName:(NSString *)name checked:(BOOL)checked
{
    if (self = [super init]) {
        _name = name;
        _checked = checked;
    }
    return self;
}

- (void)toggleChecked
{
    self.checked = !self.checked;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"Name"];
        _checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

@end

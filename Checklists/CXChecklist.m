//
//  CXChecklist.m
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXChecklist.h"
#import "CXCheckItem.h"

@implementation CXChecklist

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
        _iconName = @"No Icon";
    }
    return self;
}

- (int)countUncheckedItems
{
    int count = 0;
    for (CXCheckItem *item in self.items) {
        if (!item.checked) {
            count += 1;
        }
    }
    return count;
}

- (NSComparisonResult)compare:(CXChecklist *)otherChecklist
{
    return [self.name localizedCompare:otherChecklist.name];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"Name"];
        _iconName = [aDecoder decodeObjectForKey:@"IconName"];
        _items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
}

@end

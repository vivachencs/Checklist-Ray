//
//  CXDataModel.m
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXDataModel.h"
#import "CXChecklist.h"

@implementation CXDataModel

- (NSMutableArray *)lists
{
    if (!_lists) {
        _lists = [[NSMutableArray alloc] init];
    }
    return _lists;
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths firstObject] stringByAppendingString:@"Checklists.plist"];
    
    return path;
}

- (void)saveChecklists
{
    NSString *path = [self dataFilePath];
    [NSKeyedArchiver archiveRootObject:self.lists toFile:path];
}

- (void)loadChecklists
{
    NSString *path = [self dataFilePath];
    self.lists = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self loadChecklists];
        
    }
    return self;
}

- (NSInteger)indexOfSelectedChecklist
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

- (void)setIndexOfSelectedChecklist:(NSInteger)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

- (void)sortChecklists
{
    [self.lists sortUsingSelector:@selector(compare:)];
}

@end
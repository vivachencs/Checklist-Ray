//
//  CXIconPickerViewController.m
//  Checklists
//
//  Created by ChenX on 16/11/7.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXIconPickerViewController.h"

@interface CXIconPickerViewController ()

@property (nonatomic, copy) NSArray *icons;

@end

@implementation CXIconPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.icons = @[
                   @"No Icon",
                   @"Appointments",
                   @"Birthdays",
                   @"Chores",
                   @"Drinks",
                   @"Folder",
                   @"Groceries",
                   @"Inbox",
                   @"Photos",
                   @"Trips"
                   ];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = self.icons[indexPath.row];
    
    [self.delegate iconPickerViewController:self didPickIcon:iconName];
    
    //移除iconPicker视图
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    
    NSString *icon = self.icons[indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    
    return cell;
}

@end

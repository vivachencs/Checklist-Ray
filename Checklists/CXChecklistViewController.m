//
//  CXChecklistViewController.m
//  Checklists
//
//  Created by ChenX on 16/11/8.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXChecklistViewController.h"
#import "CXChecklist.h"
#import "CXCheckItem.h"

@interface CXChecklistViewController ()

@end

@implementation CXChecklistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.checklist.name;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        CXItemDetailViewController *controller = (CXItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EditItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        CXItemDetailViewController *controller = (CXItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = self.checklist.items[indexPath.row];
    }
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(CXCheckItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:11];
    
    if (item.checked) {
        label.text = @"√";
    } else {
        label.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(CXCheckItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    label.text = item.name;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checklist.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    CXCheckItem *item = self.checklist.items[indexPath.row];
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CXCheckItem *item = self.checklist.items[indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - ItemDetail view delegate

- (void)itemDetailViewController:(CXItemDetailViewController *)controller didFinishAddingItem:(CXCheckItem *)item
{
    [self.checklist.items addObject:item];
    [self.tableView reloadData];
}

- (void)itemDetailViewController:(CXItemDetailViewController *)controller didFinishEditingItem:(CXCheckItem *)item
{
    [self.tableView reloadData];
}

@end

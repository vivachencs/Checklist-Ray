//
//  ViewController.m
//  Checklists
//
//  Created by ChenX on 16/11/4.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXAllListViewController.h"
#import "CXChecklistViewController.h"
#import "CXDataModel.h"
#import "CXChecklist.h"
#import "CXCheckItem.h"

@interface CXAllListViewController ()

@end

@implementation CXAllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

//主界面出现之后，再将其设置为nav的代理，避免调用willShowViewController方法
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    NSInteger index = [self.model indexOfSelectedChecklist];
    
    if (index >= 0 && index < [self.model.lists count]) {
        CXChecklist *list = self.model.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:list];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
        CXChecklistViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    } else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        CXListDetailViewController *controller = (CXListDetailViewController *)navigationController.topViewController;
        
        controller.delegate = self;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    //重用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    CXChecklist *list = self.model.lists[indexPath.row];
    int count = [list countUncheckedItems];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", list.name];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    if ([list.items count] == 0) {
        cell.detailTextLabel.text = @"No Items";
    } else if (count == 0) {
        cell.detailTextLabel.text = @"All done";
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining", count];
    }
    
    cell.imageView.image = [UIImage imageNamed:list.iconName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.model.lists removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //保存行索引
    [self.model setIndexOfSelectedChecklist:indexPath.row];
    
    CXChecklist *checklist = self.model.lists[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXListNavigationgController"];
    CXListDetailViewController *controller = (CXListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    CXChecklist *list = self.model.lists[indexPath.row];
    controller.checklistToEdit = list;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - ListDetail view delegate

- (void)listDetailViewController:(CXListDetailViewController *)controller didFinishiAddingChecklist:(CXChecklist *)checklist
{
    [self.model.lists addObject:checklist];
    [self.model sortChecklists];
    [self.tableView reloadData];
}

- (void)listDetailViewController:(CXListDetailViewController *)controller didFinishiEditingChecklist:(CXChecklist *)checklist
{
    [self.model sortChecklists];
    [self.tableView reloadData];
}

#pragma mark - Navigation delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果返回主界面
    if (viewController == self) {
        //删除行索引
        [self.model setIndexOfSelectedChecklist:-1];
    }
}

@end

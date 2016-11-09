//
//  CXItemDetailViewController.m
//  Checklists
//
//  Created by ChenX on 16/11/9.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXItemDetailViewController.h"
#import "CXCheckItem.h"

@interface CXItemDetailViewController ()

- (IBAction)done:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@end

@implementation CXItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.itemToEdit) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.name;
        self.doneBarButton.enabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (IBAction)done:(UIBarButtonItem *)sender
{
    if (self.itemToEdit) {
        self.itemToEdit.name = self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    } else {
        CXCheckItem *item = [[CXCheckItem alloc] initWithItemName:self.textField.text checked:NO];
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(UIBarButtonItem *)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = [newText length] > 0;
    
    return YES;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end

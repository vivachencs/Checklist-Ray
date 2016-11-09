//
//  CXListDetailViewController.m
//  Checklists
//
//  Created by ChenX on 16/11/7.
//  Copyright © 2016年 ChenX. All rights reserved.
//

#import "CXListDetailViewController.h"
#import "CXChecklist.h"

@interface CXListDetailViewController ()

- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)done:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, strong) NSString *iconName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@end

@implementation CXListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.checklistToEdit) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.iconName = self.checklistToEdit.iconName;
        self.doneBarButton.enabled = YES;
    }
    self.iconImage.image = [UIImage imageNamed:self.iconName];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.iconName = @"Folder";
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        CXIconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (IBAction)cancel:(UIBarButtonItem *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(UIBarButtonItem *)sender
{
    if (self.checklistToEdit) {
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = self.iconName;
        [self.delegate listDetailViewController:self didFinishiEditingChecklist:self.checklistToEdit];
    } else {
        CXChecklist *list = [[CXChecklist alloc] initWithName:self.textField.text];
        list.iconName = self.iconName;
        [self.delegate listDetailViewController:self didFinishiAddingChecklist:list];
    }
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

#pragma mark - IconPicker view delegate

- (void)iconPickerViewController:(CXIconPickerViewController *)controller didPickIcon:(NSString *)iconName
{
    self.iconName = iconName;
    
    self.iconImage.image = [UIImage imageNamed:self.iconName];
}

#pragma mark - textField view delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = [newText length] > 0;
    return YES;
}

@end

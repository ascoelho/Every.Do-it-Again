//
//  ModalViewController.m
//  Every.Do
//
//  Created by Anthony Coelho on 2016-05-17.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "ModalViewController.h"
#import "Todo.h"


@interface ModalViewController ()

@end

@implementation ModalViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)backButton:(id)sender{
    
    NSManagedObjectContext *context = self.managedObjectContext;
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:context];
    newTodo.itemTitle = self.itemTitleTextField.text;
    newTodo.itemDescription = self.itemDescriptionTextField.text;
    newTodo.priorityNumber = [self.itemPriorityTextField.text intValue];
    newTodo.isCompleted = NO;

    
    [self.delegate returnToDoItem:newTodo];

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

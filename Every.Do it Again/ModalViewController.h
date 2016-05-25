//
//  ModalViewController.h
//  Every.Do
//
//  Created by Anthony Coelho on 2016-05-17.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>




@protocol ModalViewControllerDelegate <NSObject>

- (void)returnToDoItem:(id)item;

@end

@interface ModalViewController : UIViewController <NSFetchedResultsControllerDelegate>


@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *itemTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemPriorityTextField;



- (IBAction)backButton:(id)sender;

@end

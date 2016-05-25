//
//  MasterViewController.m
//  Every.Do it Again
//
//  Created by Anthony Coelho on 2016-05-25.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ModalViewController.h"
#import "CustomTableViewCell.h"
#import "Todo.h"


@interface MasterViewController () <ModalViewControllerDelegate>

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showModalVC:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
   
    [self.fetchedResultsController performFetch:nil];
    
    self.tableView.rowHeight = 80;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(markComplete:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipe];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];

    [context save:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    if ([[segue identifier] isEqualToString:@"showModalVC"]) {
        
        ModalViewController *modalVC = (ModalViewController *)[segue destinationViewController];
        modalVC.delegate = self;
        
        modalVC.managedObjectContext = [self.fetchedResultsController managedObjectContext];
        
    


        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(CustomTableViewCell *)cell withObject:(NSManagedObject *)object {
    
    Todo *item = (Todo *)object;
    
    if (item.isCompleted == YES) {
        
        cell.itemTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:item.itemTitle
                                                                             attributes:@{NSStrikethroughStyleAttributeName:
                                                                                              [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        
        cell.itemDescriptionLabel.attributedText = [[NSAttributedString alloc] initWithString:item.itemDescription
                                                                                   attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                    [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    }
    else {
        cell.itemTitleLabel.text = item.itemTitle;
        cell.itemDescriptionLabel.text = item.itemDescription;
        
    }
    cell.itemPriorityNumber.text = [NSString stringWithFormat:@"%d",item.priorityNumber];
    cell.itemStatus.text = [NSString stringWithFormat:@"%@", item.isCompleted ? @"Completed" : @"Not Completed"];
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"itemTitle" ascending:YES]];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)returnToDoItem:(id)item{
    
    [self insertNewObject:item];
    
}

- (void)showModalVC:(id)sender {
    
    [self performSegueWithIdentifier:@"showModalVC" sender:self];
    
}

- (void)markComplete:(id)sender {
    
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
        
        CGPoint swipePoint = [sender locationInView:self.tableView];
        NSIndexPath *indexPathOfSwipedCell = [self.tableView indexPathForRowAtPoint:swipePoint];
        Todo *item = [[self fetchedResultsController] objectAtIndexPath:indexPathOfSwipedCell];
        item.isCompleted = YES;
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        
        [context save:nil];
   
    }
    
    
}



@end

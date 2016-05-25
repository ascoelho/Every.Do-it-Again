//
//  DetailViewController.m
//  Every.Do it Again
//
//  Created by Anthony Coelho on 2016-05-25.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "DetailViewController.h"
#import "Todo.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    Todo *item = (Todo *)self.detailItem;
    
    if (item) {
        self.itemTitleLabel.text = item.itemTitle;
        self.itemDescriptionLabel.text = item.itemDescription;
        self.itemPriorityLabel.text = [NSString stringWithFormat:@"%d",item.priorityNumber];
        self.itemStatusLabel.text = [NSString stringWithFormat:@"%@", item.isCompleted ? @"Completed" : @"Not Completed"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

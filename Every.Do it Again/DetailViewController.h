//
//  DetailViewController.h
//  Every.Do it Again
//
//  Created by Anthony Coelho on 2016-05-25.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemStatusLabel;

@end


//
//  Todo+CoreDataProperties.h
//  Every.Do it Again
//
//  Created by Anthony Coelho on 2016-05-25.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *itemTitle;
@property (nullable, nonatomic, retain) NSString *itemDescription;
@property (nonatomic) int16_t priorityNumber;
@property (nonatomic) BOOL isCompleted;

@end

NS_ASSUME_NONNULL_END

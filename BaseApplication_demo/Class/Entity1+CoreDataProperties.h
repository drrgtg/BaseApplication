//
//  Entity1+CoreDataProperties.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/20.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity1.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity1 (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *telephone;

@end

NS_ASSUME_NONNULL_END

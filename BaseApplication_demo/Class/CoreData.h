//
//  CoreData.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/20.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity1.h"
#import "Entity1+CoreDataProperties.h"

#import <CoreData/CoreData.h>
@interface CoreData : NSObject

+ (instancetype)defaultCoreData;


- (BOOL)insertObjName:(NSString *)name andTel:(NSString *)telephone;

- (NSArray *)searchAllData;

- (BOOL)removeAllData;

- (NSURL *)applicationDocumentsDirectory;


@end

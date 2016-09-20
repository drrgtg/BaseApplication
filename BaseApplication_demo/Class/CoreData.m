//
//  CoreData.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/20.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "CoreData.h"

@interface CoreData ()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
@end

@implementation CoreData

static CoreData *da = nil;

+(instancetype)defaultCoreData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        da = [[CoreData alloc]init];
        
        [da saveContext];

    });
    return da;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        da = [super allocWithZone:zone];
    });
    return da;
}
-(id)copy
{
    return da;
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

/**
 *  插入数据
 */
- (BOOL)insertObjName:(NSString *)name andTel:(NSString *)telephone
{
    //上下文对象
    NSManagedObjectContext *context = [self managedObjectContext];
    //获取coredata中名为Entity的表
    //获取coredata中名为Entity1的表
    Entity1 *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity1" inManagedObjectContext:context];
    entity.name = name;
    entity.telephone = telephone;

    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
        return YES;
    }
    else
    {
        NSLog(@"保存成功");
        return NO;
    }
}
/**
 *  数据查找
 */
- (NSArray *)searchAllData
{
    /**
     *  获取上下文
     */
    NSManagedObjectContext *context = [self managedObjectContext];
    /**
     数据获取对象
     */
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setIncludesPropertyValues:NO];
    
    
    /**
     *  通过上下文获取给定的字符串的名称的表对象
     */
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity1" inManagedObjectContext:context];
    /**
     *  设置获取entity表
     */
    [fetchRequest setEntity:entity];
    NSError *error;
    /**
     *  获取到的表数据数组
     */
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    /**
     *  遍历
     */
    for (Entity1 *info in fetchedObjects) {
        
        NSLog(@"name:%@", info.name);
        NSLog(@"telephone:%@", info.telephone);
        /**
         *  删除表中的元素需要保存一下
         */
//        [context deleteObject:info];
//        if (![context save:&error])
//        {
//            NSLog(@"%@",error.localizedDescription);
//        };
    }
    return fetchedObjects;
}
-(BOOL)removeAllData
{
    /**
     *  获取上下文
     */
    NSManagedObjectContext *context = [self managedObjectContext];
    /**
     数据获取对象
     */
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setIncludesPropertyValues:NO];
    
    
    /**
     *  通过上下文获取给定的字符串的名称的表对象
     */
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity1" inManagedObjectContext:context];
    /**
     *  设置获取entity表
     */
    [fetchRequest setEntity:entity];
    NSError *error;
    /**
     *  获取到的表数据数组
     */
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    /**
     *  遍历
     */
    BOOL suc = NO;
    for (Entity1 *info in fetchedObjects) {
        
        NSLog(@"name:%@", info.name);
        NSLog(@"telephone:%@", info.telephone);
        /**
         *  删除表中的元素需要保存一下
         */
        [context deleteObject:info];
        if (![context save:&error])
        {
            NSLog(@"%@",error.localizedDescription);
            return NO;
        }
        else
        {
            suc = YES;
        }
    }
    return suc;
}
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lspp.CoreData_demo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //获得本地coredata文件
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    //生成本地文件路径
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end

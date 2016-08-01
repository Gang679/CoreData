//
//  CoreDataDAO.h
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataDAO : NSObject
//NSManagedObjectContext 它是被管理对象上下文(Managed Object Context,MOC)类，在上下文中可以查找、删除和插入对象，然后通过栈同步到持久化对象存储。
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//NSManagedObjectModel，它是被管理对象模型（Managed Object Model，MOM）类，是系统中的“实体”，与数据库中的表等对象对应
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//NSPersistentStoreCoordinator它是持久化存储协调器（Persistent Store Coordinator，PSC）类，在持久化对象存储之上提供了一个接口，可以把它考虑成为数据库的连接
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

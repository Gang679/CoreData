//
//  NoteDAO.m
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import "NoteDAO.h"
#import "NoteManagedObject.h"
#import "Note.h"
@implementation NoteDAO

+ (NoteDAO*)sharedNoteDAO{
    static NoteDAO *noteDAO = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noteDAO = [[self alloc] init];
        [noteDAO managedObjectContext];
    });
    return noteDAO;
}

//创建
- (int)create:(Note*)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cxt];
    note.date = model.date;
    note.content = model.content;
    note.imageData = model.imageData;
    NSError *savingErr = nil;
    if ([cxt hasChanges] && [cxt save:&savingErr]) {
        NSLog(@"插入成功");
    }else{
        return -1;
    }
    
    return 0;
}
//删除
- (int)remove:(Note*)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",model.date];//如果会高并发，model.date会重复，需查找id进行删除
    [fetchRequest setPredicate:predicate];
    NSError *err = nil;
    NSArray *listArr = [cxt executeFetchRequest:fetchRequest error:&err];
    if ([listArr count] > 0) {
        NSManagedObject *note = [listArr lastObject];
        [cxt deleteObject:note];
        NSError *savingErr = nil;
        if ([cxt hasChanges] && [cxt save:&savingErr]) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
            return -1;
        }
        
    }
    return 0;
}
//修改
- (int)update:(Note*)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
//    谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"content = %@",model.content];// 此处需要传入的数据value与object,表明修改存在的哪个参数
    
    [fetchRequest setPredicate:predicate];
    
    NSError *err = nil;
    
    NSArray *listArr = [cxt executeFetchRequest:fetchRequest error:&err];
    if ([listArr count] > 0) {
        NoteManagedObject *note = [listArr lastObject];
        note.content = model.content;
        NSError *savingErr = nil;
        if ([cxt hasChanges] && [cxt save:&savingErr]) {
            NSLog(@"修改成功");
        }else{
            NSLog(@"修改失败");
            return -1;
        }
    }
    
    return 0;
}
//查找全部
- (NSMutableArray*)findAll{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Note" inManagedObjectContext:cxt];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    NSError *savingErr = nil;
    NSArray *listArr = [cxt executeFetchRequest:fetchRequest error:&savingErr];
    NSMutableArray *noteArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NoteManagedObject *nmo in listArr) {
        Note *note = [[Note alloc] init];
        note.date = nmo.date;
        note.content = nmo.content;
        note.imageData = nmo.imageData;
        [noteArr addObject:note];
    }
    
    return noteArr;
}
//按主键查找
- (Note*)findByID:(Note*)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",model.date];// 此处需要传入数据value与object,表明需查找的哪个主键
    [fetchRequest setPredicate:predicate];
    NSError *err = nil;
    NSArray *listArr = [cxt executeFetchRequest:fetchRequest error:&err];
    Note *note = [[Note alloc] init];
    if ([listArr count] > 0) {
        NoteManagedObject *nmo = [listArr lastObject];
        note.date = nmo.date;
        note.content = nmo.content;
        note.imageData = nmo.imageData;
    }
    return note;
}


@end

//
//  NoteDAO.h
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import "CoreDataDAO.h"
@class Note;
@interface NoteDAO : CoreDataDAO

+ (NoteDAO*)sharedNoteDAO;
//创建
- (int)create:(Note*)model;
//删除
- (int)remove:(Note*)model;
//修改
- (int)update:(Note*)model;
//查找全部
- (NSMutableArray*)findAll;
//按主键查找
- (Note*)findByID:(Note*)model;

@end

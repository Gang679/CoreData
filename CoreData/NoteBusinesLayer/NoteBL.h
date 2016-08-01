//
//  NoteBL.h
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;
@interface NoteBL : NSObject

- (NSMutableArray*)createNote:(Note*)note;

- (NSMutableArray*)deleteNote:(Note*)note;

- (NSMutableArray*)modifyNote:(Note*)note;

- (NSMutableArray*)findAll;

- (Note*)findByID:(Note*)note;

@end

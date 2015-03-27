//
//  NoteBL.m
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import "NoteBL.h"
#import "Note.h"
#import "NoteDAO.h"
@implementation NoteBL

- (NSMutableArray*)createNote:(Note*)note{
    NoteDAO *dao = [NoteDAO sharedNoteDAO];
    [dao create:note];
    return [dao findAll];

}

- (NSMutableArray*)deleteNote:(Note*)note{
    NoteDAO *dao = [NoteDAO sharedNoteDAO];
    [dao remove:note];
    return [dao findAll];
}

- (NSMutableArray*)modifyNote:(Note*)note{
    NoteDAO *dao = [NoteDAO sharedNoteDAO];
    [dao update:note];
    return [dao findAll];
}

- (NSMutableArray*)findAll{
    NoteDAO *dao = [NoteDAO sharedNoteDAO];
    return [dao findAll];
}

- (Note*)findByID:(Note*)note{
    NoteDAO *dao = [NoteDAO sharedNoteDAO];
    return [dao findByID:note];
}

@end

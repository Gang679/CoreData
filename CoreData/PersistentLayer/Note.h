//
//  Note.h
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic,strong)NSDate *date;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSData *imageData;

@end

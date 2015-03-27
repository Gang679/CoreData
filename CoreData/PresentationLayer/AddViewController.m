//
//  AddViewController.m
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import "AddViewController.h"
#import "Note.h"
#import "NoteBL.h"
@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNote:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


- (void)saveNote:(UIBarButtonItem*)sender{
    Note *note = [[Note alloc] init];
    note.content = self.textView.text;
    note.date = [NSDate date];
    note.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"icon.jpg"]);
    
    NoteBL *noteBL = [[NoteBL alloc] init];
    [noteBL createNote:note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableViewList" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

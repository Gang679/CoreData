//
//  RootViewController.m
//  CoreData
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 LiXu. All rights reserved.
//

#import "RootViewController.h"
#import "Note.h"
#import "NoteBL.h"
#import "AddViewController.h"
@interface RootViewController ()
{
    UIBarButtonItem *leftButton;
}
@property (nonatomic,strong)NSMutableArray *listArr;

@end

@implementation RootViewController
@synthesize listArr;

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
    // Do any additional setup after loading the view.
    self.title = @"list";
    
    leftButton = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(editNote:)];
    leftButton.tag = 100;
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    NoteBL *noteBL = [[NoteBL alloc] init];
    self.listArr = [noteBL findAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewList) name:@"reloadTableViewList" object:nil];
    
    
    
}


- (void)editNote:(UIBarButtonItem*)sender{
    if (sender.tag == 100) {
        [_tableView setEditing:YES animated:YES];
        [leftButton setTitle:@"done"];
        sender.tag = 101;
    }else{
        [_tableView setEditing:NO animated:YES];
        [leftButton setTitle:@"edit"];
        sender.tag = 100;
    }
    
}

- (void)addNote:(UIBarButtonItem*)sender{
    AddViewController *addViewController = [[AddViewController alloc] init];
    [self.navigationController pushViewController:addViewController animated:YES];
}


#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.listArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Note *note = [self.listArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = note.content;
    cell.imageView.image = [UIImage imageWithData:note.imageData];
    cell.detailTextLabel.text = [note.date description];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = self.listArr[indexPath.row];
        NoteBL *noteBL = [[NoteBL alloc] init];
        self.listArr = [noteBL deleteNote:note];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark --reloadTableViewList

- (void)reloadTableViewList{
    NoteBL *noteBL = [[NoteBL alloc] init];
    self.listArr = [noteBL findAll];
    [_tableView reloadData];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

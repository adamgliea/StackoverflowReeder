//
//  QuestionsTableViewController.m
//  StackoverflowReeder
//
//  Created by Maozijun on 5/10/13.
//  Copyright (c) 2013 Maozijun. All rights reserved.
//

#import "QuestionsTableViewController.h"
#import "QuestSimpleInfoCell.h"
#import "QuestionSimpleInfo.h"
#import "QuestionsRequestProxy.h"
#import "SVProgressHUD.h"

@interface QuestionsTableViewController ()

@property (strong, nonatomic) NSMutableArray *quests;
@property (strong, nonatomic) QuestionsRequestProxy *questionsProxy;

@end

@implementation QuestionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.questionsProxy questionsBySort:QuestionSortType_Last_Activity_Date
                           questionCount:20
                               pageIndex:1
                               ascending:NO];
    [SVProgressHUD showWithStatus:@"同步中"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.quests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestionSimpleInfoTableCell";
    QuestSimpleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    QuestionSimpleInfo *info = self.quests[indexPath.row];
    cell.titleLabel.text = info.title;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark --
#pragma mark - Set/Get Functions
#pragma mark --

- (NSMutableArray*)quests {
    if (_quests == nil) {
        _quests = [[NSMutableArray alloc] init];
    }
    
    return _quests;
}

- (QuestionsRequestProxy*)questionsProxy {
    if (_questionsProxy == nil) {
        _questionsProxy = [[QuestionsRequestProxy alloc] init];
        _questionsProxy.delegate = self;
    }
    
    return _questionsProxy;
}

#pragma mark --
#pragma mark - WebQuestionsDelegate
#pragma mark --

- (void)getQuestionsDidFinish:(NSDictionary*)result
                        error:(NSError*)error {
    NSArray *questions = result[@"items"];
    [questions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *questionInfo = obj;
        QuestionSimpleInfo *simpleInfo = [[QuestionSimpleInfo alloc] initWithInfo:questionInfo];
        
        [self.quests addObject:simpleInfo];
    }];
    
    [SVProgressHUD dismiss];
    
    [self.tableView reloadData];
}

- (void)getQuestionDidFinish:(NSDictionary*)result
                       error:(NSError*)error {
}

- (void)getQuestionAnswersDidFinish:(NSDictionary*)result
                              error:(NSError*)error {
}

@end

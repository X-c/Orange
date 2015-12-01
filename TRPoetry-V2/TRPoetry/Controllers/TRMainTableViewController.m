//
//  TRMainTableViewController.m
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TRMainTableViewController.h"
#import "TRPoemCategory.h"
#import "TRPoem.h"
#import "TRTableViewCell.h"
#import "TRPoemListTableViewController.h"

@interface TRMainTableViewController ()

@property (nonatomic, strong) NSArray *poemCategoryArray;

@end

@implementation TRMainTableViewController

- (NSArray *)poemCategoryArray {
    if (!_poemCategoryArray) {
        _poemCategoryArray = [TRPoemCategory parsePoetryCategory];
    }
    return _poemCategoryArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poemCategoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    TRPoemCategory *category = self.poemCategoryArray[indexPath.row];
    cell.poemLabel.text = category.poemCategory;
    //button是否显示
    if (category.categoryIntroduction.length == 0) {
        cell.poemButton.hidden = YES;
    } else {
        //显示诗词分类的详情视图控制器
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //数据来源
    TRPoemCategory *category = self.poemCategoryArray[indexPath.row];
    TRPoemListTableViewController *poemListViewController = [[TRPoemListTableViewController alloc] initWithCategory:category];
    //push显示当前分类的所有诗词列表
    [self.navigationController pushViewController:poemListViewController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  TRPoemListTableViewController.m
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TRPoemListTableViewController.h"
#import "TRPoem.h"
#import "TRPoemDetailTableViewController.h"

@interface TRPoemCell : UITableViewCell
@end

@implementation TRPoemCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
@end



@interface TRPoemListTableViewController ()
//选择的某个诗词分类的string
@property (nonatomic, strong) NSString *categoryStr;
@property (nonatomic, strong) NSArray *poemArray;
@end

@implementation TRPoemListTableViewController
- (NSArray *)poemArray {
    if (!_poemArray) {
        _poemArray = [TRPoem poetryListWithCategory:self.categoryStr];
    }
    return _poemArray;
}

- (id)initWithCategory:(TRPoemCategory *)category {
    if (self = [super init]) {
        //初始化categoryStr(五言古诗...)
        self.categoryStr = category.poemCategory;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册TRPoemCell到tableView上
    [self.tableView registerClass:[TRPoemCell class] forCellReuseIdentifier:@"poemCell"];
    //设置标题
    self.navigationItem.title = @"诗词列表";
    
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRPoemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"poemCell" forIndexPath:indexPath];
    
    // Configure the cell...
    TRPoem *poem = self.poemArray[indexPath.row];
    cell.textLabel.text = poem.poemTitle;
    cell.detailTextLabel.text = poem.poemAuthor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TRPoem *poem = self.poemArray[indexPath.row];
    TRPoemDetailTableViewController *detailViewController = [[TRPoemDetailTableViewController alloc] initWithPoem:poem];
    [self.navigationController pushViewController:detailViewController animated:YES];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
//修改左滑的文本
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除此诗";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //数据来源
        TRPoem *poem = self.poemArray[indexPath.row];
        if ([TRPoem removePoem:poem.poemID]) {
            //更新数据源(已经从删除后的表获取数据)
            self.poemArray = [TRPoem poetryListWithCategory:self.categoryStr];
            
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

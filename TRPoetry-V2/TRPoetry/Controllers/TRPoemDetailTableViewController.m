//
//  TRPoemDetailTableViewController.m
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TRPoemDetailTableViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>

@interface TRPoemDetailCell : UITableViewCell
@property (nonatomic, strong) UILabel *label;

@end

@implementation TRPoemDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        //在cell的contentView上添加一个UILabel
        self.label = [UILabel new];
        //显示多行
        self.label.numberOfLines = 0;
        [self.contentView addSubview:self.label];
        //设置约束(Masonry)
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}

@end






@interface TRPoemDetailTableViewController ()<AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) TRPoem *poem;
//朗读Item
@property (nonatomic, strong) UIBarButtonItem *readItem;
//语音合成的对象
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@end
@implementation TRPoemDetailTableViewController
- (AVSpeechSynthesizer *)synthesizer {
    if (!_synthesizer) {
        _synthesizer = [AVSpeechSynthesizer new];
        _synthesizer.delegate = self;
    }
    return _synthesizer;
}

- (id)initWithPoem:(TRPoem *)poem {
    if (self = [super init]) {
        self.poem = poem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[TRPoemDetailCell class] forCellReuseIdentifier:@"detailCell"];
    
    //创建readItem并添加
    self.readItem = [[UIBarButtonItem alloc] initWithTitle:@"朗读" style:UIBarButtonItemStyleDone target:self action:@selector(readPoem)];
    self.navigationItem.rightBarButtonItem = self.readItem;
}
- (void)readPoem {
    //判定如果正在读, 设置成暂停
    if (self.synthesizer.speaking) {
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        return;
    }
    //AVSpeechSynthesizer --> 播放动作
    //AVSpeechUtterance --> 设置语言/音调/语速
    //AVSpeechSynthesizerDelegate
    //说话方式对象(指定说的内容)
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:[self.poem.poemContent stringByAppendingString:self.poem.poemIntroduction]];
    //设置说话的语言
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
    //设置音量[0.0 ~ 1.0]
//    utterance.volume = 1.0;
//    //设置语速
//    utterance.rate = 0.1;
//    //设置语调
//    utterance.pitchMultiplier = 1.0;
    
    //开始说话
    [self.synthesizer speakUtterance:utterance];
}

#pragma mark --- SpeechDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    //监听到暂停的动作
    self.readItem.title = @"朗读";
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    //监听到读完`
    self.readItem.title = @"朗读";
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    //监听到开始读
    self.readItem.title = @"暂停";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//设置section的title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"诗词鉴赏",@"注解"][section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRPoemDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    // Configure the cell...
    cell.label.text = @[self.poem.poemContent, self.poem.poemIntroduction][indexPath.section];
    
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
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

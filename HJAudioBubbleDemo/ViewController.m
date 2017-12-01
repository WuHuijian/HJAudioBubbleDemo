//
//  ViewController.m
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/11/30.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJAudioBubbleCell.h"
#import "HJAudioBubbleConfig.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor lightGrayColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[HJAudioBubbleCell class] forCellReuseIdentifier:@"HJAudioBubbleCell"];
    [self.view addSubview:tableView];
    
    //配置bubbleConfig单例模型 配置自选
    kHJAudioBubbleConfig.leftBubbleBgColor = [UIColor yellowColor];
    kHJAudioBubbleConfig.rightBubbleBgColor = [UIColor purpleColor];
    kHJAudioBubbleConfig.iconMargin = 5.f;
    kHJAudioBubbleConfig.timeShowType = HJAudioBubbleTimeShowType_inContainer;
    kHJAudioBubbleConfig.timeColor = [UIColor redColor];
    kHJAudioBubbleConfig.timeFont = [UIFont boldSystemFontOfSize:12];
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HJAudioBubbleCell backCellHeight];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HJAudioBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJAudioBubbleCell"];
    NSString *title;
    if (indexPath.row == 0) {
        kHJAudioBubbleConfig.timeShowType = HJAudioBubbleTimeShowType_inContainer;
        title = @"老师：用北造句。小明：胡萝北";
    }else if (indexPath.row == 1){
        kHJAudioBubbleConfig.timeShowType = HJAudioBubbleTimeShowType_outContainer;
        title = @"我喜欢你笑起来的样子\n因为你笑起来像个傻子";
    }else if (indexPath.row == 2){
        kHJAudioBubbleConfig.timeShowType = HJAudioBubbleTimeShowType_none;
        title = @"别对我大呼小叫，我小时候被狗吓过";
    }else if (indexPath.row == 3){
        //设置气泡图片
        kHJAudioBubbleConfig.timeShowType = HJAudioBubbleTimeShowType_inContainer;
        kHJAudioBubbleConfig.leftBubbleImage = [UIImage imageNamed:@"AudioBubbleBg"];
        kHJAudioBubbleConfig.rightBubbleImage = [UIImage imageNamed:@"AudioBubbleBg"];
        kHJAudioBubbleConfig.leftBubbleBgColor = [UIColor clearColor];
        kHJAudioBubbleConfig.rightBubbleBgColor = [UIColor clearColor];
        kHJAudioBubbleConfig.iconMargin = 20.f;
        title = @"好好活下去，每天都有新的打击";
    }else if (indexPath.row == 4){
        title = @"杀马特强子因为失恋割腕自杀了，她60岁的母亲抱着他放声痛哭：”我的命怎么这么苦啊 叫我白发人送红、橙、黄、绿、青、蓝、紫发人啊“";
    }
    [cell showRight:indexPath.row%2];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    cell.longPressCallBack = ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你瞅啥" message:title delegate:self cancelButtonTitle:@"哈哈哈" otherButtonTitles:nil, nil];
        [alert show];
    };
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


@end

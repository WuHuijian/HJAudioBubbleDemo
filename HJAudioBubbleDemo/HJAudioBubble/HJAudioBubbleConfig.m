//
//  HJAudioBubbleConfig.m
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/12/1.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import "HJAudioBubbleConfig.h"


@implementation HJAudioBubbleConfig


#pragma mark - 单例内容
static  HJAudioBubbleConfig * shareSingleton;

+ (instancetype)sharedAudioBubbleConfig{
    static  dispatch_once_t  onceToken;
    dispatch_once (&onceToken, ^ {
        shareSingleton  =  [[super allocWithZone:NULL] init] ;
        [shareSingleton buildDefaultDatas];
    } );
    return shareSingleton;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedAudioBubbleConfig] ;
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [self sharedAudioBubbleConfig];
}

#pragma mark - 业务内容
- (void)buildDefaultDatas{
    
    //设置播放动画图片
    self.duration = 0.5f;
    
    self.iconMargin = 5.f;
    
    self.voiceDefaultImage = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
    
    self.voiceAnimationImages = @[
                [UIImage imageNamed:@"ReceiverVoiceNodePlaying001"],
                [UIImage imageNamed:@"ReceiverVoiceNodePlaying002"],
                [UIImage imageNamed:@"ReceiverVoiceNodePlaying003"]];
    
    //设置时长默认显示样式
    self.timeShowType =  HJAudioBubbleTimeShowType_inContainer;
    self.timeFont = [UIFont systemFontOfSize:12];
    self.timeColor = [UIColor darkGrayColor];
    
}



@end


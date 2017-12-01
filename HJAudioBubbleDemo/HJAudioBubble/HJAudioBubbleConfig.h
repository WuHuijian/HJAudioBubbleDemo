//
//  HJAudioBubbleConfig.h
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/12/1.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HJAudioBubble;

#define kHJAudioBubbleConfig [HJAudioBubbleConfig sharedAudioBubbleConfig]

/** 时长显示样式控制 */
typedef NS_ENUM(NSUInteger, HJAudioBubbleTimeShowType) {
    HJAudioBubbleTimeShowType_inContainer  =  0,//时长显示在按钮中
    HJAudioBubbleTimeShowType_outContainer =  1,//时长显示在按钮外
    HJAudioBubbleTimeShowType_none      =  2//不显示时长
};



/**
 *  HJAudioBubble 的配置文件
 */

@interface HJAudioBubbleConfig : NSObject

+ (instancetype)sharedAudioBubbleConfig;


/** 当前正在动画的AudioBubble */
@property (nonatomic, weak) HJAudioBubble *animatingBubble;

#pragma mark - 页面显示控制

/**
 * 气泡图片要求：
 * 1.左右图片要求同一方向图，内部自动翻转方向
 * 2.左右图片可设置同一张图片
 */
/** 左边气泡图片 */
@property (nonatomic, strong) UIImage *leftBubbleImage;
/** 右边气泡图片 */
@property (nonatomic, strong) UIImage *rightBubbleImage;

/** 左边气泡背景色 */
@property (nonatomic, strong) UIColor *leftBubbleBgColor;
/** 右边气泡背景色 */
@property (nonatomic, strong) UIColor *rightBubbleBgColor;

/**
 * 动画控制
 */
/** 声音默认图片 */
@property (nonatomic, strong) UIImage *voiceDefaultImage;
/** 声音图片数组 */
@property (nonatomic, strong) NSArray *voiceAnimationImages;
/** 声音动画时长 */
@property (nonatomic, assign) CGFloat duration;
/** 动画图片居左边距离 */
@property (nonatomic, assign) CGFloat iconMargin;



/** 时长显示样式 */
@property (nonatomic, assign) HJAudioBubbleTimeShowType timeShowType;
/** 时长字体 */
@property (nonatomic, strong) UIFont *timeFont;
/** 时长颜色 */
@property (nonatomic, strong) UIColor *timeColor;








@end


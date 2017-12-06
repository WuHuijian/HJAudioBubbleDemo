//
//  HJAudioBubble.h
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/11/30.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJAudioBubbleConfig.h"


typedef void(^BubbleLongPressCallBack)();

@interface HJAudioBubble : UIView

/** 时长 */
@property (nonatomic, copy) NSString * timeStr;
/** 右边显示气泡 */
@property (nonatomic, assign) BOOL bubbleShowRight;
/** 长按回调 */
@property (nonatomic, copy) BubbleLongPressCallBack longPressCallBack;
/** 点击回调 */
@property (nonatomic, copy) void(^bubbleClickBlock)(BOOL isAnimating);

//开始动画
- (void)startAnimating;
//结束动画
- (void)stopAnimating;
//刷新界面
- (void)refreshUI;

@end

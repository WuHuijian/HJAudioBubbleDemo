//
//  HJAudioBubbleCell.h
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/11/30.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CellBubbleLongPressCallBack)();

@interface HJAudioBubbleCell : UITableViewCell


/** 长按回调 */
@property (nonatomic, copy)CellBubbleLongPressCallBack longPressCallBack;

- (void)showRight:(BOOL)right;

//返回cell高度
+ (CGFloat)backCellHeight;

@end

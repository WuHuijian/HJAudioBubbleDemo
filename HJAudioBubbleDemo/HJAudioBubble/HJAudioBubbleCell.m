//
//  HJAudioBubbleCell.m
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/11/30.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import "HJAudioBubbleCell.h"
#import "HJAudioBubble.h"

@interface HJAudioBubbleCell ()

/** 音频气泡 */
@property (nonatomic, strong) HJAudioBubble *bubble;

@end


#define kScreenW               [UIScreen mainScreen].bounds.size.width
#define kScreenH               [UIScreen mainScreen].bounds.size.height

static const CGFloat kCellHeight = 80.f;
static const CGFloat kBubbleW    = 150.f;
static const CGFloat kBubbleH    = 40.f;

@implementation HJAudioBubbleCell

#pragma mark - Life Circle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

#pragma mark - About UI
- (void)setupUI{
    
    [self.contentView addSubview:self.bubble];
    self.bubble.timeStr = @"50s";
}


#pragma mark - Pravite Method

#pragma mark - Public Method
- (void)showRight:(BOOL)right;{
    if (!right) {
        self.bubble.frame = CGRectMake(10, 0, kBubbleW, kBubbleH);
    }else{
        self.bubble.frame = CGRectMake(kScreenW-kBubbleW-10, 0, kBubbleW, kBubbleH);
    }
    self.bubble.center = CGPointMake(self.bubble.center.x, kCellHeight/2.f);
    self.bubble.bubbleShowRight = right;
}

+ (CGFloat)backCellHeight{
    
    return kCellHeight;
}
#pragma mark - Event response

#pragma mark - Delegate methods

#pragma mark - Getters/Setters/Lazy
- (HJAudioBubble *)bubble{
    if (!_bubble) {
        _bubble = [[HJAudioBubble alloc] init];
    }
    return _bubble;
}

- (void)setLongPressCallBack:(CellBubbleLongPressCallBack)longPressCallBack{
    self.bubble.longPressCallBack = longPressCallBack;
}
@end

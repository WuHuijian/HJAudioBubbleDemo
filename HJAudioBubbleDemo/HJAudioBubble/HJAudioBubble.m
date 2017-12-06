//
//  HJAudioBubble.m
//  HJAudioBubbleDemo
//
//  Created by WHJ on 2017/11/30.
//  Copyright © 2017年 WHJ. All rights reserved.
//

#import "HJAudioBubble.h"

@interface HJAudioBubble ()
/** 背景气泡图片 */
@property (nonatomic, strong) UIImageView *baseView;

/** 播放图片 */
@property (nonatomic, strong) UIImageView *playIconV;

/** 时长显示 */
@property (nonatomic, strong) UILabel *timeLabel;

/** HJAudioBubbleConfig */
@property (nonatomic, strong) HJAudioBubbleConfig *bubbleConfig;

@end

static const CGFloat kTimeLabelW = 60.f;
static const CGFloat kPlayIconW = 20.f;

@implementation HJAudioBubble


#pragma mark - Life Circle
-(instancetype)initWithFrame:(CGRect)frame;{
    self = [super initWithFrame:frame];
    if(self){
        [self setupUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - About UI


- (void)setupUI{
    
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.playIconV];
    [self addSubview:self.timeLabel];
    self.bubbleConfig = kHJAudioBubbleConfig;
    [self refreshUI];
}

- (void)prepareLayout{
    
    //布局baseView
    CGFloat baseW = 0;
    if (self.bubbleConfig.timeShowType == HJAudioBubbleTimeShowType_inContainer) {
        baseW = CGRectGetWidth(self.frame);
    }else if (self.bubbleConfig.timeShowType == HJAudioBubbleTimeShowType_outContainer){
        baseW = CGRectGetWidth(self.frame) - kTimeLabelW;
    }else{
        baseW = CGRectGetWidth(self.frame);
    }
    
    self.baseView.frame = CGRectMake(0, 0, baseW, CGRectGetHeight(self.frame));
    self.baseView.center = CGPointMake(self.baseView.center.x, CGRectGetHeight(self.frame)/2.f);
    
    
    //布局playIconV
    CGFloat baseViewH = CGRectGetHeight(self.baseView.frame);
    self.playIconV.frame = CGRectMake(self.bubbleConfig.iconMargin, 0, kPlayIconW, kPlayIconW);
    self.playIconV.center = CGPointMake(self.playIconV.center.x, CGRectGetHeight(self.frame)/2.f);
    
    //布局timeLabel
    self.timeLabel.frame = CGRectMake(0, 0, kTimeLabelW, baseViewH);
    self.timeLabel.hidden = NO;
}


- (void)hj_layout{
    
    //布局前准备
    [self prepareLayout];
    
    CGFloat baseViewH = CGRectGetHeight(self.baseView.frame);
    CGFloat baseW = CGRectGetWidth(self.baseView.frame);
    
    //根据时长显示位置及气泡左右调整布局
    switch (self.bubbleConfig.timeShowType) {
        case HJAudioBubbleTimeShowType_inContainer:
            self.timeLabel.center = self.baseView.center;
            if (self.bubbleShowRight) {
               self.baseView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            }else{
               self.baseView.layer.transform = CATransform3DIdentity;
            }
            break;
        case HJAudioBubbleTimeShowType_outContainer:
            if (self.bubbleShowRight) {
                self.timeLabel.frame = CGRectMake(0, 0, kTimeLabelW, baseViewH);
                self.baseView.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), 0, baseW, CGRectGetHeight(self.frame));
                self.baseView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            }else{
                self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.baseView.frame), 0, kTimeLabelW, baseViewH);
                self.baseView.layer.transform = CATransform3DIdentity;
            }
            break;
        case HJAudioBubbleTimeShowType_none:
            if (self.bubbleShowRight) {
                self.baseView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            }else{
                self.baseView.layer.transform = CATransform3DIdentity;
            }
            self.timeLabel.hidden = YES;
            break;
        default:
            break;
    }
}

#pragma mark - Pravite Method
- (UIImage *)handleBubbleImage:(UIImage *)image{
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width-10) topCapHeight:floorf(image.size.height-10)];
    return image;
}

#pragma mark - Public Method
//开始动画
- (void)startAnimating;{
    if (self.bubbleConfig.animatingBubble) {
        [self.bubbleConfig.animatingBubble stopAnimating];
        self.bubbleConfig.animatingBubble = nil;
    }
    [self.playIconV startAnimating];
    self.bubbleConfig.animatingBubble = self;
}
//结束动画
- (void)stopAnimating;{
    
    [self.playIconV stopAnimating];
}
#pragma mark - Event response
- (void)audioBubbleClicked:(UITapGestureRecognizer *)tap{
    
    if (self.playIconV.isAnimating) {
        [self stopAnimating];
    }else{
        [self startAnimating];
    }
    if (self.bubbleClickBlock) {
        self.bubbleClickBlock(self.playIconV.isAnimating);
    }
}

- (void)audioBubbleLongPress:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateEnded) {
        if (self.longPressCallBack) {
            self.longPressCallBack();
            [self stopAnimating];
        }
    }
   
}
#pragma mark - Delegate methods

#pragma mark - Getters/Setters/Lazy
- (UIImageView *)baseView{
    if (!_baseView) {
        _baseView = [[UIImageView alloc] init];
        _baseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(audioBubbleClicked:)];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(audioBubbleLongPress:)];
        [_baseView addGestureRecognizer:tap];
        [_baseView addGestureRecognizer:longPress];
    }
    return _baseView;
}


- (UIImageView *)playIconV{
    if (!_playIconV) {
        _playIconV = [[UIImageView alloc] init];
        _playIconV.userInteractionEnabled = YES;
        _playIconV.backgroundColor = [UIColor clearColor];
        _playIconV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _playIconV;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor darkGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    return _timeLabel;
}

//设置气泡显示位置
- (void)setBubbleShowRight:(BOOL)bubbleShowRight{
    _bubbleShowRight = bubbleShowRight;
    
    [self refreshUI];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];

    [self refreshUI];
}

//设置时长
- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    self.timeLabel.text = timeStr;
}

- (void)refreshUI{
    //设置气泡
    self.baseView.image = self.bubbleShowRight?self.bubbleConfig.rightBubbleImage:self.bubbleConfig.leftBubbleImage;
    self.baseView.backgroundColor = self.bubbleShowRight?self.bubbleConfig.rightBubbleBgColor:self.bubbleConfig.leftBubbleBgColor;
    
    //设置播放动画图片
    _playIconV.image = self.bubbleConfig.voiceDefaultImage;
    _playIconV.animationDuration = self.bubbleConfig.duration;
    _playIconV.animationImages = self.bubbleConfig.voiceAnimationImages;
    
    
    //设置时长样式
    _timeLabel.font = kHJAudioBubbleConfig.timeFont;
    _timeLabel.textColor = kHJAudioBubbleConfig.timeColor;
    
    //重新布局
    [self hj_layout];
}

@end

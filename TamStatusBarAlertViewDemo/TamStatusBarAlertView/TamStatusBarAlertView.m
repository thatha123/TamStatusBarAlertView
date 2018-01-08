//
//  TamStatusBarAlertView.m
//  TamStatusBarAlertViewDemo
//
//  Created by xin chen on 2017/8/17.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamStatusBarAlertView.h"
//#import "AppDelegate.h"

// 屏幕的宽和高
#define TamScreenWith [UIScreen mainScreen].bounds.size.width
#define TamScreenHeight [UIScreen mainScreen].bounds.size.height
//是否为IphoneX
#define TamIS_iPhoneX (TamScreenWith == 375 && TamScreenHeight == 812)
//状态栏高
#define TamStatusBarHeight (20+(TamIS_iPhoneX ? 24 : 0))

static const int CountTime = 4;

@interface TamStatusBarAlertView()

@property(nonatomic,weak)UILabel *alertLabel;
@property(nonatomic,strong)dispatch_source_t timer;
@property(nonatomic,assign)int currentTime;
@property(nonatomic,copy)TouchEventBlock touchEventBlock;

@end

@implementation TamStatusBarAlertView
static TamStatusBarAlertView *_statusBaralertView;

+(TamStatusBarAlertView *)shareInstance
{
    if (_statusBaralertView == nil) {
        _statusBaralertView = [[TamStatusBarAlertView alloc]init];
        _statusBaralertView.isCanTouch = YES;
        _statusBaralertView.frame = CGRectMake(0, -TamStatusBarHeight, [UIScreen mainScreen].bounds.size.width, TamStatusBarHeight);NSLog(@"%d",TamStatusBarHeight);
        _statusBaralertView.windowLevel = UIWindowLevelStatusBar+1.0;
        [_statusBaralertView makeKeyAndVisible];
    }
    return _statusBaralertView;
}

-(void)startTimer
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        self.currentTime--;
        if (self.currentTime <= 0) {
            [TamStatusBarAlertView dissmiss];
        }
    });
    dispatch_resume(timer);
    self.timer = timer;
}

-(void)stopTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [TamStatusBarAlertView dissmiss];
    if (self.touchEventBlock && self.isCanTouch) {
        self.touchEventBlock();
    }
}

+(void)showMessage:(NSString *)message touchEventBlock:(TouchEventBlock)touchEventBlock
{
    [self showMessage:message];
    _statusBaralertView.touchEventBlock = touchEventBlock;
}

+(void)showMessage:(NSString *)message
{
    [TamStatusBarAlertView shareInstance];
    _statusBaralertView.alertLabel.text = message;
    _statusBaralertView.currentTime = CountTime;
//    [[AppDelegate shareAppDelegate].window makeKeyAndVisible];//把原先的视图放上面
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _statusBaralertView.frame;
        rect.origin.y = 0;
        _statusBaralertView.frame = rect;
    }completion:^(BOOL finished) {
        [_statusBaralertView startTimer];
    }];
    
}

+(void)dissmiss
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _statusBaralertView.frame;
        rect.origin.y = -TamStatusBarHeight;
        _statusBaralertView.frame = rect;
    }completion:^(BOOL finished) {
        [_statusBaralertView stopTimer];
    }];
}

-(void)dealloc
{
    [_statusBaralertView stopTimer];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    UILabel *alertLabel = [[UILabel alloc]init];
    self.alertLabel = alertLabel;
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.font = [UIFont systemFontOfSize:13];
    alertLabel.frame = CGRectMake(0, TamIS_iPhoneX ? 24 : 0, TamScreenWith, TamIS_iPhoneX ? 24 : 20);
    [self addSubview:alertLabel];
}

@end

//
//  TamStatusBarAlertView.h
//  TamStatusBarAlertViewDemo
//
//  Created by xin chen on 2017/8/17.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchEventBlock)();

@interface TamStatusBarAlertView : UIWindow

+(TamStatusBarAlertView *)shareInstance;
+(void)showMessage:(NSString *)message touchEventBlock:(TouchEventBlock)touchEventBlock;
+(void)showMessage:(NSString *)message;
+(void)dissmiss;

@property(nonatomic,assign)BOOL isCanTouch;//是否能点击

@end

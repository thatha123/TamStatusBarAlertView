//
//  ViewController.m
//  TamStatusBarAlertViewDemo
//
//  Created by xin chen on 2017/8/17.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "ViewController.h"
#import "TamStatusBarAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [TamStatusBarAlertView showMessage:@"楼主霸气！楼主帅" touchEventBlock:^{
        NSLog(@"你摸了我");
    }];
}

@end

//
//  StudyStatusBarHUD.m
//  StudyStatusBarHUD
//
//  Created by 周新刚 on 16/7/7.
//  Copyright © 2016年 zxg. All rights reserved.
//

#import "StudyStatusBarHUD1.h"

#define XMGMessageFont [UIFont systemFontOfSize:12]

/** 消息的停留时间 */
static CGFloat const XMGMessageDuration = 2.0;
/** 消息显示\隐藏的动画时间 */
static CGFloat const XMGAnimationDuration = 0.25;

@implementation StudyStatusBarHUD

/** 全局的窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;

/**
 * 显示窗口
 */
+ (void)showWindow{
    // 窗口的frame
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    // 显示窗口 每次新创建窗口的时候，将之前的窗口隐藏起来
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    // 将window_的层级放到最前面显示，否则会被状态栏时间影响
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = frame;
    // 显示新创建的窗口
    window_.hidden = NO;
    
    // 做动画
    frame.origin.y = 0;
    [UIView animateWithDuration:XMGAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+(void)showMessage:(NSString *)msg image:(UIImage *)image{

    // 停止存在的定时器
    [timer_ invalidate];
    // 显示窗口
    [self showWindow];
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:(UIControlStateNormal)];
    button.titleLabel.font = XMGMessageFont;
    if (image) {
        [button setImage:image forState:(UIControlStateNormal)];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }
    button.frame = window_.frame;
    [window_ addSubview:button];
    
    // 创建定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:XMGMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示失败信息
 */
+(void)showError:(NSString *)msg{

    [self showMessage:msg image:[UIImage imageNamed:@"StudyStatusBarHUD1.bundle/error"]];
}

/**
 * 显示成功信息
 */
+(void)showSuccess:(NSString *)msg{

    [self showMessage:msg image:[UIImage imageNamed:@"StudyStatusBarHUD1.bundle/success"]];
}

/**
 * 显示普通信息
 */
+(void)showMessage:(NSString *)msg{

    [self showMessage:msg image:nil];
}

/**
 * 显示正在处理的信息
 */
+(void)showLoading:(NSString *)msg{
    // 停止定时器,让他一直显示
    [timer_ invalidate];
    timer_ = nil;
    // 显示窗口
    [self showWindow];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = XMGMessageFont;
    label.frame = window_.frame;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    // 添加指示器
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    // 开始动画
    [loadingView startAnimating];
    // 计算文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName:XMGMessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.center.y;
    // 指示器的center
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/**
 * 隐藏
 */
+ (void)hide{
    // 做动画
    [UIView animateWithDuration:XMGAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}

@end

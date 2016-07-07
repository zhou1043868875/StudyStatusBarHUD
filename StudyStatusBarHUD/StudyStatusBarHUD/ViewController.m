//
//  ViewController.m
//  StudyStatusBarHUD
//
//  Created by 周新刚 on 16/7/7.
//  Copyright © 2016年 zxg. All rights reserved.
//

#import "ViewController.h"
#import "StudyStatusBarHUD1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 成功
- (IBAction)success:(id)sender {
    
    [StudyStatusBarHUD showSuccess:@"成功"];
}

// 失败
- (IBAction)error:(id)sender {
    [StudyStatusBarHUD showError:@"加载失败"];
}

// 加载中
- (IBAction)loading:(id)sender {
    [StudyStatusBarHUD showLoading:@"正在加载"];
}

// 隐藏
- (IBAction)hide:(id)sender {
    [StudyStatusBarHUD hide];
}

// 发送文字信息
- (IBAction)message:(id)sender {
    [StudyStatusBarHUD showMessage:@"无图加载"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

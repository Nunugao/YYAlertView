//
//  ViewController.m
//  YYAlertView
//
//  Created by manager on 16/11/16.
//  Copyright © 2016年 Rockontrol. All rights reserved.
//

#import "ViewController.h"
#import "YYAlertView.h"

@interface ViewController ()<YYALertviewDelegate>
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self button];

}
- (void)click:(id)sender {
    [self loadAlertView:@"确定要这样子操作吗?" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"确定",@"取消", nil] type:11];
}
- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr
{
    //初始化alertView
    YYAlertView *alertView = [[YYAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
}
-(void)didClickButtonAtIndex:(NSUInteger)index gzName:(NSString *)gzName{
    switch (index) {
        case 101:
            NSLog(@"Click ok");
            break;
        case 100:
            NSLog(@"Click cancle");
            
            break;
        default:
            break;
    }
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_button];
        _button.frame = CGRectMake(50, 100, 88, 50);
        [_button setTitle:@"提示框" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

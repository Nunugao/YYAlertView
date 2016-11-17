//
//  YYAlertView.m
//  microHealth
//
//  Created by manager on 16/11/16.
//  Copyright © 2016年 Rockontrol. All rights reserved.
//

#import "YYAlertView.h"
#define k_w [UIScreen mainScreen].bounds.size.width
#define k_h [UIScreen mainScreen].bounds.size.height

@implementation YYAlertView
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_w, k_h)];
        _blackView.backgroundColor = [UIColor clearColor];
        _blackView.alpha = 0.8;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackClick)];
        [self.blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
        //创建alert
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 190)];
        self.alertview.center = self.center;
        self.alertview.layer.cornerRadius = 17;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.6];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tipView = [[UIView alloc]initWithFrame:CGRectMake(0,0,270,43)];
    [_tipView setBackgroundColor:[UIColor blueColor]];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    iv.image = [UIImage imageNamed:@"my_highlighted@2x"];
    [self.tipView addSubview:iv];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 180, 30)];
    lb.text = _title;
    [lb setFont:[UIFont systemFontOfSize:18]];
    [lb setTextColor:[UIColor blackColor]];
    lb.textAlignment = NSTextAlignmentLeft;
    [self.tipView addSubview:lb];

    
    [self.alertview addSubview:_tipView];
    
    self.alertview.frame = CGRectMake(0, 0, 270, 170);
    
    [self creatViewWithAlert];
    self.alertview.center = CGPointMake(self.center.x, self.center.y);
    
    [self createBtnTitle:_btnTitleArr];
}


- (void)creatViewWithAlert
{
    _textF =[[UITextField alloc]initWithFrame:CGRectMake(15, _tipView.frame.origin.y+20+ _tipView.frame.size.height, self.alertview.frame.size.width-30, 40)];
    _textF.secureTextEntry = YES;
    _textF.borderStyle = UITextBorderStyleRoundedRect;
    _textF.returnKeyType = UIReturnKeyDone;
    _textF.delegate = self;
    [_textF becomeFirstResponder];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textF.frame)+20, self.alertview.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.alertview addSubview:_textF];
    
}

- (void)createBtnTitle:(NSArray *)titleArr
{
    
    CGFloat m = self.alertview.frame.size.width;
    
    for (int i=0; i<_numBtn; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_numBtn == 2) {
//            btn.frame = CGRectMake(20, self.alertview.frame.size.height-48,(m-40), 33);
//        }else{
            
            btn.frame = CGRectMake(20+i*(20+(m-60)/2), self.alertview.frame.size.height-48, (m-60)/2, 33);
            btn.backgroundColor = [UIColor greenColor];
        }
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
//        [btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [self.alertview addSubview:btn];
    }
}
- (void)blackClick
{
    [self cancleView];
}
- (void)cancleView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
    
}
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

-(void)clickButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:gzName:)]) {
        if (_gzName == nil) {
            [self textFieldShouldEndEditing:_textF];
            [_textF resignFirstResponder];
        }
        [self.delegate didClickButtonAtIndex:button.tag gzName:_gzName];
    }
    [self cancleView];
}
-(void)initWithTitle:(NSString *) title contentStr:(NSString *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr

{
    _title = title;
    _type = type;
    _numBtn = btnNum;
    _btnTitleArr = btnTitleArr;
    _contentStr = content;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    //    DLog(@"%@",textField.text);
    _gzName = textField.text;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}@end

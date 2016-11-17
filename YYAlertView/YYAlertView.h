//
//  YYAlertView.h
//  microHealth
//
//  Created by manager on 16/11/16.
//  Copyright © 2016年 Rockontrol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index gzName:(NSString *)gzName;

@end

@interface YYAlertView : UIView<UITextFieldDelegate>

@property (nonatomic,strong)UIView *blackView;
@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)NSString * title;
@property (nonatomic,copy)NSString *contentStr;
@property (nonatomic,strong)UIView *tipView;
@property (weak,nonatomic) id<YYALertviewDelegate> delegate;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger numBtn;
@property (nonatomic,copy)NSString *gzName;
@property (nonatomic,retain)NSArray *btnTitleArr;
@property (nonatomic,retain)UITextField *textF;
-(void)initWithTitle:(NSString *) title contentStr:(NSString *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr;

@end

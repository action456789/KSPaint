//
//  ViewController.m
//  KSPaint
//
//  Created by KeSen on 15/7/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "ViewController.h"
#import "BottomItemView.h"
#import "KSPaintView.h"
#import "KSPanToolScrollView.h"
#import "KSColorToolScrollView.h"
#import "ButtonItem.h"
#import "KSPaint.h"



@interface ViewController () <BottomItemViewDelegate, KSToolScrolViewDelegate>

@property (weak, nonatomic) IBOutlet BottomItemView *bottomItemView;  // 最底部的工具条
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;  // 主按钮
@property (weak, nonatomic) IBOutlet KSPaintView *paintView;  // 画布视图
@property (nonatomic, strong) KSPanToolScrollView *brusherView; // 画笔工具条
@property (nonatomic, strong) KSColorToolScrollView *colorView; // 颜色工具条

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bottomItemView.delegate = self;
    
    [self addBtns];
    
    [self.view insertSubview:self.bottomItemView aboveSubview:self.paintView];
    
    
    self.paintView.tapBlock = ^{
        if (self.bottomItemView.show) {
            [self hideBottomView];
        }
    };

//    NSLog(@"\n self.view.bounds:%@\n applicationFrame:%@\n [UIScreen mainScreen].bounds:%@\n", NSStringFromCGRect(self.view.bounds), NSStringFromCGRect([UIScreen mainScreen].applicationFrame), NSStringFromCGRect([UIScreen mainScreen].bounds));
}

- (void)addBtns {
    
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"画笔"];
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"颜色"];
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"背景"];
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"填充"];
}

- (void)ShowBottomView {
    self.bottomItemView.show = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomItemView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -self.bottomItemView.frame.size.height);
        self.mainBtn.hidden = YES;

    }];
}

- (void)hideBottomView {
    self.bottomItemView.show = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomItemView.transform = CGAffineTransformIdentity;
        self.mainBtn.hidden = NO;
        self.brusherView.hidden = YES;
        
        for (ButtonItem *item in self.bottomItemView.subviews) {
            if (item.selected) {
                item.selected = NO;
            }
        }
    }];
}

- (IBAction)showMenuClick:(id)sender {
    
    if (!self.bottomItemView.show) {
        [self ShowBottomView];
    } else {
        [self hideBottomView];
    }
}

/**
 *  底部ItemView中，点击画笔按钮时出现的工具条
 */
- (KSPanToolScrollView *)brusherView {
    if (_brusherView == nil) {
        KSPanToolScrollView *brusherView = [[KSPanToolScrollView alloc] init];
        brusherView.tollScrolViewDelegate = self;
      
        [UIView animateWithDuration:0.5 animations:^{
            [self.view addSubview:brusherView];
        }];

        _brusherView = brusherView;
    }
    return _brusherView;
}

- (KSColorToolScrollView *)colorView {
    if (_colorView == nil) {
        KSColorToolScrollView *colorView = [[KSColorToolScrollView alloc] init];
        colorView.tollScrolViewDelegate = self;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view addSubview:colorView];
        }];
        
        _colorView = colorView;
    }
    return _colorView;
}

- (void)bottomItemView:(BottomItemView *)bottomItemView didSelectItemFrom:(NSInteger)from to:(NSInteger)to {
    
    if (!self.bottomItemView.show) return;
    switch (to) {
        case 0: {   //画笔
            self.brusherView.hidden = NO;
            break;
        }
        case 1: {   //颜色
            self.brusherView.hidden = YES;
            self.colorView;
            break;
        }
        case 2: {   //背景
            self.brusherView.hidden = YES;
            break;
        }
        case 3: {   //填充
            self.brusherView.hidden = YES;
            break;
        }
        default:
            break;
    }
}

#pragma KSTollScrollViewDelegate
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedForm:(KSSelectedForm)form {
    self.paintView.selectedForm = form;
}

@end

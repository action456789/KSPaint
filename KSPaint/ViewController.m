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
#import "KSToolScrollView.h"

#define kBrusherViewH 44


@interface ViewController () <BottomItemViewDelegate>

@property (weak, nonatomic) IBOutlet BottomItemView *bottomItemView;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet KSPaintView *paintView;
@property (nonatomic, strong) KSToolScrollView *brusherView;

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
- (KSToolScrollView *)brusherView {
    if (_brusherView == nil) {
        KSToolScrollView *brusherView = [[KSToolScrollView alloc] init];
        CGFloat brusherViewW = self.view.bounds.size.width;
        CGFloat brusherViewY = self.view.bounds.size.height - self.bottomItemView.bounds.size.height - kBrusherViewH;
        brusherView.frame = CGRectMake(0, brusherViewY, brusherViewW, kBrusherViewH);
        [UIView animateWithDuration:0.5 animations:^{
            [self.view addSubview:brusherView];
        }];

        _brusherView = brusherView;
    }
    return _brusherView;
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

/**
 *  toolScrollView
 */

@end

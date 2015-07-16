//
//  ViewController.m
//  KSPaint
//
//  Created by KeSen on 15/7/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "ViewController.h"
#import "BottomItemView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet BottomItemView *bottomItemView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBtns];
    
}

- (void)addBtns {
    
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"绘图"];
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"绘图"];
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal2" selectedImgName:@"btn_freehand_pressed" titleName:@"绘图"];
}

- (IBAction)showMenuClick:(id)sender {
    
    if (!self.bottomItemView.show) {
        self.bottomItemView.show = YES;
    } else {
        self.bottomItemView.show = NO;
    }
}

@end

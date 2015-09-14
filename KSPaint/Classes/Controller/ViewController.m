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
#import "MBProgressHUD+KS.h"

@interface ViewController () <BottomItemViewDelegate, KSToolScrolViewDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet BottomItemView *bottomItemView;  // 底部的工具条
@property (weak, nonatomic) IBOutlet BottomItemView *TopItemView; // 顶部工具条
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;  // 主按钮
@property (weak, nonatomic) IBOutlet KSPaintView *paintView;  // 画布视图
@property (weak, nonatomic) IBOutlet UIButton *undoBtn;  // 撤销按钮
@property (weak, nonatomic) IBOutlet UIButton *redoBtn;  // 取消撤销按钮

@property (nonatomic, strong) KSPanToolScrollView *panView; // 画笔工具条
@property (nonatomic, strong) KSColorToolScrollView *colorView; // 颜色工具条
@property (nonatomic, strong) KSColorToolScrollView *bgToolView; // 画笔工具条
@property (nonatomic, strong) KSColorToolScrollView *fillToolView; // 画笔工具条

@property (nonatomic, strong) KSToolScrollView *showingToolView; // 正在显示的工具条
@property (nonatomic, strong) NSMutableArray *tools; // 存放所有工具条

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bottomItemView.delegate = self;
    
    [self addBottomItemViewBtns];
    
    [self addTopItemViewBtns];
    
    [self.view insertSubview:self.bottomItemView aboveSubview:self.paintView];
    
    [self.view insertSubview:self.TopItemView aboveSubview:self.paintView];
    
    __weak typeof(self) weakSelf = self;
    self.paintView.tapBlock = ^{
        if (weakSelf.bottomItemView.show) {
            // 隐藏最底部工具条
            weakSelf.bottomItemView.show = NO;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.bottomItemView.transform = CGAffineTransformIdentity;
                
                if (weakSelf.showingToolView) {
                    CGFloat H = [UIScreen mainScreen].bounds.size.height - weakSelf.showingToolView.frame.origin.y;
                    weakSelf.showingToolView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, H);
                }

                // 显示主按钮
                weakSelf.mainBtn.transform = CGAffineTransformIdentity;
                weakSelf.mainBtn.hidden = NO;
                
                // 隐藏 undo, redo 按钮
                self.redoBtn.transform = CGAffineTransformIdentity;
                self.undoBtn.transform = CGAffineTransformIdentity;
            }];
        }
    };
}

// 添加底部按钮
- (void)addBottomItemViewBtns {
    
    [self.bottomItemView addButtonItemWithName:@"btn_freehand_normal" selectedImgName:@"btn_freehand_highlight" titleName:@"画笔"];
    [self.bottomItemView addButtonItemWithName:@"btn_colorpicker" selectedImgName:@"btn_colorpicker" titleName:@"颜色"];
    [self.bottomItemView addButtonItemWithName:@"btn_setbg_normal" selectedImgName:@"btn_setbg_pressed" titleName:@"背景"];
    [self.bottomItemView addButtonItemWithName:@"btn_fillpel_normal" selectedImgName:@"btn_fillpel_pressed" titleName:@"填充"];
}

// 添加顶部按钮
- (void)addTopItemViewBtns {
    
    __weak typeof(self) weakSelf = self;
    
    // 添加保存按钮
    [self.TopItemView addButtonItemWithImgName:@"btn_freehand_normal" selectedImgName:@"btn_freehand_highlight" titleName:@"画笔" block:^(id sender) {
        
        // 截屏即可保存
        UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, NO, 0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [weakSelf.paintView.layer renderInContext:ctx];
        UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 保存到相册，只能是这个方法
        UIImageWriteToSavedPhotosAlbum(newImg, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
}

- (void)didReceiveMemoryWarning {
    [self.paintView.graphs removeAllObjects];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [MBProgressHUD showSuccess:@"保存成功"];
    }else {
        [MBProgressHUD showError:@"保存失败"];
    }
}

#pragma mark - 按钮点击
// 点击了主按钮
- (IBAction)mainButtonClick:(id)sender {
    // 显示最底部工具条
    if (!self.bottomItemView.show) {
        self.bottomItemView.show = YES;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomItemView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -self.bottomItemView.frame.size.height);
            
            if (self.showingToolView) {
                self.showingToolView.transform = CGAffineTransformIdentity;
            }
            
            // 隐藏主按钮
            self.mainBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.mainBtn.hidden = YES;
            
            // 显示 undo, redo 按钮
            CGFloat undoBtnDeltaX = self.undoBtn.frame.size.width + kUndoBtnMargin;
            CGFloat redoBtnDeltaX = self.redoBtn.frame.size.width + kRedoBtnMargin;
            self.undoBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, undoBtnDeltaX, 0);
            self.redoBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -redoBtnDeltaX, 0);
        }];
    }
}

#pragma mark - getter 方法
- (NSMutableArray *)tools {
    if (_tools == nil) {
        _tools = [NSMutableArray array];
    }
    return _tools;
}

- (KSPanToolScrollView *)panView {
    if (_panView == nil) {
        KSPanToolScrollView *panView = [[KSPanToolScrollView alloc] init];
        panView.tollScrolViewDelegate = self;
        [self.tools addObject:panView];
        _panView = panView;
    }
    return _panView;
}

- (KSColorToolScrollView *)colorView {
    if (_colorView == nil) {
        KSColorToolScrollView *colorView = [[KSColorToolScrollView alloc] init];
        colorView.tollScrolViewDelegate = self;
        [self.tools addObject:colorView];
        _colorView = colorView;
    }
    return _colorView;
}

- (KSColorToolScrollView *)bgToolView {
    if (_bgToolView == nil) {
        KSColorToolScrollView *bgTollView = [[KSColorToolScrollView alloc] init];
        bgTollView.tollScrolViewDelegate = self;
        [self.tools addObject:bgTollView];
        _bgToolView = bgTollView;
        bgTollView.backgroundColor = [UIColor blackColor];
    }
    return _bgToolView;
}

- (KSColorToolScrollView *)fillToolView {
    if (_fillToolView == nil) {
        KSColorToolScrollView *fillTollView = [[KSColorToolScrollView alloc] init];
        fillTollView.tollScrolViewDelegate = self;
        [self.tools addObject:fillTollView];
        _fillToolView = fillTollView;
        fillTollView.backgroundColor = [UIColor greenColor];
    }
    return _fillToolView;
}

# pragma mark - bottomItemView delegate
- (void)bottomItemView:(BottomItemView *)bottomItemView didSelectItemFrom:(NSInteger)from to:(NSInteger)to {
   
    [self.showingToolView removeFromSuperview];
    
    switch (to) {
        case 0: {   //画笔
            [self.paintView addSubview:self.panView];
            self.showingToolView = self.panView;

            break;
        }
        case 1: {   //颜色
            [self.paintView addSubview:self.colorView];
            self.showingToolView = self.colorView;

            break;
        }
        case 2: {   //背景
            [self.paintView addSubview:self.bgToolView];
            self.showingToolView = self.bgToolView;
            break;
        }
        case 3: {   //填充
            [self.paintView addSubview:self.fillToolView];
            self.showingToolView = self.fillToolView;
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

- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedColor:(UIColor *)color {
    self.paintView.color = color;
}
@end

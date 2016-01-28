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
#import "KSSharpToolView.h"
#import "KSPenToolView.h"
#import "ButtonItem.h"
#import "KSPaint.h"
#import "MBProgressHUD+KS.h"
#import "KSTopView.h"
#import "KSHandleImageView.h"
#import "UIImage+KS.h"
#import "UMSocial.h"
#import "KSUMShareToolVc.h"
#import "KSColorToolView.h"
#import "KSBgToolView.h"

#import <Crashlytics/Crashlytics.h>


#define kShowingView [[UIApplication sharedApplication].windows lastObject]

@interface ViewController () <BottomItemViewDelegate, KSToolScrolViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic  ) IBOutlet BottomItemView        *bottomItemView;// 底部的工具条
@property (weak, nonatomic  ) IBOutlet KSTopView             *topView;// 顶部工具条
@property (weak, nonatomic  ) IBOutlet UIButton              *mainBtn;// 主按钮
@property (weak, nonatomic  ) IBOutlet KSPaintView           *paintView;// 画布视图
@property (weak, nonatomic  ) IBOutlet UIButton              *undoBtn;// 撤销按钮
@property (weak, nonatomic  ) IBOutlet UIButton              *redoBtn;// 取消撤销按钮

@property (nonatomic, strong) KSSharpToolView  *sharpView;// 形状工具条
@property (nonatomic, strong) KSPenToolView    *penView;// 画笔工具条
@property (nonatomic, strong) KSBgToolView     *bgToolView;// 背景色工具条
@property (nonatomic, strong) KSColorToolView  *colorToollView;// 颜色工具条
@property (nonatomic, strong) KSToolScrollView *showingToolView;// 正在显示的工具条

@property (nonatomic, strong) KSUMShareToolVc  *shareVc;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bottomItemView.delegate = self;
    
    [self addBottomItemViewBtns];
    
    [self addTopItemViewBtns];
    
    [self.view insertSubview:self.bottomItemView aboveSubview:kShowingView];
    [self.view insertSubview:self.topView aboveSubview:kShowingView];
    [self.view insertSubview:self.mainBtn aboveSubview:kShowingView];
    [self.view insertSubview:self.redoBtn aboveSubview:kShowingView];
    [self.view insertSubview:self.undoBtn aboveSubview:kShowingView];
    
    self.paintView.tapBlock = ^{
        
        if (self.bottomItemView.show) {
            
            [self showAnim];
        }
    };
   
    // 监听添加图片通知
    [[NSNotificationCenter defaultCenter] addObserverForName:kHandleImageNotification object: nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        [self showAnim];
    }];
    
    // crashlytics
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 50, 100, 30);
    [button setTitle:@"Crash" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//- (IBAction)crashButtonTapped:(id)sender {
//    [[Crashlytics sharedInstance] crash];
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// 添加底部按钮
- (void)addBottomItemViewBtns {
    
    [self.bottomItemView addButtonItemWithName:@"btn_freehand" selectedImgName:@"btn_freehand_highlight" titleName:@"笔触"];
    [self.bottomItemView addButtonItemWithName:@"btn_rect" selectedImgName:@"btn_rect_highlight" titleName:@"形状"];
    [self.bottomItemView addButtonItemWithName:@"btn_colorpicker" selectedImgName:@"btn_colorpicker" titleName:@"颜色"];
    [self.bottomItemView addButtonItemWithName:@"btn_fillpel_normal" selectedImgName:@"btn_fillpel_pressed" titleName:@"背景"];
}

// 添加顶部按钮
- (void)addTopItemViewBtns {
    
    // 添加保存按钮
    [self.topView addButtonWithImgName:@"btn_freehand_normal" highlightImgName:@"btn_freehand_highlight" titleName:@"保存" block:^(id sender) {
       
        [self saveImg];
    }];
    
    // 添加从相册选择图片按钮
    [self.topView addButtonWithImgName:@"btn_setbg_normal" highlightImgName:@"btn_setbg_pressed" titleName:@"照片" block:^(id sender) {
        
        [self selectImgFormAlbum];
    }];
    
    // 添加分享按钮
    [self.topView addButtonWithImgName:@"btn_setbg_normal" highlightImgName:@"btn_setbg_pressed" titleName:@"分享" block:^(id sender) {
        
        [self share];
    }];
    
    // 添加支持按钮
    [self.topView addButtonWithImgName:@"btn_setbg_normal" highlightImgName:@"btn_setbg_pressed" titleName:@"支持" block:^(id sender) {
        
        [self donate];
    }];
}

# pragma mark - 支付
- (void)donate {
    NSURL *url = [NSURL URLWithString:@"https://api.mch.weixin.qq.com/pay/unifiedorder?"];
    
}

# pragma mark - 友盟分享

- (void)share {
    
    KSUMShareToolVc *umShareVc = [[KSUMShareToolVc alloc] init];
    
    UIImage *sharedImage = [UIImage imageWithCaptureView:self.paintView ];
    
    [umShareVc shareImage:sharedImage text:@"友盟分享" target:self];
    
    _shareVc = umShareVc;
}

# pragma mark - 从相册选择图片
- (void)selectImgFormAlbum {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 保存图片
- (void)saveImg {
    
    if (self.paintView.paths.count == 0) return;
    
    // 截屏即可保存
    UIImage *newImg = [UIImage imageWithCaptureView:self.paintView];
    
    // 保存到相册，只能是这个方法
    UIImageWriteToSavedPhotosAlbum(newImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 完成图片选择一定要是这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [MBProgressHUD showSuccess:@"已保存到相册"];
    }else {
        [MBProgressHUD showError:@"保存失败"];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    KSHandleImageView *handle = [[KSHandleImageView alloc] initWithFrame:self.paintView.frame];
    handle.image = info[@"UIImagePickerControllerOriginalImage"];
    
    handle.block = ^(UIImage *img){
        
        self.paintView.image = img;
    };
    
    [self.view addSubview:handle];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - set 方法


#pragma mark - 动画
- (void)showAnim{
    
    // 隐藏最底部工具条
    self.bottomItemView.show = NO;
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.bottomItemView.transform = CGAffineTransformIdentity;
        
        if (self.showingToolView) {
            CGFloat H = [UIScreen mainScreen].bounds.size.height - self.showingToolView.frame.origin.y;
            self.showingToolView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, H);
        }
        
        // 显示主按钮
        self.mainBtn.transform = CGAffineTransformIdentity;
        self.mainBtn.hidden = NO;
        
        // 隐藏 undo, redo 按钮
        self.redoBtn.transform = CGAffineTransformIdentity;
        self.undoBtn.transform = CGAffineTransformIdentity;
        
        // 显示 顶部工具条
        self.topView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

// 隐藏动画
- (void)hideAnim {
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
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
        
        // 显示顶部按钮
        CGFloat topViewDeltaY = self.topView.frame.size.height;
        self.topView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, topViewDeltaY);
    } completion:nil];
}

#pragma mark - 按钮点击
// 点击了主按钮
- (IBAction)mainButtonClick:(id)sender {
    // 显示最底部工具条
    if (!self.bottomItemView.show) {
        self.bottomItemView.show = YES;
        
        // 隐藏动画
        [self hideAnim];
    }
}

// 点击了撤销按钮
- (IBAction)undoClick:(UIButton *)sender {
    [self.paintView undo];
}

// 点击了取消撤销按钮
- (IBAction)redoClick:(UIButton *)sender {
    [self.paintView redo];
}

#pragma mark - getter 方法
- (KSSharpToolView *)sharpView {
    if (_sharpView == nil) {
        KSSharpToolView *sharpView = [[KSSharpToolView alloc] init];
        sharpView.tollScrolViewDelegate = self;
        _sharpView = sharpView;
    }
    return _sharpView;
}

- (KSPenToolView *)penView {
    if (_penView == nil) {
        KSPenToolView *penView = [[KSPenToolView alloc] init];
        penView.tollScrolViewDelegate = self;
        _penView = penView;
    }
    return _penView;
}

- (KSBgToolView *)bgToolView {
    if (_bgToolView == nil) {
        KSBgToolView *bgTollView = [[KSBgToolView alloc] init];
        bgTollView.tollScrolViewDelegate = self;
        _bgToolView = bgTollView;
        bgTollView.backgroundColor = [UIColor blackColor];
    }
    return _bgToolView;
}

- (KSColorToolView *)colorToollView {
    if (_colorToollView == nil) {
        KSColorToolView *colorToolView = [[KSColorToolView alloc] init];
        colorToolView.tollScrolViewDelegate = self;
        _colorToollView = colorToolView;
        colorToolView.backgroundColor = [UIColor blackColor];
    }
    return _colorToollView;
}

# pragma mark - bottomItemView delegate
- (void)bottomItemView:(BottomItemView *)bottomItemView didSelectItemFrom:(NSInteger)from to:(NSInteger)to {
   
    [self.showingToolView removeFromSuperview];
    
    switch (to) {
        case 0: {// 画笔
            [self.view insertSubview:self.penView aboveSubview:kShowingView];
            self.showingToolView = self.penView;

            break;
        }
        case 1: {   //形状
            [self.view insertSubview:self.sharpView aboveSubview:kShowingView];
            self.showingToolView = self.sharpView;

            break;
        }
        case 2: {   //颜色
            [self.view insertSubview:self.colorToollView aboveSubview:kShowingView];
            self.showingToolView = self.colorToollView;
            NSLog(@"%@", self.colorToollView);
            break;
        }
        case 3: {   //背景
            [self.paintView insertSubview:self.bgToolView aboveSubview:kShowingView];
            self.showingToolView = self.bgToolView;
            
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

- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedPen:(KSPen)pen {
    self.paintView.pen = pen;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.paintView.graphs removeAllObjects];
}
@end

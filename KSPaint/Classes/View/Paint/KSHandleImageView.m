//
//  KSHandleImageView.m
//  KSPaint
//
//  Created by KeSen on 15/9/21.
//  Copyright © 2015年 KeSen. All rights reserved.
//  点击选择

#import "KSHandleImageView.h"
#import "UIImage+KS.h"

@interface KSHandleImageView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation KSHandleImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 添加一个 UIImageView
        UIImageView *iV = [[UIImageView alloc] initWithFrame:self.frame];
        iV.userInteractionEnabled = YES;
        iV.contentMode = UIViewContentModeScaleAspectFit;
        _imageView = iV;
        [self addSubview:_imageView];
        
        // 添加手势
        [self addGestures];
        
        // 添加通知
        [self addNotification];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    self.imageView.image = image;
}

- (void)addNotification {
    
    // 发出通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:kHandleImageNotification object:self];
}

- (void)addGestures {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    rotate.delegate = self;
    [self addGestureRecognizer:rotate];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    [self animate];
}

- (void)pan:(UIPanGestureRecognizer *)pan {

    CGPoint pos = [pan translationInView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, pos.x, pos.y);
    [pan setTranslation:CGPointZero inView:self.imageView];
}

- (void)rotate:(UIRotationGestureRecognizer *)rotate {
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotate.rotation);
    rotate.rotation = 0;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture {

    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        [self animate];
    }
}

- (void) animate {
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        
        _imageView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            
            _imageView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            if (_block) {
                UIImage *newImg = [UIImage imageWithCaptureView:self];
                _block(newImg);
            }
            
            [self removeFromSuperview];
        }];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end

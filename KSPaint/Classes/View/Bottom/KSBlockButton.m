//
//  KSBlockButton.m
//  KSPaint
//
//  Created by KeSen on 15/9/1.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSBlockButton.h"

@implementation KSBlockButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor clearColor];
        
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (instancetype)initWithImageName:(NSString *)normal selected:(NSString *)selected block:(ButtomClickblock)block {
    
    KSBlockButton *btn = [[KSBlockButton alloc] init];
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
    btn.btnBlock = block;
    
    return btn;
    
}

+ (instancetype)buttonWithImageName:(NSString *)normal selected:(NSString *)selected block:(ButtomClickblock)block {
    
    KSBlockButton *btn = [[KSBlockButton alloc] initWithImageName:normal selected:selected block:block];
    
    return btn;
}


- (void)btnClick:(KSBlockButton *)sender {
    if (sender.btnBlock) {
        sender.btnBlock(sender);
    }
}

@end

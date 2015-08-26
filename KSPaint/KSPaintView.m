//
//  KSPaintView.m
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSPaintView.h"
#import "KSPaintBezierPath.h"

@interface KSPaintView ()
{
    UIBezierPath *_path;
}
@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation KSPaintView

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self initSet];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    
    self.backgroundColor = [UIColor clearColor];
    
}

- (NSMutableArray *)paths {
    
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.tapBlock) {
        self.tapBlock();
    }
    
    CGPoint startP = [[touches anyObject] locationInView:self];
    
    // 画线
    if (self.selectedFrom == KSLine) {
        KSPaintBezierPath *path = [KSPaintBezierPath paintBezierPathWithColor:[UIColor blackColor] lineWidth:2.0 startPoint:startP];
        [path moveToPoint:startP];
        _path = path;
        [self.paths addObject:path];
    }

    // 画矩形
    if (self.selectedFrom == KSRect) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(startP.x, startP.y, 0, 0)];
        _path = path;
        [self.paths addObject:path];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint endP = [[touches anyObject] locationInView:self];
    
    if (self.selectedFrom == KSLine) {
        [_path addLineToPoint:endP];
    }
    
    if (self.selectedFrom == KSRect) {
        
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    for (UIBezierPath *p in self.paths) {
        [p stroke];
    }
    
}
@end

//
//  KSPaintView.m
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSPaintView.h"
#import "KSPaintBezierPath.h"
#import "KSRectPath.h"

@interface KSPaintView ()
{
    UIBezierPath *_path; // 曲线
    CGPoint _startPoint; // 起点
}
/**
 *  存放线条路径数组
 */
@property (nonatomic, strong) NSMutableArray *paths;
/**
 *  矩形路径
 */
@property (nonatomic, strong) UIBezierPath *rectPath;
/**
 *  存放一次绘图时，其他形状的路径
 */
@property (nonatomic, strong) NSMutableArray *graphs;
/**
 *  椭圆
 */
@property (nonatomic, strong) UIBezierPath *ovalPath;

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

- (NSMutableArray *)graphs {
    if (_graphs == nil) {
        _graphs = [NSMutableArray array];
    }
    return _graphs;
}

- (UIBezierPath *)rectPath {
    if (_rectPath == nil) {
        _rectPath = [KSRectPath bezierPath];
    }
    return _rectPath;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.tapBlock) {
        self.tapBlock();
    }
    
    CGPoint startP = [[touches anyObject] locationInView:self];
    _startPoint = startP;
    
    // 画线
    if (self.selectedForm == KSLine) {
        KSPaintBezierPath *path = [KSPaintBezierPath paintBezierPathWithColor:[UIColor blackColor] lineWidth:2.0 startPoint:startP];
        [path moveToPoint:startP];
        _path = path;
        [self.paths addObject:path];
    }

    // 画矩形
    if (self.selectedForm == KSRect) {
        [self.graphs removeAllObjects];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint endP = [[touches anyObject] locationInView:self];
    CGPoint previewP = [[touches anyObject] previousLocationInView:self];
    
    CGFloat rectPreW = previewP.x - _startPoint.x;
    CGFloat rectPreH = previewP.y - _startPoint.y;
    CGRect preRect = CGRectMake(_startPoint.x, _startPoint.y, rectPreW, rectPreH);
    
    // 画线
    if (self.selectedForm == KSLine) {
        [_path addLineToPoint:endP];
    }
    
    // 画矩形
    if (self.selectedForm == KSRect) {
        self.rectPath = [KSRectPath bezierPathWithRect:preRect];
        [self.graphs addObject:self.rectPath];
    }
    
    // 画椭圆
    if (self.selectedForm == KSOval) {
        self.ovalPath = [UIBezierPath bezierPathWithOvalInRect:preRect];
        [self.graphs addObject:self.ovalPath];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIBezierPath *lastGraph = self.graphs.lastObject;
    if (lastGraph) {
        [self.paths addObject:lastGraph];
    }
}

- (void)drawRect:(CGRect)rect {
    
    // 画线
    for (UIBezierPath *p in self.paths) {
        [p stroke];
    }
    
    // 画其他
    KSRectPath *lastGraph = self.graphs.lastObject;
    if (lastGraph) {
        [lastGraph stroke];
    }
}
@end

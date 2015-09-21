//
//  KSPaintView.m
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSPaintView.h"
#import "KSPaintPath.h"

@interface KSPaintView ()
{
    KSPaintPath *_path; // 画线的路径
    CGPoint _startPoint; // 起点
}
/**
 *  矩形路径
 */
@property (nonatomic, strong) KSPaintPath *rectPath;

/**
 *  椭圆
 */
@property (nonatomic, strong) KSPaintPath *ovalPath;



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

- (void)setImage:(UIImage *)image {
    
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.tapBlock) {
        self.tapBlock();
    }
    
    CGPoint startP = [[touches anyObject] locationInView:self];
    _startPoint = startP;
    
    // 画线
    if (self.selectedForm == KSLine) {
        KSPaintPath *path = [KSPaintPath paintpathWithBezierpath:[[UIBezierPath alloc] init] color:self.color];
        [path.bezierPath moveToPoint:startP];
        [self.paths addObject:path];
        _path = path;
    }

    // 画矩形、圆
    if (self.selectedForm == KSRect || self.selectedForm == KSOval) {
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
        [_path.bezierPath addLineToPoint:endP];
    }
    
    // 画矩形
    if (self.selectedForm == KSRect) {
        UIBezierPath *bezierP = [UIBezierPath bezierPathWithRect:preRect];
        KSPaintPath *rectPath = [KSPaintPath paintpathWithBezierpath:bezierP color:self.color];
        [self.graphs addObject:rectPath];
    }
    
    // 画椭圆
    if (self.selectedForm == KSOval) {
        UIBezierPath *bezierP = [UIBezierPath bezierPathWithOvalInRect:preRect];
        KSPaintPath *ovalPath = [KSPaintPath paintpathWithBezierpath:bezierP color:self.color];
        [self.graphs addObject:ovalPath];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    KSPaintPath *lastGraph = self.graphs.lastObject;
    if (lastGraph) {
        [self.paths addObject:lastGraph];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches cancelled!");
    [self.graphs removeLastObject];
}

- (void)drawRect:(CGRect)rect {
    // 画线
    for (KSPaintPath *p in self.paths) {
        
        if ([p isKindOfClass:[UIImage class]]) {
            UIImage *img = (UIImage *)p;
            [img drawInRect:rect];
        }else {
            [p.pathColor set];
            [p.bezierPath stroke];
        }
    }
    
    // 画其他
    KSPaintPath *lastGraph = self.graphs.lastObject;
    if (lastGraph) {
        [lastGraph.pathColor set];
        [lastGraph.bezierPath stroke];
    }
}

- (NSMutableArray *)undoPaths {
    if (_undoPaths == nil) {
        _undoPaths = [NSMutableArray array];
    }
    return _undoPaths;
}

// 点击了撤销按钮
- (void)undo {
    if (self.paths.count == 0) {
        return;
    }
    KSPaintPath *path = [self.paths lastObject];
    [self.undoPaths addObject:path];
    
    [self.paths removeLastObject];
    
    [self.graphs removeAllObjects];
    
    [self setNeedsDisplay];
}

// 点击了取消撤销按钮
- (void)redo {
    if (self.undoPaths.count == 0) {
        return;
    }
    KSPaintPath *path = [self.undoPaths objectAtIndex:0];
    [self.paths addObject:path];
    
    [self.undoPaths removeObjectAtIndex:0];
    
    [self.graphs removeAllObjects];
    
    [self setNeedsDisplay];
}
@end

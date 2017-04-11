//
//  KSPaintView.m
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSPaintView.h"
#import "KSPaintPath.h"


static CGFloat dashs[3] = {10.0, 10.0};

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

@property (nonatomic, strong) CAShapeLayer *lineLayer;

/***  存放所有路径数组 */
@property (nonatomic, strong) NSMutableArray    *paths;

/***  存放可以被撤销的，矩形、圆形状的Layer或图片*/
@property (nonatomic, strong) NSMutableArray *undoLayers;

/***  存放被反撤销了的，矩形、圆形状的Layer或图片*/
@property (nonatomic, strong) NSMutableArray *redoLayers;

@end

@implementation KSPaintView


#pragma mark - lifecycle
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
    _undoLayers = [NSMutableArray array];
    _redoLayers= [NSMutableArray array];
    _width = 1.0;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.tapBlock) {
        self.tapBlock();
    }
    
    CGPoint startP = [[touches anyObject] locationInView:self];
    _startPoint = startP;
    
    // 画线
    if (self.selectedForm == KSLine) {
        KSPaintPath *path = [KSPaintPath paintpathWithBezierpath:[[UIBezierPath alloc] init] color:self.color width:self.width];
        
        [path.bezierPath moveToPoint:startP];
        _path = path;
        
        // 虚线
        if (self.pen == KSPenDash) {
            [path.bezierPath setLineDash:dashs count:2 phase:0];
        }
        
        // 橡皮擦
        if (self.pen == KSPenEraser) {
            path.pathColor = [UIColor whiteColor];
        }
    }

    // 画矩形、圆
    if (self.selectedForm == KSRect || self.selectedForm == KSOval) {
        
    }
    
    CAShapeLayer *sharpLayer = [CAShapeLayer layer];
    sharpLayer.path = _path.bezierPath.CGPath;
    sharpLayer.frame = self.layer.frame;
    sharpLayer.lineWidth = _path.width;
    sharpLayer.strokeColor = [UIColor blackColor].CGColor;
    sharpLayer.fillColor = [UIColor clearColor].CGColor;
    self.lineLayer = sharpLayer;
    [self.layer addSublayer:sharpLayer];
    
    [self.undoLayers addObject:sharpLayer];
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
        
        self.lineLayer.path = _path.bezierPath.CGPath;
    }
    
    // 画矩形
    if (self.selectedForm == KSRect) {
        UIBezierPath *bezierP = [UIBezierPath bezierPathWithRect:preRect];
        
        // 虚线
        if (self.pen == KSPenDash) {
            [bezierP setLineDash:dashs count:2 phase:0];
        }
        KSPaintPath *rectPath = [KSPaintPath paintpathWithBezierpath:bezierP color:self.color width:self.width];
        
        self.lineLayer.path = rectPath.bezierPath.CGPath;
    }
    
    // 画椭圆
    if (self.selectedForm == KSOval) {
        UIBezierPath *bezierP = [UIBezierPath bezierPathWithOvalInRect:preRect];
        // 虚线
        if (self.pen == KSPenDash) {
            [bezierP setLineDash:dashs count:2 phase:0];
        }
        KSPaintPath *ovalPath = [KSPaintPath paintpathWithBezierpath:bezierP color:self.color width:self.width];
        
        self.lineLayer.path = ovalPath.bezierPath.CGPath;
    }
    
    // 调用 - (void)drawRect:(CGRect)rect 方法画图，效率比较低
//    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

/*
- (void)drawRect:(CGRect)rect {
    
    // 画线
    for (KSPaintPath *p in self.paths) {
        
        if ([p isKindOfClass:[UIImage class]]) {
            UIImage *img = (UIImage *)p;
            [img drawInRect:rect];
        }else {
            p.bezierPath.lineWidth = p.width;
            [p.pathColor set];
            [p.bezierPath stroke];
        }
    }
    
    // 画其他
    KSPaintPath *lastGraph = self.graphs.lastObject;
    if (lastGraph) {
        lastGraph.bezierPath.lineWidth = lastGraph.width;
        [lastGraph.pathColor set];
        [lastGraph.bezierPath stroke];
    }
}
*/

// 画图片
- (void)drawRect:(CGRect)rect {
    for (id obj in self.undoLayers) {
        if ([obj isKindOfClass:[UIImage class]]) {
            [obj drawInRect:rect];
        }
    }
}

#pragma mark - event

// 点击了撤销按钮
- (void)undo {
    if (self.undoLayers.count == 0) {
        return;
    }
    
    if ([self.undoLayers.lastObject isKindOfClass:[CAShapeLayer class]]) {
        CAShapeLayer *layer = (CAShapeLayer *)self.undoLayers.lastObject;
        
        [self.redoLayers addObject:layer];
        
        [layer removeFromSuperlayer];
        
        [self.undoLayers removeLastObject];
        
    } else if ([self.undoLayers.lastObject isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)self.undoLayers.lastObject;
        
        [self.redoLayers addObject:image];
        
        [self.undoLayers removeLastObject];
        
        [self setNeedsDisplay];
    }
}

// 点击了取消撤销按钮
- (void)redo {
    if (self.redoLayers.count == 0) {
        return;
    }

    if ([self.redoLayers.lastObject isKindOfClass:[CAShapeLayer class]]) {
        CAShapeLayer *layer = (CAShapeLayer *)self.redoLayers.lastObject;
        
        [self.layer addSublayer:layer];
        
        [self.undoLayers addObject:layer];
        
        [self.redoLayers removeLastObject];
        
    } else if ([self.redoLayers.lastObject isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)self.redoLayers.lastObject;
        
        [self.undoLayers addObject:image];
        
        [self.redoLayers removeLastObject];
        
        [self setNeedsDisplay];
    }

}

#pragma mark - getter
- (NSMutableArray *)paths {
    
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

#pragma mark - setter
- (void)setImage:(UIImage *)image {
    
    _image = image;
    [self.undoLayers addObject:image];
    [self setNeedsDisplay];
}

@end

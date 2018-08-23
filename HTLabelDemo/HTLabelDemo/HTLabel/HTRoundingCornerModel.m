//
//  HTRoundingCornerModel.m
//  test
//
//  Created by nsyworker on 2018/8/22.
//  Copyright © 2018年 nsyworker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTRoundingCornerModel.h"

@interface HTRoundingCornerModel ()
@property (nonatomic,strong) CAShapeLayer * maskLayer;
@property (nonatomic,strong) UIBezierPath * path;
@property(nonatomic) CGSize size;

@end

@implementation HTRoundingCornerModel

-(instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.size = view.bounds.size;
        _path = [UIBezierPath bezierPath];
        _roundingCornerType = HTRoundingCornerTypeAllCorners;
        _cornerRadius = 0;
        _maskLayer = [CAShapeLayer layer];
        [view.layer setMask:_maskLayer];
    }
    return self;
}


-(instancetype)initWithLayer:(CALayer *)layer
{
    self = [super init];
    if (self) {
        self.size = layer.bounds.size;
        _path = [UIBezierPath bezierPath];
        _roundingCornerType = HTRoundingCornerTypeAllCorners;
        _cornerRadius = 0;
        _maskLayer = [CAShapeLayer layer];
        [layer setMask:_maskLayer];
    }
    return self;
}

-(void)setRoundingCornerType:(HTRoundingCornerType)roundingCornerType
{
    _roundingCornerType = roundingCornerType;
    [self ht_layoutSubviews];
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self ht_layoutSubviews];
}

-(void)ht_layoutSubviews
{
    self.maskLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    
    if (self.cornerRadius<0) self.cornerRadius = 0;
    
    [self.path removeAllPoints];
    
    CGSize size = self.size;
    
    CGPoint controlPoint_1 = CGPointMake(size.width, 0);
    CGPoint controlPoint_2 = CGPointMake(size.width, size.height);
    CGPoint controlPoint_3 = CGPointMake(0, size.height);
    CGPoint controlPoint_4 = CGPointMake(0, 0);
    
    
    CGPoint startPoint = CGPointMake(self.cornerRadius, 0);
    CGPoint point_1    = CGPointMake(size.width-self.cornerRadius, 0);
    CGPoint point_2    = CGPointMake(size.width, self.cornerRadius);
    CGPoint point_3    = CGPointMake(size.width, size.height-self.cornerRadius);
    CGPoint point_4    = CGPointMake(size.width-self.cornerRadius, size.height);
    CGPoint point_5    = CGPointMake(self.cornerRadius, size.height);
    CGPoint point_6    = CGPointMake(0, size.height-self.cornerRadius);
    CGPoint endPoint   = CGPointMake(0, self.cornerRadius);
    
    [self.path moveToPoint:startPoint];
    [self.path addLineToPoint:point_1];
    if (self.roundingCornerType & HTRoundingCornerTypeTopRight) {
        [self.path addQuadCurveToPoint:point_2 controlPoint:controlPoint_1];//右上圆角
    }else{
        [self.path addLineToPoint:controlPoint_1];
        [self.path addLineToPoint:point_2];
    }
    [self.path addLineToPoint:point_3];
    if (self.roundingCornerType & HTRoundingCornerTypeBottomRight) {
        [self.path addQuadCurveToPoint:point_4 controlPoint:controlPoint_2];//右下圆角
    }else{
        [self.path addLineToPoint:controlPoint_2];
        [self.path addLineToPoint:point_4];
    }
    [self.path addLineToPoint:point_5];
    if (self.roundingCornerType & HTRoundingCornerTypeBottomLeft) {
        [self.path addQuadCurveToPoint:point_6 controlPoint:controlPoint_3];//左下圆角
    }else{
        [self.path addLineToPoint:controlPoint_3];
        [self.path addLineToPoint:point_6];
    }
    [self.path addLineToPoint:endPoint];
    if (self.roundingCornerType & HTRoundingCornerTypeTopLeft) {
        [self.path addQuadCurveToPoint:startPoint controlPoint:controlPoint_4];//左上圆角
    }else{
        [self.path addLineToPoint:controlPoint_4];
        [self.path addLineToPoint:startPoint];
    }
    [self.path closePath];
    self.maskLayer.path = self.path.CGPath;
}

@end

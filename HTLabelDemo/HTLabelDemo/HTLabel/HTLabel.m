//
//  HTLabel.m
//  test
//
//  Created by nsyworker on 2018/8/22.
//  Copyright © 2018年 nsyworker. All rights reserved.
//

#import "HTLabel.h"


@interface HTLabel ()
@property (nonatomic,strong) CAShapeLayer * maskLayer;
@property (nonatomic,strong) UIBezierPath * path;
@end

@implementation HTLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maskLayer = [CAShapeLayer layer];
        [self.layer setMask:_maskLayer];
        _path = [UIBezierPath bezierPath];
        _roundingCornerType = HTLabeltCornerAllCorners;
        _cornerRadius = 0;
        _titleEdgeInsets = UIEdgeInsetsZero;
        _minFontSize = 0;
        _contentHorizontalAlignment = HTTextHorizontalAlignmentCenter;
    }
    return self;
}

-(void)setRoundingCornerType:(HTLabeltCornerType)roundingCornerType
{
    _roundingCornerType = roundingCornerType;
    [self setNeedsLayout];
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth
{
    [super setAdjustsFontSizeToFitWidth:adjustsFontSizeToFitWidth];
    [self setNeedsDisplay];
}

-(void)layoutSubviews
{
    self.maskLayer.frame = self.bounds;
    
    if (self.cornerRadius<0) self.cornerRadius = 0;
    
    [self.path removeAllPoints];
    
    CGSize size = self.bounds.size;
    
    CGPoint controlPoint_1 = CGPointMake(size.width, 0);
    CGPoint controlPoint_2 = CGPointMake(size.width, size.height);
    CGPoint controlPoint_3 = CGPointMake(0, size.height);
    CGPoint controlPoint_4 = CGPointMake(0, 0);

    
    CGPoint startPoint = CGPointMake(self.cornerRadius, 0);
    CGPoint point_1 = CGPointMake(size.width-self.cornerRadius, 0);
    CGPoint point_2 = CGPointMake(size.width, self.cornerRadius);
    CGPoint point_3 = CGPointMake(size.width, size.height-self.cornerRadius);
    CGPoint point_4 = CGPointMake(size.width-self.cornerRadius, size.height);
    CGPoint point_5 = CGPointMake(self.cornerRadius, size.height);
    CGPoint point_6 = CGPointMake(0, size.height-self.cornerRadius);
    CGPoint endPoint = CGPointMake(0, self.cornerRadius);
    
    [self.path moveToPoint:startPoint];
    [self.path addLineToPoint:point_1];
    if (self.roundingCornerType & HTLabeltCornerTopRight) {
        [self.path addQuadCurveToPoint:point_2 controlPoint:controlPoint_1];//右上圆角
    }else{
        [self.path addLineToPoint:controlPoint_1];
        [self.path addLineToPoint:point_2];
    }
    [self.path addLineToPoint:point_3];
    if (self.roundingCornerType & HTLabeltCornerBottomRight) {
        [self.path addQuadCurveToPoint:point_4 controlPoint:controlPoint_2];//右下圆角
    }else{
        [self.path addLineToPoint:controlPoint_2];
        [self.path addLineToPoint:point_4];
    }
    [self.path addLineToPoint:point_5];
    if (self.roundingCornerType & HTLabeltCornerBottomLeft) {
        [self.path addQuadCurveToPoint:point_6 controlPoint:controlPoint_3];//左下圆角
    }else{
        [self.path addLineToPoint:controlPoint_3];
        [self.path addLineToPoint:point_6];
    }
    [self.path addLineToPoint:endPoint];
    if (self.roundingCornerType & HTLabeltCornerTopLeft) {
        [self.path addQuadCurveToPoint:startPoint controlPoint:controlPoint_4];//左上圆角
    }else{
        [self.path addLineToPoint:controlPoint_4];
        [self.path addLineToPoint:startPoint];
    }
    [self.path closePath];
    self.maskLayer.path = self.path.CGPath;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    UIFont *font = self.font;

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    //label本身的尺寸
    CGRect bounds = self.bounds;

    //获取label减去内边距剩余的空间
    CGFloat contentW = bounds.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right;
    CGFloat contentH = bounds.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
    CGRect contentBounds = CGRectMake(0,
                                      0,
                                      contentW,
                                      contentH);
    
    CGSize currentTextSize = [self ht_sizeOfString:self.text Font:font limitWidth:contentW];
    CGSize nextTextSize = [self ht_sizeOfString:self.text Font:[font fontWithSize:font.pointSize+0.5] limitWidth:contentW];
    
    
    if (self.adjustsFontSizeToFitWidth == YES) {
        
        BOOL isContain = [self ht_contrastSize:currentTextSize destinationSize:contentBounds.size];
        BOOL isNextContain = [self ht_contrastSize:nextTextSize destinationSize:contentBounds.size];
        
        if (isContain && isNextContain) {
            //字体还能增大,且重新计算currentTextSize
            UIFont *newFont = [self ht_contrastAscendingByFont:font destinationSize:contentBounds.size];
            font = newFont;
            currentTextSize = [self ht_sizeOfString:self.text Font:font limitWidth:contentW];
        }else if (!isContain){
            //字体需要缩小,且重新计算currentTextSize  这里也意味着isNextContain==NO
            UIFont *newFont = [self ht_contrastDescendingByFont:font destinationSize:contentBounds.size];
            font = newFont;
            currentTextSize = [self ht_sizeOfString:self.text Font:font limitWidth:contentW];
        }else if (isContain && !isNextContain){
            //意味着字体大小刚刚好，不需要操作
        }
        [attributedText removeAttribute:NSFontAttributeName range:NSMakeRange(0, self.attributedText.length)];
        [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.attributedText.length)];
    }
    
    CGFloat textRectX = 0 + self.titleEdgeInsets.left;
    CGFloat textRectY = 0 + self.titleEdgeInsets.top;
    CGFloat textRectW = currentTextSize.width;
    CGFloat textRectH = currentTextSize.height;
    
    switch (_contentHorizontalAlignment) {
        case HTTextHorizontalAlignmentTop:
            textRectY = 0 + self.titleEdgeInsets.top;
            break;
        case HTTextHorizontalAlignmentCenter:
            textRectY = bounds.size.height/2.0 - textRectH/2.0;
            break;
        case HTTextHorizontalAlignmentBottom:
            textRectY = bounds.size.height - self.titleEdgeInsets.bottom - textRectH;
            break;
        default:
            textRectY = 0 + self.titleEdgeInsets.top;
            break;
    }

    CGRect textRect = CGRectMake(textRectX, textRectY, textRectW, textRectH);

    /// NSParagraphStyleAttributeName 这个属性影响换行，实际上没什么作用
    [attributedText removeAttribute:NSParagraphStyleAttributeName range:NSMakeRange(0, attributedText.length)];
    [attributedText drawInRect:textRect];
}

/**
 升序查找 大小合适的字体
 
 @param font 原始字体
 @param desSize 目标尺寸
 @return 返回刚好符合目标尺寸的字体
 */
- (UIFont *)ht_contrastAscendingByFont:(UIFont *)font destinationSize:(CGSize)desSize
{
    CGFloat fontSize = _minFontSize;

    for (CGFloat size = fontSize; size < 80; ) {
        UIFont *newFont = [font fontWithSize:size];
        CGSize newTextSize = [self ht_sizeOfString:self.text Font:newFont limitWidth:desSize.width];
        
        UIFont *lastFont = [font fontWithSize:size+0.5];
        CGSize lastTextSize = [self ht_sizeOfString:self.text Font:lastFont limitWidth:desSize.width];
        
        BOOL isContain = [self ht_contrastSize:newTextSize destinationSize:desSize];
        BOOL isLastContain = [self ht_contrastSize:lastTextSize destinationSize:desSize];

        if (isContain && !isLastContain) {
            return newFont;
        }
        size = size + 0.5;
    }
    return [font fontWithSize:80];
}


/**
 降序查找 大小合适的字体

 @param font 原始字体
 @param desSize 目标尺寸
 @return 返回刚好符合目标尺寸的字体
 */
- (UIFont *)ht_contrastDescendingByFont:(UIFont *)font destinationSize:(CGSize)desSize
{
    CGFloat fontSize = font.pointSize;
    for (CGFloat size = fontSize; size>0; ) {
        if (fontSize<=_minFontSize) {
            return [font fontWithSize:_minFontSize];
        }
        UIFont *newFont = [font fontWithSize:size];
        CGSize newTextSize = [self ht_sizeOfString:self.text Font:newFont limitWidth:desSize.width];
        BOOL isContain = [self ht_contrastSize:newTextSize destinationSize:desSize];
        if (isContain) {
            return newFont;
        }
        size = size - 0.5;
    }
    return [font fontWithSize:_minFontSize];
}


/**
 对比rect是否完全被包含在desRect中，如果是则返回YES，否则返回NO

 @param size 需要对比的size
 @param desSize 被对比的desSize
 */
- (BOOL)ht_contrastSize:(CGSize)size destinationSize:(CGSize)desSize
{
    if (size.width<=desSize.width && size.height<=desSize.height) {
        return YES;
    }else
    {
        return NO;
    }
}


-(CGSize)ht_sizeOfString:(NSString *)string Font:(UIFont *)font limitWidth:(CGFloat)width
{
    if (width<=0) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    
    if (self.numberOfLines <= 0) {
        return bounds.size;
    }else{
        CGFloat height = font.lineHeight * self.numberOfLines;
        if (bounds.size.height > height) {
            bounds.size.height = height;
        }
        return bounds.size;
    }
}




@end

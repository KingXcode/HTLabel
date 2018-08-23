//
//  HTLabel.h
//  test
//
//  Created by nsyworker on 2018/8/22.
//  Copyright © 2018年 nsyworker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, HTLabeltCornerType) {
    HTLabeltCornerTopLeft     = 1 << 0,
    HTLabeltCornerTopRight    = 1 << 1,
    HTLabeltCornerBottomLeft  = 1 << 2,
    HTLabeltCornerBottomRight = 1 << 3,
    HTLabeltCornerAllCorners  = HTLabeltCornerTopLeft|HTLabeltCornerTopRight|HTLabeltCornerBottomLeft|HTLabeltCornerBottomRight
};


typedef NS_ENUM(NSInteger, HTTextHorizontalAlignment) {
    HTTextHorizontalAlignmentTop      = 0,    // Visually left aligned
    HTTextHorizontalAlignmentCenter    = 1,    // Visually centered
    HTTextHorizontalAlignmentBottom     = 2,    // Visually right aligned
};


@interface HTLabel : UILabel

@property(nonatomic) UIEdgeInsets titleEdgeInsets; // default is UIEdgeInsetsZero

/**
 设置哪个方向需要切圆角
 */
@property (nonatomic,assign) HTLabeltCornerType roundingCornerType;


/**
 切的圆角的大小
 */
@property (nonatomic,assign) CGFloat cornerRadius;



/**
 如果adjustsFontSizeToFitWidth == yes，内部会根据自身的bounds和titleEdgeInsets 计算出刚好合适的字体的字号，minFontSize 则为计算时最小的字号
 默认为：0。
 建议不要修改这个属性，使用默认的0就好。
 */
@property(nonatomic) CGFloat minFontSize;


/**
 默认：HTTextHorizontalAlignmentCenter
 */
@property(nonatomic) HTTextHorizontalAlignment contentHorizontalAlignment;

@end

NS_ASSUME_NONNULL_END

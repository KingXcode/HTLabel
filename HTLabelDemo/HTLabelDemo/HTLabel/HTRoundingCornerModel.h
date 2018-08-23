//
//  HTRoundingCornerModel.h
//  test
//
//  Created by nsyworker on 2018/8/22.
//  Copyright © 2018年 nsyworker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, HTRoundingCornerType) {
    HTRoundingCornerTypeTopLeft     = 1 << 0,
    HTRoundingCornerTypeTopRight    = 1 << 1,
    HTRoundingCornerTypeBottomLeft  = 1 << 2,
    HTRoundingCornerTypeBottomRight = 1 << 3,
    HTRoundingCornerTypeAllCorners  = HTRoundingCornerTypeTopLeft|HTRoundingCornerTypeTopRight|HTRoundingCornerTypeBottomLeft|HTRoundingCornerTypeBottomRight
};


@interface HTRoundingCornerModel : NSObject

/**
 设置哪个方向需要切圆角
 */
@property (nonatomic,assign) HTRoundingCornerType roundingCornerType;

/**
 切的圆角的大小
 */
@property (nonatomic,assign) CGFloat cornerRadius;

-(instancetype)initWithLayer:(CALayer *)layer;
-(instancetype)initWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END

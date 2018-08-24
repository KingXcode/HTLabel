//
//  ViewController.m
//  HTLabelDemo
//
//  Created by nsyworker on 2018/8/23.
//  Copyright © 2018年 nsyworker. All rights reserved.
//


#import "ViewController.h"
#import "HTLabel.h"
#import "HTRoundingCornerModel.h"


@interface ViewController ()
@property (nonatomic,weak) HTLabel * label;
@property (nonatomic,strong) HTRoundingCornerModel *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
    HTLabel *label = [[HTLabel alloc]initWithFrame:CGRectMake(0, 34, 375, 200)];
    label.numberOfLines = 12;
    label.text = @"我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试我这是测试";
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor yellowColor];
    label.backgroundColor = [UIColor redColor];
//    label.contentHorizontalAlignment = HTTextHorizontalAlignmentCenter;
    
    label.cornerRadius = 4;
    label.roundingCornerType = HTRoundingCornerTypeAllCorners;
    label.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.label = label;
    [self.view addSubview:label];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.label.adjustsFontSizeToFitWidth) {
        self.label.adjustsFontSizeToFitWidth = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.label.frame = CGRectMake(0, 100, 135, 100);
        }];
    }
}

@end

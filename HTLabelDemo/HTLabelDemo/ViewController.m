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
    HTLabel *label = [[HTLabel alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    label.text = @"我这是测试";
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor yellowColor];
    label.backgroundColor = [UIColor redColor];
    label.contentHorizontalAlignment = HTTextHorizontalAlignmentBottom;
    
    label.cornerRadius = 4;
    label.roundingCornerType = HTRoundingCornerTypeAllCorners;
    label.titleEdgeInsets = UIEdgeInsetsMake(5, 25, 5, 5);
    self.label = label;
    [self.view addSubview:label];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.label.adjustsFontSizeToFitWidth = YES;
}

@end

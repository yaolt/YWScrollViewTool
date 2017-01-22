//
//  ViewController.m
//  YWScrollViewTool
//
//  Created by coder on 17/1/21.
//  Copyright © 2017年 coder. All rights reserved.
//

#import "ViewController.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

// 悬停的view
@property (nonatomic, strong) UIView *toolView;

@property (nonatomic, strong) UIView *downView;

@property (nonatomic, assign) CGRect toolViewF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, 0, kWidth, 140);
    _imageView.image = [UIImage imageNamed:@"1111.jpg"];
    [self.scrollView addSubview:_imageView];
    
    _toolView = [[UIView alloc] init];
    _toolView.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), kWidth, 35);
    _toolView.backgroundColor = [UIColor redColor];
    self.toolViewF = _toolView.frame;
    [self.scrollView addSubview:_toolView];
    
    _downView = [[UIView alloc] init];
    _downView.backgroundColor = [UIColor blueColor];
    _downView.frame = CGRectMake(0, CGRectGetMaxY(_toolView.frame), kWidth, 1000);
    [self.scrollView addSubview:_downView];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_downView.frame));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // toolView悬停
    CGFloat imageH = self.imageView.frame.size.height;
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY >= imageH){
        // 将toolView添加到控制器view中，设置Y值为0
        CGRect toolF = self.toolView.frame;
        toolF.origin.y = 0;
        self.toolView.frame = toolF;
        [self.view addSubview:self.toolView];
    }else{
        // 将toolView添加到scrollView中，还原frame
        self.toolView.frame = self.toolViewF;
        [self.scrollView addSubview:self.toolView];
    }
    
    // 下拉放大顶部图片
    if(offsetY < 0){
        // 放大比例可以根据需要随便写
        CGFloat scale = 1 - (offsetY / 70);
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

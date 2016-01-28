//
//  MainTabBarViewController.m
//  Shoping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()
{
    UILabel *_temLb;
    UIImageView *_temImgV;
    UINavigationController *_temNav;
}
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏标签栏上的所有按钮
    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        view.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //获得标签视图控制器中的子视图控制器
    NSArray *arr = self.viewControllers;
    for (int i = 0; i < arr.count; i ++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*SWIDTH/arr.count, 0, SWIDTH/arr.count, 49)];
        imgV.tag = 100 + i;
        //获得子视图的控制器
        UINavigationController *nav = [arr objectAtIndex:i];
        imgV.image = nav.tabBarItem.image;
        [self.tabBar addSubview:imgV];
        
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, SWIDTH/arr.count, 10)];
        lb.text = nav.tabBarItem.title;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:15];
        [imgV addSubview:lb];
        //imgV.backgroundColor = [UIColor grayColor];
        if (i == 0) {
            
            imgV.image = nav.tabBarItem.selectedImage;
            [lb setTextColor:[UIColor orangeColor]];
            
            _temImgV = imgV;
            _temLb = lb;
            _temNav = nav;
        }
        //给每个按钮图片添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        imgV.userInteractionEnabled = YES;
        [imgV addGestureRecognizer:tap];
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (tap.view == _temImgV) {
        return;
    }
    UIImageView *imgV = (UIImageView *)tap.view;
    //获取点击按钮对应的视图控制器
    UINavigationController *nav = [self.viewControllers objectAtIndex:imgV.tag-100];
    imgV.image = nav.tabBarItem.selectedImage;
    UILabel *lb = (UILabel *)[imgV.subviews lastObject];
    [lb setTextColor:[UIColor orangeColor]];
    
    //设置上一次高亮的按钮为低亮
    _temImgV.image = _temNav.tabBarItem.image;
    [_temLb setTextColor:[UIColor blackColor]];
    
    //重新设置高亮时的临时变量
    _temImgV = imgV;
    _temLb = lb;
    _temNav = nav;
    
    //设置页面的切换
    self.selectedIndex = imgV.tag - 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

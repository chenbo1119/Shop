//
//  FLViewController.m
//  Shoping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "FLViewController.h"

@interface FLViewController ()

@property (nonatomic,strong) UIScrollView *scrollview;

@end

@implementation FLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    
    [self createNavBar];
    
    [self createHotViewAndJinXuan];
}

- (void)createNavBar
{
    UIButton *changJinBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH/2-50, 20, 50, 40)];
    [changJinBtn setBackgroundImage:[UIImage imageNamed:@"changjing.png"] forState:UIControlStateNormal];
    [self.view addSubview:changJinBtn];
    
    UIButton *fenLeiBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH/2, 20, 50, 40)];
    [fenLeiBtn setBackgroundImage:[UIImage imageNamed:@"fenleiselected.png"] forState:UIControlStateNormal];
    [self.view addSubview:fenLeiBtn];
    
}

- (void)createHotViewAndJinXuan
{
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, HEIGHT-64-49)];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.contentSize = CGSizeMake(SWIDTH*2, 0);
    _scrollview.pagingEnabled = YES;
    _scrollview.bounces = NO;
    //_scrollview.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_scrollview];
    
    //热门
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, (SWIDTH-20)/3, 1)];
    label.backgroundColor = [UIColor lightGrayColor];
    [_scrollview addSubview:label];
    
    UILabel *hotLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 30, (SWIDTH-20)/3, 20)];
    hotLb.text = @"热门对象";
    hotLb.textColor = [UIColor redColor];
    hotLb.textAlignment = NSTextAlignmentCenter;
    [_scrollview addSubview:hotLb];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hotLb.frame), 40, (SWIDTH-20)/3, 1)];
    label1.backgroundColor = [UIColor lightGrayColor];
    [_scrollview addSubview:label1];
    
    
    NSArray *titles = @[@"女朋友",@"男朋友",@"好基友",@"爸爸",@"妈妈",@"小朋友"];
    NSArray *titleImages = @[@"nvpengyou.png",@"nanpengyou.png",@"haojiyou.png",@"baba.png",@"mama.png",@"xiaopengyou.png"];
    int totalLie = 3;
    static float hotY = 0.0;
    for (int i = 0; i < titles.count; i ++) {
        int hang = i/totalLie;
        int lie = i%totalLie;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((SWIDTH-210)/4*(lie +1)+lie*70, (CGRectGetMaxY(hotLb.frame)-25)+40*(hang+1)+hang*70, 70, 70)];
        [btn setBackgroundImage:[UIImage imageNamed:titleImages[i]] forState:UIControlStateNormal];
        [_scrollview addSubview:btn];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake((SWIDTH-210)/4*(lie +1)+lie*70, CGRectGetMaxY(btn.frame)+10, 70, 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = titles[i];
        [_scrollview addSubview:lable];
        
        hotY = CGRectGetMaxY(lable.frame);
    }
    
    //精选
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, hotY+20, (SWIDTH-20)/3, 1)];
    label2.backgroundColor = [UIColor lightGrayColor];
    [_scrollview addSubview:label2];
    
    UILabel *jinXuan = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), hotY+10, (SWIDTH-20)/3, 20)];
    jinXuan.text = @"精选标签";
    jinXuan.textColor = [UIColor redColor];
    jinXuan.textAlignment = NSTextAlignmentCenter;
    [_scrollview addSubview:jinXuan];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hotLb.frame), hotY+20, (SWIDTH-20)/3, 1)];
    label3.backgroundColor = [UIColor lightGrayColor];
    [_scrollview addSubview:label3];
    
    
    NSArray *images = @[@"yingyuemi11.png",@"qinglvxiaojian11.png",@"chihuochufang11.png",@"sgangbanzu11.png",@"xueshengdang11.png",@"sheying11.png",@"youxiwanjia11.png",@"lanrendang11.png",@"kejikong11.png",@"chaonanjie11.png",@"zipai11.png"];
    
    float X = 0.0,Y=0.0,W,H;
    for (int i = 0; i < images.count; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        UIImage *image = [UIImage imageNamed:images[i]];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        CGSize size = image.size;
        W = size.width/2.8;
        H = size.height/2.8;
        btn.frame = CGRectMake(20+X, CGRectGetMaxY(jinXuan.frame)+10+Y, W, H);
        [_scrollview addSubview:btn];
        X += W+20;
        if (X+W>=CGRectGetMaxX(label3.frame)) {
            Y += 10+H;
            X = 0;
        }
        NSLog(@"%f",X);

    }
    
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

- (IBAction)CJBtn:(id)sender {
}

- (IBAction)FLBtn:(id)sender {
}

- (IBAction)searchBtn:(id)sender {
}
@end

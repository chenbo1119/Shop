//
//  HeaderView.m
//  Shoping
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "HeaderView.h"
#import "CBRequest.h"
#import "GGModel.h"
#import "UIImageView+WebCache.h"

@interface HeaderView ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageCtrl;
    NSMutableArray *_ggArray;
    NSMutableArray *_btnArray;
}
@property (nonatomic,strong) CBRequest *request;

@end

@implementation HeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initHttpRequest];
    }
    return self;
}

//请求广告视图数据
- (void)initHttpRequest
{
    _request = [[CBRequest alloc]initWithRequestString:GGPATH andBlock:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dic objectForKey:@"data"];
        _ggArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            GGModel *model = [[GGModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_ggArray addObject:model];
            //NSLog(@"%@",model.iphonemimg);
        }
        
        [self setUp];
        
    }];
}

- (void)setUp
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 150)];
    _scrollView.contentSize = CGSizeMake(SWIDTH*(_ggArray.count+2), 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_scrollView];
    _scrollView.contentOffset = CGPointMake(SWIDTH, 0);
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
    
    _pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH-100, 130, 100, 20)];
    _pageCtrl.numberOfPages = _ggArray.count;
    _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageCtrl];
    
    //创建数组存放Imageview
    
    NSMutableArray *imageViews = [NSMutableArray array];
    
    //将最后一张图片放在第0位
    UIImageView *firstImageView = [[UIImageView alloc]init];
    [imageViews addObject:firstImageView];
    
    GGModel *model = _ggArray[_ggArray.count - 1];
    //NSLog(@"%@",self.ggArray);
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:model.iphonemimg]];
    
    for (int i = 0; i < _ggArray.count; i++) {
        GGModel *model = _ggArray[i];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 200+i;
        [imageViews addObject:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.iphonemimg]];
        //NSLog(@"%@",model.iphonemimg);
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageviewClick:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
    }
    
    //将第一张图片放在最后一张图片之后
    UIImageView *lastImageVeiw = [[UIImageView alloc]init];
    [imageViews addObject:lastImageVeiw];
    GGModel *model2 = _ggArray[0];
    
    [lastImageVeiw sd_setImageWithURL:[NSURL URLWithString:model2.iphonemimg]];
    
    for (int i = 0; i < imageViews.count; i ++) {
        UIImageView *imageview = imageViews[i];
        imageview.frame = CGRectMake(SWIDTH*i, 0, SWIDTH, 150);
        [_scrollView addSubview:imageview];
    }
    
}
//广告视图手势触发方法
- (void)imageviewClick:(UITapGestureRecognizer *)tap
{
    int i = (int)tap.view.tag-200;
    GGModel *model = _ggArray[i];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"image" object:model.link];
}

//传进数组 并创建四个图片
- (void)setArray:(NSArray *)array{
    
    for (int i = 0; i < array.count; i ++) {
        GGModel *model = array[i];
        int lie = i%2;
        int hang = i/2;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*(lie+1)+lie*((SWIDTH-30)/2), 10*(hang+1)+60*hang+150, (SWIDTH-30)/2, 60)];
        imageView.tag = 300+i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        
        [self addSubview:imageView];
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourClick:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
    }
    
}

- (void)fourClick:(UITapGestureRecognizer *)tap
{
    int i = (int)tap.view.tag - 300;
    NSString *str = [NSString stringWithFormat:@"%d",i];
    NSLog(@"%@,%d",str,i);  
    //GGModel *model = self.array[i];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"four" object:str];
}

//定时器触发方法
- (void)runTime
{
    static NSInteger page;
    _pageCtrl.currentPage = page;
    page ++;
    [_scrollView setContentOffset:CGPointMake(SWIDTH*page, 0) animated:YES];
    page = page > (_ggArray.count - 1) ? 0 : page;
}


#pragma mark --------------- ScrollviewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/SWIDTH;
    if (page == _ggArray.count+1) {
        _scrollView.contentOffset = CGPointMake(SWIDTH, 0);
        page = 1;
    }else if (page == 0){
        _scrollView.contentOffset = CGPointMake(SWIDTH*_ggArray.count, 0);
        page = (int)_ggArray.count;
    }
    _pageCtrl.currentPage = page - 1;
}

@end

//
//  SPViewController.m
//  Shoping
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "SPViewController.h"
#import "CBRequest.h"
#import "GGModel.h"
#import "SPModel.h"
#import "CollectionCell.h"
#import "CollectionCell2.h"
#import "HeaderView.h"
#import "WebViewController.h"

@interface SPViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIView *_tapView;
    //广告视图下方数据源
    NSMutableArray *_btnArray;
    //所有数据源
    NSMutableArray *_dataArray;
    
    NSString *_soft;
    
    NSArray * _titles;
    
    NSString *title;
    
}

@property (nonatomic,strong) CBRequest *request;
@property (nonatomic,strong) UICollectionView *collectionView;


@end

@implementation SPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self allocinit];
    
    [self createNavBar];
    
    [self initDataHttpRequest];
    
    [self createCollectionView];
    
    [self registerCell];
    
    [self createTapView];
    
    [self addNotification];
    
}

- (void)addNotification
{
    //广告视图跳转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageClick:) name:@"image" object:nil];
    //四个图片跳转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fourClick:) name:@"four" object:nil];
    //返回顶部 button 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createBack:) name:@"contentoffset" object:nil];
    
}
// 返回顶部的通知方法
- (void)createBack:(NSNotification *)n
{
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-60, HEIGHT-49-60, 50, 50)];
        btn.tag = 6666;
        [btn setBackgroundImage:[UIImage imageNamed:@"top_btn@2x.png"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(backTop:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)backTop:(UIButton *)btn
{
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    [btn removeFromSuperview];
}

//四个图片通知方法
- (void)fourClick:(NSNotification *)n
{
    NSString *str = n.object;
    NSInteger i = str.intValue;
    NSLog(@"%li",i);
    GGModel *model = _btnArray[i];
    WebViewController *web = [[WebViewController alloc]init];
    web.urlPath = model.url;
    [self.navigationController pushViewController:web animated:YES];
}

//广告视图通知方法
- (void)imageClick:(NSNotification *)n
{
    NSLog(@"%@",n.object);
    WebViewController *web = [[WebViewController alloc]init];
    web.urlPath = n.object;
    [self.navigationController pushViewController:web animated:YES];
}

//数据初始化
- (void)allocinit
{
    _titles = @[@"女装",@"男装",@"文娱",@"鞋包",@"配饰",@"家居",@"美食",@"母婴",@"美妆",@"数码",@"首页"];
    
    title = _titles[10];
    
    _btnArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    _soft = [[NSString alloc]init];
}
//创建 collectionView
- (void)createCollectionView
{
    UICollectionViewFlowLayout *layer = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, HEIGHT-64) collectionViewLayout:layer];
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    layer.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置最小行间距
    layer.minimumLineSpacing = 5;
    //设置最小列间距
    layer.minimumInteritemSpacing = 5;
    
//    [self createTapView];
}

//注册 cell 和 header 视图
- (void)registerCell
{
    //[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCell2" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    [_collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

//请求整页数据

- (void)initDataHttpRequest
{
    NSString *PATH = [[NSString alloc]init];
    if ([_soft isEqualToString:@""]) {
        PATH = SPPATH;
    }else{
        PATH = [NSString stringWithFormat:SPPATH@"&%@",_soft];
    }
    NSLog(@"%@",PATH);
    _request = [[CBRequest alloc]initWithRequestString:PATH andBlock:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dic objectForKey:@"category_s"];
        //广告下方视图
        NSMutableArray * linshiarr = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in array) {
            GGModel *model = [[GGModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [linshiarr addObject:model];
            //NSLog(@"%@",model.pic);
        }
        _btnArray.array = linshiarr;
        
        //collectionveiw 数据源
        NSArray *allArray = [dic objectForKey:@"list"];
        NSMutableArray * linshi2 = [NSMutableArray array];
        for (NSDictionary *allDic in allArray) {
            SPModel *model = [[SPModel alloc]init];
            [model setValuesForKeysWithDictionary:allDic];
            [linshi2 addObject:model];
            //NSLog(@"%@",model.pic_url);
        }
        [_dataArray setArray:linshi2];
        [self.collectionView reloadData];
        _soft = nil;
//        [self createCollectionView];
//        
//        [self registerCell];
        
    }];
}

//创建下滑的顶部 view
- (void)createTapView
{
    //全部按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-60, HEIGHT-49-60-60, 50, 50)];
    [btn setBackgroundImage:[UIImage imageNamed:@"all_btn@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    _tapView = [[UIView alloc]initWithFrame:CGRectMake(0, -150-64, SWIDTH, 150)];
    _tapView.backgroundColor = [UIColor whiteColor];
    _tapView.alpha = 0;
    NSArray *images = @[@"nvzhuang.png", @"nanzhuang.png", @"wenyu.png", @"xiebao.png", @"peishi.png", @"jiaju.png", @"meishi.png", @"muying.png", @"meizhuang.png", @"shuma.png"];
    int lie = 5;
    for (int i = 0; i < images.count; i ++) {
        //行
        int hang = i/lie;
        int col = i%lie;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(((SWIDTH-300)/(lie+1))*(col+1)+col*60, 30/3*(hang+1)+60*hang, 60, 60)];
        [button setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button addTarget:self action:@selector(xuanxiangBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_tapView addSubview:button];
    }
    [self.view addSubview:_tapView];
}

- (void)xuanxiangBtn:(UIButton *)btn
{
#warning 下滑点击事件未写
    
    switch (btn.tag - 100) {
        case 0:
        {
            _soft = @"sort=2";
            NSLog(@"%@",_soft);
        }
            break;
        case 1:
        {
            _soft = @"sort=3";
        }
            break;
        case 2:
        {
            _soft = @"sort=10";
        }
            break;
        case 3:
        {
            _soft = @"sort=6";
        }
            break;
        case 4:
        {
            _soft = @"sort=7";
        }
            break;
        case 5:
        {
            _soft = @"sort=4";
        }
            break;
        case 6:
        {
            _soft = @"sort=9";
        }
            break;
        case 7:
        {
            _soft = @"sort=5";
        }
            break;
        case 8:
        {
            _soft = @"sort=8";
        }
            break;
        case 9:
        {
            _soft = @"sort=1";
        }
            break;
            
        default:
            break;
    }

    [self initDataHttpRequest];
    
    UIButton * btn2 = [self.view viewWithTag:1234];
    title = _titles[btn.tag-100];
    
    [btn2 setTitle:_titles[btn.tag - 100] forState: UIControlStateNormal];
    [self btnClick:btn2];
}

//创建导航栏
- (void)createNavBar
{
    self.navigationController.navigationBar.hidden = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    //下滑 button
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH/2-50, 25, 80, 30)];
    //btn.backgroundColor = [UIColor redColor];
    [btn setTitle:_titles[10] forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"menu_2@2x.png"] forState:UIControlStateNormal];
    btn.tag = 1234;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 55, 0, -55);
    [view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //搜索 button
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-40, 27, 25, 25)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_btn@3x.png"] forState:UIControlStateNormal];
    [view addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
}

//搜索 button 点击事件
- (void)searchBtn:(UIButton *)btn
{
#warning 搜索点击事件
    
}
//下滑 button 点击事件
- (void)btnClick:(UIButton *)btn
{
    btn.selected ^= 1;
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"menu_1@2x.png"] forState:UIControlStateNormal];
        [self showTapView];
        
    }else{
        [btn setImage:[UIImage imageNamed:@"menu_2@2x.png"] forState:UIControlStateNormal];
        [self hideTapView];
    }
}
//展示 view
- (void)showTapView
{
    [UIView animateWithDuration:1 animations:^{
       
        _tapView.frame = CGRectMake(0, 64, SWIDTH, 150);
        _tapView.alpha = 1;
    }];
}
// 隐藏 view
- (void)hideTapView
{
    [UIView animateWithDuration:1 animations:^{
        _tapView.frame = CGRectMake(0, -150-64, SWIDTH, 150);
        _tapView.alpha = 0;
    }];
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

#pragma mark ------------------- CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPModel *model = _dataArray[indexPath.row];
    
    if ([model.title isEqualToString:@""]) {
        CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
        CollectionCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.model = model;
        
        return cell;
    }
    
    
}
//collectionVIew 头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *rv = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeaderView *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.array = _btnArray;
        //view.backgroundColor = [UIColor redColor];
        rv = view;
    }
    
    return rv;
}


//点击 cell 执行方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPModel *model = _dataArray[indexPath.row];
    WebViewController *web = [[WebViewController alloc]init];
    web.urlPath = model.url;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark ----------flowLayout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SWIDTH/2-10, 200);
}

//头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(SWIDTH, 300);
}

//监测返回顶部的 button
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSNumber *num = [NSNumber numberWithFloat:scrollView.contentOffset.y];
    if ([num floatValue]>HEIGHT) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"contentoffset" object:num];
    }else{
        [[self.view viewWithTag:6666] removeFromSuperview];
    }
    
}

@end

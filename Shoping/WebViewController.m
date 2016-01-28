//
//  WebViewController.m
//  Shoping
//
//  Created by qianfeng on 16/1/16.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *web;
@property (nonatomic,strong)MBProgressHUD *progress;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavBar];
    
    [self createWebView];
}

- (void)createNavBar
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 39)];
    [backBtn setTitle:@"返回" forState: UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
}

- (void)backClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createWebView
{
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, HEIGHT-64-49)];
    NSURL *url = [NSURL URLWithString:self.urlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_web loadRequest:request];
    
    NSLog(@"%@",self.urlPath);
    
    _web.delegate = self;
    [self.view addSubview:_web];
    
    _web.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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


#pragma mark ------------------ delegate
//即将发送请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

//网页加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progress hide:YES];
    _web.hidden = NO;
}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_progress hide:YES];
    _web.hidden = NO;
    NSLog(@"%@",error.localizedDescription);
}

@end

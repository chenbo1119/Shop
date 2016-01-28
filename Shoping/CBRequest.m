//
//  CBRequest.m
//  Shoping
//
//  Created by qianfeng on 16/1/15.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "CBRequest.h"
#import "AFNetworking.h"

@interface CBRequest ()

@property (strong, nonatomic)AFHTTPRequestOperationManager *manager;
@property (copy, nonatomic)httpBlock block;

@end

@implementation CBRequest

- (id)initWithRequestString:(NSString *)path andBlock:(httpBlock)block
{
    if (self = [super init]) {
        [self requestString:path];
        if (_block) {
            _block = nil;
        }
        _block = block;
    }
    return self;
}

- (void)requestString:(NSString *)path
{
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"请求失败-------------%@", error.localizedDescription);
        
    }];
}

@end

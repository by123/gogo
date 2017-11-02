//
//  NetUtil.m
//  gogo
//
//  Created by by.huang on 2017/9/18.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ByNetUtil.h"
#import "AccountManager.h"
#import "RespondModel.h"
@implementation ByNetUtil

+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //请求头
    Account *account = [[AccountManager sharedAccountManager] getAccount];
    [manager.requestSerializer setValue:PT forHTTPHeaderField:@"pt"];
    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"app_key"];
    [manager.requestSerializer setValue:account.uid forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:account.access_token forHTTPHeaderField:@"access_token"];
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    // post请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //请求头
    Account *account = [[AccountManager sharedAccountManager] getAccount];
    [manager.requestSerializer setValue:PT forHTTPHeaderField:@"pt"];
    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"app_key"];
    [manager.requestSerializer setValue:account.uid forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:account.access_token forHTTPHeaderField:@"access_token"];
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    // post请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            failure(error);
        }
    }];
}


+(void)download : (NSString *)url callback : (ByDownloadCallback) callback{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

@end

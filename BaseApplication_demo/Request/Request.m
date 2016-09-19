//
//  Request.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/18.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "Request.h"

@interface Request ()
@property (nonatomic, strong)AFHTTPSessionManager  *man;

@property (nonatomic, strong) AFURLSessionManager   * urlMan;

@end

@implementation Request

static Request *req = nil;
+(instancetype)shareRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        req = [[Request alloc]init];
        req.man = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:HOST_IP]];

        req.man.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];

    });
    return req;
}
//重写allocWithZone保证分配内存alloc相同
+(id)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        req = [super allocWithZone:zone];
    });
    
    return req;
}

//保证copy相同
-(id)copyWithZone:(NSZone *)zone{
    return req;
}



-(NSURLSessionDataTask *)getRequetstWithParam:(NSDictionary *)param
                requestType:(NSString *)type
                    success:(RequestSuccess)succ
                    failure:(RequestFailure)failure
{

    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    self.man.requestSerializer = [AFHTTPRequestSerializer serializer];
    //url str
    NSString *requestUrl = [self.man.baseURL.absoluteString stringByAppendingString:type];
    
    return [self.man GET:requestUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            succ(responseObject);
        }
        else
        {
            failure(@"服务器出小差中，请重试。");
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error.localizedDescription);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }];
    
}

-(NSURLSessionDataTask *)postRequetstWithParam:(NSDictionary *)param
                 requestType:(NSString *)type
                     success:(RequestSuccess)succ
                     failure:(RequestFailure)failure
{
    AFHTTPSessionManager *man = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:HOST_IP]];
    
    man.requestSerializer = [AFHTTPRequestSerializer serializer];

    NSString *requestUrl = [man.baseURL.absoluteString stringByAppendingString:type];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    return [man POST:requestUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            succ(responseObject);
        }
        else
        {
            failure(@"服务器出小差中，请重试。");
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error.localizedDescription);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }];

}
-(NSURLSessionDataTask *)jsonRequetstWithParam:(NSDictionary *)param
                 requestType:(NSString *)type
                     success:(RequestSuccess)succ
                     failure:(RequestFailure)failure
{
    
    self.man.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *requestUrl = [self.man.baseURL.absoluteString stringByAppendingString:type];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    return [self.man POST:requestUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%lldd",downloadProgress.totalUnitCount);
        NSLog(@"%lldd",downloadProgress.completedUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            succ(responseObject);
        }
        else
        {
            failure(@"服务器出小差中，请重试。");
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error.localizedDescription);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }];
    

}
-(NSURLSessionDataTask *)updataDataToServerWithType:(NSString *)type
                                              param:(NSDictionary *)param
                                           fileData:(NSData *)fileData
                                               name:(NSString *)name
                                           fileName:(NSString *)fileName
                                           mimeType:(NSString *)mimeType
                                            success:(RequestSuccess)succ
                                            failure:(RequestFailure)failure
                                           progress:(RequestProgress)progress
{
    
    
    self.man.requestSerializer = [AFJSONRequestSerializer serializer];

    self.man.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    
    NSString *requestUrl = [self.man.baseURL.absoluteString stringByAppendingString:type];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    return [self.man POST:requestUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        succ(responseObject);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failure(error.localizedDescription);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }];
    
}

@end

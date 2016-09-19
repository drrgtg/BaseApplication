//
//  Request.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/18.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^RequestSuccess)(NSDictionary *jsonDic);

typedef void(^RequestFailure)(NSString *failureStr);

typedef void(^RequestProgress)(double progress);

@interface Request : NSObject


+(instancetype)shareRequest;
/**
 *  普通的get请求封装
 *
 *  @param param 请求参数
 *  @param type  请求类型参数
 */
-(NSURLSessionDataTask *)getRequetstWithParam:(NSDictionary *)param
                requestType:(NSString *)type
                    success:(RequestSuccess)succ
                    failure:(RequestFailure)failure;
/**
 *  普通的post请求封装
 *
 *  @param param 请求参数
 *  @param type  请求类型参数
 */
-(NSURLSessionDataTask *)postRequetstWithParam:(NSDictionary *)param
                 requestType:(NSString *)type
                     success:(RequestSuccess)succ
                     failure:(RequestFailure)failure;
/**
 *  普通的json请求封装
 *
 *  @param param 请求参数
 *  @param type  请求类型参数
 */
-(NSURLSessionDataTask *)jsonRequetstWithParam:(NSDictionary *)param
                 requestType:(NSString *)type
                     success:(RequestSuccess)succ
                     failure:(RequestFailure)failure;

/**
 *  上传文件
 *
 *  @param type     api链接
 *  @param param    参数
 *  @param fileData 上传的文件的二进制data数据
 *  @param name     二进制data的key
 *  @param fileName 文件名称
 *  @param mimeType 文件类型
 *  @param succ     成功
 *  @param failure  失败
 *  @param progress 进度
 *
 *  @return NSURLSessionDataTask;
 */
-(NSURLSessionDataTask *)updataDataToServerWithType:(NSString *)type
                                              param:(NSDictionary *)param
                                           fileData:(NSData *)fileData
                                               name:(NSString *)name
                                           fileName:(NSString *)fileName
                                           mimeType:(NSString *)mimeType
                                            success:(RequestSuccess)succ
                                            failure:(RequestFailure)failure
                                           progress:(RequestProgress)progress;



@end

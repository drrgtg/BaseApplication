//
//  NSObject+propertyList.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (propertyList)
/**
 *  获取model对象的所有property和对应的value;
 *  用于模型转字典
 *
 */
+(void)propertyListAndValue:(id)obj withClass:(Class)className andDic:(NSMutableDictionary *)dic;
@end

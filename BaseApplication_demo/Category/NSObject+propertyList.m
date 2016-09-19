//
//  NSObject+propertyList.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "NSObject+propertyList.h"

@implementation NSObject (propertyList)

/**
 *  获取对象的所有属性
 */
+(void)propertyListAndValue:(id)obj withClass:(Class)className andDic:(NSMutableDictionary *)dic
{
    unsigned int count ;
    objc_property_t *propList = class_copyPropertyList([className class], &count);
    
    for (int i = 0; i<count; i++)
    {
        
        objc_property_t pro = propList[i];
        const char *name = property_getName(pro);
        NSString *proName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        if (![obj valueForKey:proName])
        {
            continue;
        }
        /**
         *  处理关键字
         */
        if ([proName isEqualToString:@"modelId"])
        {
            [dic setValue:[obj valueForKey:proName] forKey:@"id"];
        }
        else if ([proName isEqualToString:@"modelClass"])
        {
            [dic setValue:[obj valueForKey:proName] forKey:@"class"];
        }
        else
        {
            [dic setValue:[obj valueForKey:proName] forKey:proName];
        }
    }
    Class superClass = class_getSuperclass([className class]);
    if (superClass == [NSObject class])
    {
        
        free(propList);
    }
    else
    {
        [[self class]  propertyListAndValue:obj withClass:superClass andDic:dic];
    }

}
@end

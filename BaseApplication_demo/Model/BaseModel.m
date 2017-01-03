//
//  BaseModel.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    NSString *strValue = [NSString stringWithFormat:@"%@",value];
    [super setValue:strValue forKey:key];
    
}
//这里处理objective-c的保留字
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSString *strValue = [NSString stringWithFormat:@"%@",value];
    if ([key isEqualToString:@"id"])
    {
        self.modelId = strValue;
    }
    else if ([key isEqualToString:@"class"])
    {
        self.modelClass = strValue;
    }
    else if ([key isEqualToString:@"new"])
    {
        self.modelNew = strValue;
    }
    
}
@end

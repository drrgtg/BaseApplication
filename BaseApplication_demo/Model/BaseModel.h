//
//  BaseModel.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Model对象的基类，所有的model，都继承与此
 *
 *  给model赋值请使用kvc
 *  
 *  配合使用NSObjcet+propertyList分类实现model到字典的相互转化。
 */


@interface BaseModel : NSObject
//id
@property (nonatomic, copy) NSString * modelId;
//class
@property (nonatomic, copy) NSString * modelClass;
//遇到再添加

@end

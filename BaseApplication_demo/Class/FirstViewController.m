//
//  FirstViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) UILabel   *myView;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    [self showAlertMessage:@"messagemessage"];
    
    
    /**
     *  dispatch
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissAllHUD];

    });
    
    dispatch_queue_t q ;
    /**
     *  串行队列
     */
    q = dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL);
    /**
     *  并行队列
     */
    q = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q, ^{
        NSLog(@"q1");
    });
    dispatch_async(q, ^{
        NSLog(@"q2");
    });
    dispatch_async(q, ^{
        NSLog(@"q3");
    });
    dispatch_async(q, ^{
        NSLog(@"q4");
    });
    dispatch_async(q, ^{
        NSLog(@"q5");
    });
    dispatch_async(q, ^{
        NSLog(@"q6");
    });
    dispatch_async(q, ^{
        NSLog(@"q7");
    });
    NSLog(@"main");
    /**
     *  在主线程中调用同步dispatch会造成死锁，卡死中......
     */
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
//    });
#if 0
    Global Dispatch Queue (全局并发队列)
    此队列就是整个系统都可以使用的全局并行队列，由于所有的应用程序都可以使用该并行队列，没必要自已创建并行队列，只需要获取该队列即可。
    /**
     *  获取高优先级方法
     */
    q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    /**
     *  获取默认优先级方法
     */
    q =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /**
     *  获取低优先级方法
     */
    q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    /**
     *  获取后台优先级方法
     */
    q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
#endif
    /**
     *  dispatch_set_target的作用是设置一个队列的优先级，我们手动创建的队列，无论是串行队列还是并发队列，都跟默认优先级的全局并发队列具有相同的优先级。如果我们需要改变队列优先级，则可以使用dispatch_set_tartget方法。
     */
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.example.gcd.MySerialDispatchQueue", NULL);
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_set_target_queue(mySerialDispatchQueue, globalDispatchQueueBackground);
    
    /**
     *  组的任务都完成之后
     *
     */
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, q, ^{
        ;
    });
    long result = dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    if (result == 0) {
        NSLog(@"结束");
    }
    
    
#if 0
    /**
     *  model
     */
    NSDictionary *dic = @{@"id":@"value1",
                          @"class":@"value2",
                          @"key":[NSNull null],
                          @"key1":@"",
                          @"key2":@"value3",
                          @"key3":@"value3"};
    Model1 *model = [[Model1 alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithCapacity:0];
    [NSObject propertyListAndValue:model withClass:[model class] andDic:dics];
    NSLog(@"%@",dics);
#endif
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",[NSValue valueWithCGPoint:[[touches anyObject] locationInView:self.view]]);

    
    
    
//    [self.myView convertPoint:point toCoordinateSpace:myView.window.screen.fixedCoordinateSpace];

}

@end

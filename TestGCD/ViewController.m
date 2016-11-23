//
//  ViewController.m
//  TestGCD
//
//  Created by Roy on 16/11/22.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加全局队列 全局队列为并行队列
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //得到一个主队列 主队列为串行队列
    dispatch_queue_t queue2=dispatch_get_main_queue();
    
    
    //[self dispatchasync:queue];
    //[self dispatchsync:queue];
    
    //[self dispatchasync:queue2];
   // [self dispatchsync:queue2];//会引发死锁 主线程通过dispatch_sync把block交给主队列后，会等待block里的任务结束再往下走自身的任务，队列是先进先出的，block里的任务也在等待主队列当中排在它之前的任务都执行完了再走自己。这种循环等待就形成了死锁

}

//异步
-(void) dispatchasync:(dispatch_queue_t) queue
{

    //异步
    //实用异步刷新 当前线程将任务给子线程 当前线程不会发生阻塞，会立即执行 结果不固定
    dispatch_async(queue, ^{
        NSLog(@"1");
        
        NSLog(@"当前线程:%@", [NSThread currentThread]);
    });


}
//同步
-(void) dispatchsync:(dispatch_queue_t) queue
{
    //当主线程将任务分给子线程后，主线程会等待子线程执行完毕，再继续执行自身的内容
dispatch_sync(queue, ^{
    NSLog(@"1");
});

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

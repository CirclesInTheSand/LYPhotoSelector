//
//  TestMultiRequestObject.m
//  TestMutiRequest
//
//  Created by Calvix on 2017/4/29.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "TestMultiRequestObject.h"

#define commandKey @"command"

@implementation TestMultiRequestObject

//方法：使用信号量
- (void)testUsingSemaphore{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSArray *commandArray = @[@"requestcommand1", @"requestcommand2", @"requestcommand3", @"requestcommand4", @"requestcommand5"];
    
    NSInteger commandCount = [commandArray count];
    //代表http访问返回的数量
    //这里模仿的http请求block块都是在同一线程（主线程）执行返回的，所以对这个变量的访问不存在资源竞争问题，故不需要枷锁处理
    //如果网络请求在不同线程返回，要对这个变量进行枷锁处理，不然很会有资源竞争危险
    __block NSInteger httpFinishCount = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //demo testUsingSemaphore方法是在主线程调用的，不直接调用遍历执行，而是嵌套了一个异步，是为了避免主线程阻塞
        NSLog(@"start all http dispatch in thread: %@", [NSThread currentThread]);
        [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self httpRequest:nil param:@{commandKey : obj} completion:^(id response) {
                //全部请求返回才触发signal
                if (++httpFinishCount == commandCount) {
                    dispatch_semaphore_signal(sem);
                }
            }];
        }];
        //如果全部请求没有返回则该线程会一直阻塞
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSLog(@"all http request done! end thread: %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"UI update in main thread!");
        });
    });
    
}

#pragma mark - group 第一种情况

- (void)testUsingGroup1{
    NSArray *commandArray = @[@"requestcommand1", @"requestcommand2", @"requestcommand3", @"requestcommand4", @"requestcommand5"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@ in group thread:%@", obj, [NSThread currentThread]);
            [self httpRequest:nil param:@{commandKey : obj} completion:^(id response) {
                
            }];
        });
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all http request done!");
        NSLog(@"UI update in main thread!");
    });
    
}

#pragma mark - group 第二种情况

- (void)testUsingGroup2{
    NSArray *commandArray = @[@"requestcommand1", @"requestcommand2", @"requestcommand3", @"requestcommand4", @"requestcommand5"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@ in group thread:%@", obj, [NSThread currentThread]);
            [self httpRequest2:nil param:@{commandKey : obj} completion:^(id response) {
                
            }];
        });
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all http request done!");
        NSLog(@"UI update in main thread!");
    });
    
}

- (void)httpRequest2:(NSString *)method param:(NSDictionary *)param completion:(void(^)(id response))block{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    [self httpRequest:method param:param completion:^(id response) {
        if (block) {
            block(response);
        }
        dispatch_semaphore_signal(sem);
    }];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

#pragma mark - 网络请求方法

//模拟一个网络请求方法 get/post/put...etc
- (void)httpRequest:(NSString *)method param:(NSDictionary *)param completion:(void(^)(id response))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *commend = [param objectForKey:commandKey];
        NSLog(@"request:%@ run in thread:%@", commend, [NSThread currentThread]);
        NSTimeInterval sleepInterval = arc4random() % 10;
        [NSThread sleepForTimeInterval:sleepInterval];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"requset:%@ done!", commend);
            if(block)
            {
                block(nil);
            }
        });
    });
}



@end

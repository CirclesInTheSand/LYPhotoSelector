//
//  ViewController.m
//  TestMutiRequest
//
//  Created by Calvix on 2017/4/29.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "ViewController.h"
#import "TestMultiRequestObject.h"
#import "CustomToolView.h"
#import "MyGoodsViewController.h"
#import "DelegateViewController.h"
#import "CirculateDetailsViewController.h"
#import <WebKit/WebKit.h>
#import "AppBridge.h"
#import "BBLaunchAdMonitor.h"

@interface ViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong) CustomToolView *toolView;
@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (nonatomic,strong) WKWebView *wkWebView; /** 网页 */
@property (nonatomic,strong) UIWebView *webview; /** webView */
@end
//AAAA I'm confused.
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *homeUrlString = @"http://172.16.10.18/dyh5/web/index/init?b=dy2";

    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.webview = webview;
    webview.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:homeUrlString]]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBack:)];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark -- UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self registerAppBridgeObject];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self registerAppBridgeObject];
}
#pragma mark -- 注册AppBridge对象
- (void)registerAppBridgeObject
{
    __weak typeof(self) weakSelf = self;
    AppBridge *testJO = [[AppBridge alloc] init];
    testJO.delegate = (AppBridge *)weakSelf;
    JSContext *context = [weakSelf.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context evaluateScript:@"window.appBridge = null;"];
    context[@"appBridge"] = testJO;
    
}

#pragma mark -- App Bridge 协议
- (void)openUrl:(NSString *)dic{
    NSLog(@"openUrl:%@",dic);
}

- (void)goBack:(id)sender{
    if([self.wkWebView canGoBack])
    {
        [self.wkWebView goBack];
    }else{
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Already arrived at the top history." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [controller addAction:actionOne];
        [self presentViewController:controller animated:true completion:nil];
        
    }
}



- (void)dispatchGroupTest
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        NSLog(@"任务1完成---- %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(3);
        NSLog(@"任务2完成---- %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"任务3完成---- %@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"All request finished.");
    });
}

- (void)semaphoretest {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSLog(@"begin to load first request");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        NSLog(@"任务1完成---- %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"begin to load second request");
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(3);
        NSLog(@"任务2完成---- %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"begin to third third request");
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"任务3完成---- %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"All request finished.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- ShowViewController
- (void)showControllerInIndex:(NSInteger)index
{
    [self.contentScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0) animated:YES];
    UIViewController * contr = self.childViewControllers[index];
    if (contr.isViewLoaded) return;
    contr.view.frame = CGRectMake(index * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.toolView.frame));
    [self.contentScrollView addSubview:contr.view];

}
#pragma mark -- addScrollView
- (void)addScrollView
{
    //主滚动视图
    {
        self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolView.frame), [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.toolView.frame))];
        self.contentScrollView.delegate = self;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.bounces = NO;
        
        self.contentScrollView.delaysContentTouches = NO;
        self.contentScrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childViewControllers.count, 0);
        [self.view addSubview:self.contentScrollView];
    }

}

#pragma mark -- ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"did end scroll");
    if(![scrollView isKindOfClass:[UITableView class]])
    {
        CGFloat maxX = scrollView.contentOffset.x;
        NSInteger currentIndex = maxX / [UIScreen mainScreen].bounds.size.width;
        NSLog(@"floatIndex:%zd",currentIndex);
        UIButton *clickedBtn = [self.toolView viewWithTag:100 + currentIndex];
        [self.toolView performSelector:@selector(btnClick:) withObject:clickedBtn];
    }
}


#pragma mark -- addChildViewControllers
- (void)addChildViewContollers
{
    MyGoodsViewController *goods = [MyGoodsViewController new];
    DelegateViewController *delegate = [DelegateViewController new];
    CirculateDetailsViewController *circulate = [CirculateDetailsViewController new];
    NSArray *viewControllersArray = @[goods,delegate,circulate];
    for(id controller in viewControllersArray)
    {
        [self addChildViewController:controller];
    }
    
}

#pragma mark --
- (void)didClickBtnIndex:(NSInteger)index
{
    [self showControllerInIndex:index];
}
#pragma mark -- 初始化重写
- (CustomToolView *)toolView
{
    
    if(!_toolView)
    {
        __weak typeof(self) weakSelf = self;
        NSArray *names = @[@"我的商品",@"代理商品",@"出入库明细"];
        _toolView = [[CustomToolView alloc] initWithTitles:names font:0];
        _toolView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40);
        
        [_toolView didClickBtnWithHandle:^(NSInteger index) {
            
            NSLog(@"点击了第%lu个",(long)index);
            
            [weakSelf didClickBtnIndex:index];
        }];
        

    }
    return _toolView;
}

@end

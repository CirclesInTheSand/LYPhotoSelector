//
//  OnlineApplicationViewController.m
//  TestMutiRequest
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//



#import "OnlineApplicationViewController.h"
#import "OnlineConst.h"
#import "UITableViewMaterialCell.h"

static NSString *onlineCellIdentifier = @"onlineCell";

@interface OnlineApplicationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MaterialCellProtocol>
@property (nonatomic,strong) UITableView *applicationTableView;
@end

@implementation OnlineApplicationViewController

#pragma mark -- 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self basicSettings];
    [self setUpSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 基本设置

/**
 基本设置
 */
- (void)basicSettings{
    self.title = @"在线申办";
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
     //4,49,121 导航条
    self.navigationController.navigationBar.barTintColor = RGB(4,49,121);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : kFontSize(20)}];
    //状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

/**
 添加子视图
 */
- (void)setUpSubviews{
    [self.view addSubview:self.applicationTableView];
}


/**
 访问系统相册
 */
- (void)callSystemPhotoLibrary{
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];//进入相册界面
    
}


/**
 选择照骗调用

 @param picker <#picker description#>
 @param info <#info description#>
 */
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            //先把图片转成NSData
            UIImage* image = (UIImage *)[info objectForKey:@"UIImagePickerControllerEditedImage"];
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.4f);
            
            __block NSString *_encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
            NSLog(@"encodeString:%@",_encodedImageStr);
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                NSString *printString = [NSString stringWithFormat:@"webBridge.saveBase64ToImg('%@')",_encodedImageStr];
//                [self.appBridgeWebview stringByEvaluatingJavaScriptFromString:printString];
            });
            
        }];
    }
    
}

#pragma mark --  MaterialCellProtocol
- (void)didClickAddBtn{
    [self callSystemPhotoLibrary];
}
- (void)didClickDeleteBtn{
    NSLog(@"应该删除按钮");
}

#pragma mark -- UITableView DataSource&&Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeight(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, AdaptedHeight(40))];
    
    UIView *straightLine = [[UIView alloc] initWithFrame:CGRectMake(AdaptedWidth(16), AdaptedHeight(12), AdaptedWidth(2), AdaptedHeight(16))];
    straightLine.backgroundColor = RGB(197, 8, 25);
    [bgView addSubview:straightLine];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(straightLine.frame) + AdaptedWidth(4), AdaptedHeight(16), 100, AdaptedHeight(8))];
    textLabel.font = kFontSize(16);
    textLabel.text = [NSString stringWithFormat:@"第%zd段就这么大",section];
    [bgView addSubview:textLabel];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 450;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewMaterialCell *onlineCell = [tableView dequeueReusableCellWithIdentifier:onlineCellIdentifier];
    if(!onlineCell){
        onlineCell = [[UITableViewMaterialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onlineCellIdentifier];
        [onlineCell fillCellWithModel:nil];
        onlineCell.delegate = self;
    }
    return onlineCell;
}

#pragma mark -- 重写方法
- (UITableView *)applicationTableView{
    if(_applicationTableView == nil){
        _applicationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width , Screen_Height) style:UITableViewStyleGrouped];
        _applicationTableView.backgroundColor = [UIColor whiteColor];
        _applicationTableView.delegate = self;
        _applicationTableView.dataSource = self;
        _applicationTableView.allowsSelection = false;
    }
    return _applicationTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

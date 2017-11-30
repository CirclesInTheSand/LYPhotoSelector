//
//  OnlineApplicationViewController.m
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//



#import "OnlineApplicationViewController.h"
#import "OnlineApplicationViewController+TableViewDelegateMethods.h"
#import "MaterialModel.h"
#import "YQPhotoSelectController.h"
#import "SubmitBottomView.h"

#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;

@interface OnlineApplicationViewController ()
@property (nonatomic,strong) SubmitBottomView *bottomView; /**< 底部确认按钮视图 */
@end

@implementation OnlineApplicationViewController

#pragma mark -- 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self basicSettings];
    [self setUpSubviews];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [self.view addSubview:self.bottomView];
    
    [self.applicationTableView registerClass:[UITableViewMaterialCell class] forCellReuseIdentifier:onlineCellIdentifier];
    
    /**< 捏数据 */
    {
        /**< 事项材料个数 */
        NSArray *eventsArray = @[@"公共材料",@"事项材料一"];
        /**< 证件数组,为了方便起见最大数量都是99张*/
        NSArray *credentialArray = @[@[@"结婚证",@"准考证"],@[@"离婚证",@"出生证",@"装逼证"]];
        //开始造假数据
        for(NSInteger fakeType = 0; fakeType < eventsArray.count; fakeType ++){
            /**< 创建材料,一共就两种材料类型啊喂*/
            MaterialModel *materialModel = [[MaterialModel alloc] initWithMaterialType:fakeType];
            materialModel.cellTitle = eventsArray[fakeType];
            /**< 创建证件,但是证件却可以有很多种*/
            for(NSInteger credentialIndex = 0; credentialIndex < [credentialArray[fakeType] count]; credentialIndex ++){
                
                NSString *showTitle = credentialArray[fakeType][credentialIndex];
                CredentialsModel *credentialsModel = [[CredentialsModel alloc] initWithTitle:showTitle maxPhotoNum:99 materialType:fakeType];
                [materialModel addCredentialsModel:credentialsModel];
            }


            [self.dataSource addObject:materialModel];
        }
    }
    
}

#pragma mark -- 底部按钮点击
- (void)bottomBtnClicked:(UIButton *)sender{
    
//FIXME: 提交之前做一系列判断
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有内容你想提交什么啊？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark -- 访问相册

/**
 访问系统相册
 */
- (void)callSystemPhotoLibraryWithMaterialBtn:(MaterialBtn *)addBtn{
    
    YQPhotoSelectController *photoSelect = [[YQPhotoSelectController alloc]init];
    photoSelect.maxCount = self.availablePhotoNum;
    
    [photoSelect showInController:self result:^(NSMutableArray * responseImageObjects, NSMutableArray *responsePHAssetObjects) {
        
        /**< 将选择完的照片加入cell里面 */
        for(NSInteger countIndex = 0; countIndex < responseImageObjects.count ; countIndex ++)
        {
            UIImage* image = responseImageObjects[countIndex];
            PHAsset *photoAsset = [responsePHAssetObjects objectAtIndex:countIndex];
            NSLog(@"fileNameIs:%@",[photoAsset valueForKey:@"filename"]);
            PhotoModel *newPhotoModel =  [[PhotoModel alloc] initWithUIImage:image credentialsSection:addBtn.photoModel.credentialsSection materialType:addBtn.photoModel.modelType];
            
            MaterialModel *materialModel = self.dataSource[addBtn.photoModel.modelType];
            NSMutableArray *photoArray = (materialModel.credentialsArray[addBtn.photoModel.credentialsSection]).photoModelsArray;
            [photoArray addObject:newPhotoModel];
            
        }

     //   NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:self.currentSelectedMaterialBtn.modelType];
    //    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
   //     [self.applicationTableView reloadData];
        [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:addBtn.photoModel.credentialsSection inSection:addBtn.photoModel.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
}

#pragma mark -- UIScrollProtocol
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:true];
}

#pragma mark -- 重写方法
- (UITableView *)applicationTableView{
    if(_applicationTableView == nil){
        _applicationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64 - AdaptedHeight(72)) style:UITableViewStyleGrouped];
        _applicationTableView.backgroundColor = RGB(240, 240, 240);
        _applicationTableView.delegate = self;
        _applicationTableView.dataSource = self;
        _applicationTableView.allowsSelection = false;
        _applicationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _applicationTableView;
}

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[SubmitBottomView alloc] initWithFrame:CGRectMake(0, Screen_Height - AdaptedHeight(72), Screen_Width, AdaptedHeight(72))];
        [_bottomView addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (NSMutableArray *)dataSource{
    if(!_dataSource){
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (CredentialFooterView *)sectionFooterView{
    if(!_sectionFooterView){
        _sectionFooterView = [[CredentialFooterView alloc] init];
        
    }
    return _sectionFooterView;
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

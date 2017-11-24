//
//  OnlineApplicationViewController.m
//  LYPhotoSelector
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//



#import "OnlineApplicationViewController.h"
#import "OnlineConst.h"
#import "UITableViewMaterialCell.h"
#import "MaterialModel.h"
#import "MaterialBtn.h"
#import "YQPhotoSelectController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "OnlineSectionHeaderView.h"
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;

static NSString *onlineCellIdentifier = @"onlineCell";

@interface OnlineApplicationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MaterialCellProtocol>
@property (nonatomic,strong) UITableView *applicationTableView;
@property (nonatomic,strong) MaterialBtn *currentSelectedMaterialBtn;
@property (nonatomic,assign) NSInteger availablePhotoNum;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation OnlineApplicationViewController

#pragma mark -- 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self basicSettings];
    [self setUpSubviews];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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
    [self.view addSubview:self.bottomView];
    
    [self.applicationTableView registerClass:[UITableViewMaterialCell class] forCellReuseIdentifier:onlineCellIdentifier];
    
    //假的数据源
    NSArray *titleArray = @[@"公共材料",@"事项一材料",@"事项二材料"];
    NSArray *firstLineTextArray = @[@"身份证复印件",@"事项一类型 : 合同-担保合同-抵押合同\n合同复印件",@"事件二类型 : 出国留学-学历证明\n学历复印件"];
    NSArray *secondLineTextArray = @[@"户口本",@"其他",@"其他"];
    NSArray *subTitleArray = @[firstLineTextArray,secondLineTextArray];
    NSArray *defautlMaximumNum = @[@[@99,@99],@[@99,@99],@[@99,@99]];
    
    NSInteger maxAmount = 3;
    for(NSInteger index = 0; index < maxAmount; index ++){
        MaterialModel *model = MaterialModel.new;
        model.modelType = index;
        model.cellTitle = titleArray[index];
        for(NSInteger subModelIndex = 0; subModelIndex < 2; subModelIndex ++)
        {
            NSArray *subMaterialTitleArray = subTitleArray[subModelIndex];
            NSNumber *limiteNum = defautlMaximumNum[index][subModelIndex];
            SubMaterialModel *subModel = [[SubMaterialModel alloc] init];
            subModel.title = subMaterialTitleArray[index];
            subModel.maximumPhotoNum = [limiteNum integerValue];
            subModel.photoBtnType =  subModelIndex;
            [model.subMaterialArray addObject:subModel];
        }
        [self.dataSource addObject:model];
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
- (void)callSystemPhotoLibrary{
    
    YQPhotoSelectController *photoSelect = [[YQPhotoSelectController alloc]init];
    photoSelect.maxCount = self.availablePhotoNum;
    
    [photoSelect showInController:self result:^(NSMutableArray * responseImageObjects, NSMutableArray *responsePHAssetObjects) {
        for(NSInteger countIndex = 0; countIndex < responseImageObjects.count ; countIndex ++)
        {
            UIImage* image = responseImageObjects[countIndex];
            
            PhotoModel *newPhotoModel =  [[PhotoModel alloc] initWithUIImage:image type:self.currentSelectedMaterialBtn.btnType];
            
            MaterialModel *materialModel = self.dataSource[self.currentSelectedMaterialBtn.modelType];
            NSMutableArray *photoArray = (materialModel.subMaterialArray[self.currentSelectedMaterialBtn.btnType]).photoModelsArray;
            [photoArray addObject:newPhotoModel];
            
        }

     //   NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:self.currentSelectedMaterialBtn.modelType];
    //    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
   //     [self.applicationTableView reloadData];
        [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:self.currentSelectedMaterialBtn.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
}

#pragma mark --  MaterialCellProtocol
- (void)didClickAddBtn:(MaterialBtn *)btn{
    MaterialModel *materialModel = self.dataSource[btn.modelType];
    SubMaterialModel *subMaterial = materialModel.subMaterialArray[btn.btnType];
    
    NSMutableArray *photosArray = subMaterial.photoModelsArray;
    if(subMaterial.maximumPhotoNum <= photosArray.count){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"照片数量已达上限" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:true completion:nil];
        return;
    }
    self.availablePhotoNum = subMaterial.maximumPhotoNum - subMaterial.photoModelsArray.count;
    self.currentSelectedMaterialBtn = btn;
    [self callSystemPhotoLibrary];
}

- (void)didClickShowBtn:(MaterialBtn *)btn{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    NSInteger indexOfPhotoModel = btn.tag - kBtnMacroIndex;
    MaterialModel *materialModel = self.dataSource[btn.modelType];
    NSMutableArray *photosArray = (materialModel.subMaterialArray[btn.btnType]).photoModelsArray;
    
    MJPhotoBrowser *browser  = [[MJPhotoBrowser alloc]init];
    browser.delegate = self;
    NSMutableArray *photos = [NSMutableArray array];
    for (NSInteger index = 0 ; index < photosArray.count; index++) {
        PhotoModel *photoModel = photosArray[index];
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        UIImage *photoImage = photoModel.photoImageObject;
        
        
        photo.image = photoImage;
        //设置来源于哪一个UIImageView
        photo.srcImageView = btn.bgImageView;
        
        [photos addObject:photo];
        
    }
    browser.photos = photos;
    
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = indexOfPhotoModel;
    
    // 4.显示浏览器
    [browser show];
}

- (void)didClickDeleteIcon:(MaterialBtn *)btn{

    NSInteger indexOfPhotoModel = btn.tag - kBtnMacroIndex;
    MaterialModel *materialModel = self.dataSource[btn.modelType];
    NSMutableArray *photosArray = (materialModel.subMaterialArray[btn.btnType]).photoModelsArray;
    [photosArray removeObjectAtIndex:indexOfPhotoModel];
//
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:materialModel.modelType];
//    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:materialModel.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];


}

#pragma mark -- UITableView DataSource&&Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AdaptedHeight(8);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MaterialModel *model = self.dataSource[section];
    OnlineSectionHeaderView *headerView = (OnlineSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if(!headerView){
        headerView = [[OnlineSectionHeaderView alloc] initWithReuseIdentifier:@"headerView" model:model];
    }
    headerView.titleString = model.cellTitle;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialModel *model = self.dataSource[indexPath.section];
//    return [tableView fd_heightForCellWithIdentifier:onlineCellIdentifier configuration:^(id cell) {
//        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
//        // Like:
//        //    cell.entity = self.feedEntities[indexPath.row];
//        ((UITableViewMaterialCell *)cell).fd_enforceFrameLayout = true;
//        ((UITableViewMaterialCell *)cell).delegate = self;
//        [((UITableViewMaterialCell *)cell) fillCellWithModel:model];
//
//    }];
    
    CGFloat originHeight = 0;
    CGFloat integerBtnDistanceY = (Screen_Width - AdaptedWidth(63))/4.0 + AdaptedHeight(10);
    
    for(NSInteger index = 0; index < model.subMaterialArray.count; index ++){
        SubMaterialModel *subMaterialModel = model.subMaterialArray[index];
        NSInteger linePhotoCount = subMaterialModel.photoModelsArray.count;
        if(linePhotoCount == subMaterialModel.maximumPhotoNum){//已达最大数量
            linePhotoCount -= 1;
        }
        originHeight += (linePhotoCount / 4 * integerBtnDistanceY);
    }
    
    switch (indexPath.section) {
        case 0:
        {
            originHeight += AdaptedHeight(349);
            
            return originHeight;
        }
        case 1:
        {
            originHeight += AdaptedHeight(279);
            return originHeight;
        }
        case 2:
        {
            originHeight += AdaptedHeight(279);
            return originHeight;
        }
        default:
            break;
    }
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialModel *model = self.dataSource[indexPath.section];
    UITableViewMaterialCell *onlineCell = [tableView dequeueReusableCellWithIdentifier:onlineCellIdentifier];
    onlineCell.delegate = self;
    [onlineCell fillCellWithModel:model];
    NSLog(@"%@",indexPath);
    return onlineCell;
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
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - AdaptedHeight(72), Screen_Width, AdaptedHeight(72))];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomBtn.frame = CGRectMake(AdaptedWidth(16), AdaptedHeight(16), Screen_Width - 2 * AdaptedWidth(16), CGRectGetHeight(_bottomView.frame) - 2 * AdaptedHeight(16));
        bottomBtn.backgroundColor = RGB(199, 0, 11);
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomBtn.titleLabel.font = kFontSize(14);
        [bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
        bottomBtn.layer.cornerRadius = AdaptedHeight(20);
        [bottomBtn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:bottomBtn];
        
    }
    return _bottomView;
}

- (NSMutableArray *)dataSource{
    if(!_dataSource){
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
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

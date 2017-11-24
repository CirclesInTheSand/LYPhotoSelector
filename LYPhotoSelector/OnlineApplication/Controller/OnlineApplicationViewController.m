//
//  OnlineApplicationViewController.m
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
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
- (void)callSystemPhotoLibrary{
    
    YQPhotoSelectController *photoSelect = [[YQPhotoSelectController alloc]init];
    photoSelect.maxCount = self.availablePhotoNum;
    
    [photoSelect showInController:self result:^(NSMutableArray * responseImageObjects, NSMutableArray *responsePHAssetObjects) {
        
        /**< 将选择完的照片加入cell里面 */
        for(NSInteger countIndex = 0; countIndex < responseImageObjects.count ; countIndex ++)
        {
            UIImage* image = responseImageObjects[countIndex];
            
            PhotoModel *newPhotoModel =  [[PhotoModel alloc] initWithUIImage:image credentialsSection:self.currentSelectedMaterialBtn.photoModel.credentialsSection materialType:self.currentSelectedMaterialBtn.photoModel.modelType];
            
            MaterialModel *materialModel = self.dataSource[self.currentSelectedMaterialBtn.photoModel.modelType];
            NSMutableArray *photoArray = (materialModel.credentialsArray[self.currentSelectedMaterialBtn.photoModel.credentialsSection]).photoModelsArray;
            [photoArray addObject:newPhotoModel];
            
        }

     //   NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:self.currentSelectedMaterialBtn.modelType];
    //    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
   //     [self.applicationTableView reloadData];
        [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentSelectedMaterialBtn.photoModel.credentialsSection inSection:self.currentSelectedMaterialBtn.photoModel.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.applicationTableView reloadData];
    }];
    
}

#pragma mark --  MaterialCellProtocol
- (void)didClickAddBtn:(MaterialBtn *)btn{
    
    PhotoModel *selectedPhotoModel = btn.photoModel;
    
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    CredentialsModel *subMaterial = materialModel.credentialsArray[selectedPhotoModel.credentialsSection];
    
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
    
    PhotoModel *selectedPhotoModel = btn.photoModel;
    NSInteger indexOfPhotoModel = selectedPhotoModel.photoRow;
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    NSMutableArray *photosArray = (materialModel.credentialsArray[selectedPhotoModel.credentialsSection]).photoModelsArray;
    
    MJPhotoBrowser *browser  = [[MJPhotoBrowser alloc]init];
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
    PhotoModel *selectedPhotoModel = btn.photoModel;
    NSInteger indexOfPhotoModel = selectedPhotoModel.photoRow;
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    NSMutableArray *photosArray = (materialModel.credentialsArray[selectedPhotoModel.credentialsSection]).photoModelsArray;
    [photosArray removeObjectAtIndex:indexOfPhotoModel];
//
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:materialModel.modelType];
//    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    

    [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentSelectedMaterialBtn.photoModel.credentialsSection inSection:self.currentSelectedMaterialBtn.photoModel.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];

}

#pragma mark -- UITableView DataSource&&Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0)return AdaptedHeight(120);
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 0){
        
        
            UIView *bgFooterView = [[UIView alloc] init];
            bgFooterView.backgroundColor = [UIColor whiteColor];
            NSString *detailText = @"备注 : 如果您上传的材料有特殊的译法，请务必在本下栏中注明。如果有钢印描述不清，请注明钢印文字";
            NSMutableAttributedString *firstAttributedString = [[NSMutableAttributedString alloc] initWithString:detailText];
            CGFloat maximunHeight = AdaptedHeight(18);
        
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            if([detailText heightForFont:kFontSize(12) width:(Screen_Width - AdaptedWidth(2 * AdaptedWidth(16)))] > maximunHeight){
                [paragraphStyle setLineSpacing:9];
            }else{
                [paragraphStyle setLineSpacing:0];
            }
        
            [firstAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailText.length)];
        
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 2 * AdaptedWidth(16), 0)];
            detailLabel.numberOfLines = 0;
            detailLabel.attributedText = firstAttributedString;
            detailLabel.textColor = RGB(51, 51, 51);
            detailLabel.font = kFontSize(12);
            [detailLabel sizeToFit];
            detailLabel.frame = CGRectMake(AdaptedWidth(16), AdaptedHeight(16), Screen_Width - 2 * AdaptedWidth(16), detailLabel.frame.size.height);
            [bgFooterView addSubview:detailLabel];
        
            UITextField *detailTextField = [[UITextField alloc] initWithFrame:CGRectMake(AdaptedWidth(16), CGRectGetMaxY(detailLabel.frame) + AdaptedHeight(16), Screen_Width - 2 * AdaptedWidth(16), AdaptedHeight(25))];
            detailTextField.placeholder = @"  请输入需要备注的信息";
            detailTextField.font = kFontSize(12);
            detailTextField.backgroundColor = RGB(245, 245, 245);
            detailTextField.layer.borderColor = RGB(179, 179, 179).CGColor;
            detailTextField.layer.borderWidth = SINGLE_LINE_WIDTH;
            [bgFooterView addSubview:detailTextField];
        
            UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detailTextField.frame) + AdaptedHeight(8), Screen_Width, AdaptedHeight(8))];
            bottomLine.backgroundColor = RGB(240, 240, 240);
            [bgFooterView addSubview:bottomLine];
        
            return bgFooterView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialModel *model = self.dataSource[indexPath.section];
    CredentialsModel *credential = model.credentialsArray[indexPath.row];
    CGFloat originHeight = 0;
    CGFloat integerBtnDistanceY = (Screen_Width - AdaptedWidth(63))/4.0 + AdaptedHeight(10);
    
 
    NSInteger linePhotoCount = credential.photoModelsArray.count;
    if(linePhotoCount == credential.maximumPhotoNum){//已达最大数量
        linePhotoCount -= 1;
    }
    originHeight += (linePhotoCount / 4 * integerBtnDistanceY);

    originHeight += AdaptedHeight(140);//349
    
    return originHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MaterialModel *model = self.dataSource[section];
    
    return model.credentialsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialModel *model = self.dataSource[indexPath.section];
    CredentialsModel *credentialModel = model.credentialsArray[indexPath.row];
    
    UITableViewMaterialCell *onlineCell = [tableView dequeueReusableCellWithIdentifier:onlineCellIdentifier];
    onlineCell.delegate = self;
    [onlineCell fillCellWithModel:credentialModel];
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

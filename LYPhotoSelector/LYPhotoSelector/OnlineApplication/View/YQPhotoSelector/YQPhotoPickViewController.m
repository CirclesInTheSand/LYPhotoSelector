//
//  YQPhotoPickViewController.m
//  PhotoSelect
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQPhotoPickViewController.h"
#import "OnlineConst.h"

@interface YQPhotoPickViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YQPhotoSelectorToolViewDelegate>

@property (nonatomic ,strong)UICollectionView *collectionView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UILabel *totalNumLabel;

@property (nonatomic ,strong)NSMutableArray *selectArray;

@property (nonatomic ,strong)YQPhotoSelectorToolView *toolView;

@property (nonatomic ,assign)BOOL isCompelete;

@property (nonatomic ,strong)NSMutableArray *originPhotos;

@end

@implementation YQPhotoPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片请求全部完成的监听
    [self addObserver:self
             forKeyPath:@"isCompelete"
                options:NSKeyValueObservingOptionNew
                context:nil];
    
    [self setUpViews];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    
    self.Result(self.originPhotos,self.selectArray);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"isCompelete"];
}

- (void)setUpViews{

    self.automaticallyAdjustsScrollViewInsets = false;
    
    //导航条设置
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"return0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popBack:)];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.selectArray = [NSMutableArray array];
    if(self.selectedPhotos && self.selectedPhotos.count > 0)
    {
        [self.selectArray addObjectsFromArray:self.selectedPhotos];
    }
    
    PHFetchResult *result = [[YQPhotoHelper shareYQPhotoHelper]GetFetchResult:self.assetCollection];
    
    self.dataSource = [[YQPhotoHelper shareYQPhotoHelper]GetPhotoAssets:result];
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 3) / 4;
    flowLayout.minimumInteritemSpacing = 1.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 1.0;//item 之间竖的距离
    flowLayout.itemSize = (CGSize){photoSize,photoSize};
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 44 - 64) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource= self;
    
    [self.collectionView registerClass:[PhotoPickCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
    [self.view addSubview:self.collectionView];
    
    self.totalNumLabel.text = [NSString stringWithFormat:@"%zd 张照片",self.dataSource.count];
    
    self.toolView = [[YQPhotoSelectorToolView alloc]initWithFrame:CGRectMake(0, Screen_Height - 44, Screen_Width, 44)];
    
    self.toolView.delegate = self;
    
    [self.view addSubview:self.toolView];
    [self.toolView setSelectCount:self.selectArray.count];
}

#pragma mark - 导航条返回
- (void)popBack:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark - 完成按钮点击
- (void)didClickedDoneBtn:(UIButton *)doneBtn{

    [self transformModel:self.selectArray];
    
}

- (void)transformModel:(NSMutableArray *)arr{
    
    NSMutableArray *selectPhotos = [NSMutableArray array];
    
    self.originPhotos = selectPhotos;
    
    [arr enumerateObjectsUsingBlock:^(PHAsset * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
       __block UIImage *originalImage;
        [[PHImageManager defaultManager]requestImageForAsset:obj targetSize:CGSizeMake(obj.pixelWidth, obj.pixelHeight) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            if (![[info objectForKey:PHImageResultIsDegradedKey] boolValue]) {
                originalImage = result;
                
                if (![self.originPhotos containsObject:originalImage]) {
                    
                    [self.originPhotos addObject:originalImage];
                    
                    if (self.originPhotos.count == arr.count) {
                        //高清图全部请求完成之后 通知KVO
                        [self setValue:@YES forKey:@"isCompelete"];
                    }
                }

            }
            
        }];
        
    }];

}

#pragma mark - 选择照片
- (void)selectPicBtn:(UIButton *)sender{

    NSInteger index = sender.tag;
    if (sender.selected == NO) {//没有选择的时候
        [[YQPhotoAnimationMnager shareManager] showCATransform3DMakeScaleAnimation:sender];
        if (self.selectArray.count+ 1 > self.maxCount) {
            
            [YQPhotoSelectorHUD showHUDWithTitle:[NSString stringWithFormat:@"最多只能选择%zd张图片",self.maxCount]];
        }else{
            
            [self.selectArray addObject:[self.dataSource objectAtIndex:index]];
            [sender setImage:[UIImage imageNamed:@"YQPhotoSelector.bundle/select_yes"] forState:UIControlStateNormal];
            sender.selected = YES;
            [self.toolView setSelectCount:self.selectArray.count];
            
        }
    }else{//已经被选择
        [[YQPhotoAnimationMnager shareManager] showCATransform3DMakeScaleAnimation:sender];
        [self.selectArray removeObject:[self.dataSource objectAtIndex:index]];
        [sender setImage:[UIImage imageNamed:@"YQPhotoSelector.bundle/select_no"] forState:UIControlStateNormal];
        sender.selected = NO;
        [self.toolView setSelectCount:self.selectArray.count];
    }

}
#pragma mark 选择按钮的动画
- (void)showAnimation:(UIButton *)sender{

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    [sender.layer addAnimation:animation forKey:nil];
    
}

#pragma UICollectionView --- Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoPickCollectionViewCell *selectedCell = (PhotoPickCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIButton *sender = selectedCell.selectBtn;
    [self selectPicBtn:sender];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    PhotoPickCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.selectBtn.tag = indexPath.row;
    
    [cell fillCellWithAsset:[self.dataSource objectAtIndex:indexPath.row]];
    
    [cell selectBtnStage:self.selectArray existence:self.dataSource[indexPath.row]];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    UICollectionReusableView *footerView = [[UICollectionReusableView alloc]init];
    footerView.backgroundColor = [UIColor redColor];
    if (kind == UICollectionElementKindSectionFooter){
        footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    }
    
    [footerView addSubview:self.totalNumLabel];
    return footerView;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 3) / 4, ([UIScreen mainScreen].bounds.size.width - 3) / 4);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

#pragma mark footView
- (UILabel *)totalNumLabel{
    if (!_totalNumLabel) {
        _totalNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
        _totalNumLabel.textColor = [UIColor blackColor];
        _totalNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalNumLabel;
}

@end

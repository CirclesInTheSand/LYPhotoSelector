//
//  MaterialBtn.m
//  TestMutiRequest
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "MaterialBtn.h"
#import "OnlineConst.h"

@interface MaterialBtn ()
@property (nonatomic,strong) UIImageView *deleteIcon;
@end

@implementation MaterialBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        UIImageView *deleteIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        deleteIcon.backgroundColor = [UIColor greenColor];
        self.deleteIcon = deleteIcon;
        [self addSubview:deleteIcon];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.selected){
        self.deleteIcon.frame = CGRectMake(self.frame.size.width - AdaptedWidth(3 + 18), AdaptedHeight(3), AdaptedWidth(18), AdaptedHeight(18));
    }else{
        self.deleteIcon.frame = CGRectZero;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

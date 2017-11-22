//
//  MaterialBtn.m
//  ColossalPhotoSelector
//
//  Created by MyMacbook on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "MaterialBtn.h"
#import "OnlineConst.h"

@interface MaterialBtn ()
@end

@implementation MaterialBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        UIButton *deleteIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteIcon setBackgroundImage:[UIImage imageNamed:@"selectedMinus"] forState:UIControlStateNormal];

        self.deleteBtn = deleteIcon;
        [self addSubview:deleteIcon];
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self insertSubview:self.bgImageView atIndex:0];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    UIImage *unselectedImage = [UIImage imageNamed:@"unselectedPlus"];
    [self setBackgroundImage:selected?nil:unselectedImage forState:UIControlStateNormal];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    [super setBackgroundImage:image forState:state];
    
    self.bgImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.bgImageView.image = image;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.selected){
        self.deleteBtn.frame = CGRectMake(self.frame.size.width - AdaptedWidth(3 + 18), AdaptedHeight(3), AdaptedWidth(18), AdaptedHeight(18));
    }else{
        self.deleteBtn.frame = CGRectZero;
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

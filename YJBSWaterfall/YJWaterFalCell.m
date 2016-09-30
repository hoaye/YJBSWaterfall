//
//  YJWaterFalCell.m
//  YJBSWaterfall
//
//  Created by YJHou on 16/4/16.
//  Copyright © 2016年 ismonkey.com. All rights reserved.
//

#import "YJWaterFalCell.h"
#import "UIImageView+WebCache.h"

@interface YJWaterFalCell ()

@property (strong, nonatomic) UIImageView * imgView;
//@property (strong, nonatomic) UILabel * priceLabel;
//@property (strong, nonatomic) UIView * bgView;


@end

@implementation YJWaterFalCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgView];
        
    }
    return self;
}


- (void)modelToRefashCollectViewCellModel:(YJWaterFallModel *)model{
    
    //111.666667
    
    // h     W
    // imgH  ImgW
    CGFloat imgW = self.contentView.frame.size.width;
    CGFloat imgH = imgW * model.h / model.w;
    
    self.imgView.frame = CGRectMake(0, 0, imgW, imgH);
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
}


@end

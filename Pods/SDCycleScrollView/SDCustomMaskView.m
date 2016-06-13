//
//  SDCustomMaskView.m
//  Pods
//
//  Created by 宓珂璟 on 16/6/6.
//
//

#import "SDCustomMaskView.h"
#import "Masonry.h"

@implementation SDCustomMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.countryLabel = [[UILabel alloc] init];
        self.countryLabel.font = [UIFont boldSystemFontOfSize:25];
        self.countryLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.countryLabel];
        
        self.productNumberLable = [[UILabel alloc] init];
        [self addSubview:self.productNumberLable];
        
        [self layoutMasonry];
    }
    return self;
}

- (void)layoutMasonry
{
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self); // offset 20 往右  -20 往左
        make.centerY.equalTo(self).with.offset(-20); // -20 往上  20 往下
        
    }];
    
    [self.productNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(self.countryLabel.mas_bottom).with.offset(7);
    }];
}



@end

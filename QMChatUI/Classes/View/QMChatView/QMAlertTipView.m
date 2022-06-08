//
//  QMAlertTipView.m
//  IMSDK
//
//  Created by 焦林生 on 2022/5/17.
//

#import "QMAlertTipView.h"
#import "QMHeader.h"
#import "Masonry.h"

@interface QMAlertTipView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *configButton;

@end
@implementation QMAlertTipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithHexString:QMColor_000000_text alpha:0.4];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.QMCornerRadius = 10;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(QM_kScreenWidth-QMFixWidth(64), 160));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = QMFont_Medium(15);
    self.titleLabel.textColor = [UIColor colorWithHexString:QMColor_151515_text];
    self.titleLabel.numberOfLines = 0;
    [backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.centerX.equalTo(self);
        make.left.mas_equalTo(QMFixWidth(55));
        make.right.mas_equalTo(-QMFixWidth(55));
    }];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorWithHexString:QMColor_666666_text] forState:UIControlStateNormal];
    self.cancelButton.QMCornerRadius = 5;
    self.cancelButton.layer.borderColor = [UIColor colorWithHexString:@"#E4E4E4"].CGColor;
    self.cancelButton.layer.borderWidth = 0.5;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(QMFixWidth(37));
        make.bottom.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(QMFixWidth(110), 40));
    }];
    
    self.configButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.configButton setTitle:@"确定" forState:UIControlStateNormal];
    self.configButton.backgroundColor = [UIColor colorWithHexString:@"#19CAA6 "];
    [self.configButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.configButton.QMCornerRadius = 5;
    [self.configButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.configButton];
    [self.configButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-QMFixWidth(37));
        make.centerY.equalTo(self.cancelButton);
        make.size.mas_equalTo(CGSizeMake(QMFixWidth(110), 40));
    }];
    
}

- (void)setTipString:(NSString *)tipString {
    self.titleLabel.text = tipString;
}

- (void)cancelButtonAction:(UIButton *)action {
    [self removeFromSuperview];
}

- (void)sureButtonAction:(UIButton *)action {
    if (self.confirmBlock) {
        self.confirmBlock(YES);
    }
    [self removeFromSuperview];
}

@end

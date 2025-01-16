//
//  QMChatImageCell.h
//  IMSDK
//
//  Created by 焦林生 on 2021/12/30.
//

#import "QMChatBaseCell.h"
#import <SDWebImage/SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMChatImageCell : QMChatBaseCell

@property (nonatomic, strong) SDAnimatedImageView *showImageView;

@end

NS_ASSUME_NONNULL_END

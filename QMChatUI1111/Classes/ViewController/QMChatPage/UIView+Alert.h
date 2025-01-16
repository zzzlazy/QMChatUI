//
//  UIView+Alert.h
//  Pods
//
//  Created by zero on 2023/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Alert)
- (void)RockAlertTipTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancelBlock:(void(^)(void))cancelBlock confirmBlock:(void(^)(void))confirmBlock;
@end

NS_ASSUME_NONNULL_END

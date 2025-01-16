//
//  UIView+Alert.m
//  Pods
//
//  Created by zero on 2023/6/29.
//

#import "UIView+Alert.h"

@implementation UIView (Alert)
- (void)RockAlertTipTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancelBlock:(void(^)(void))cancelBlock confirmBlock:(void(^)(void))confirmBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertController addAction:cancelAction];
    }
    if (confirmTitle.length > 0) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock();
            }
        }];
        [alertController addAction:confirmAction];
    }
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}


@end

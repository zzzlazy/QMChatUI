//
//  QMChatTextCell.m
//  IMSDK
//
//  Created by lishuijiao on 2020/10/10.
//

#import "QMChatTextCell.h"
#import "MLEmojiLabel.h"
#import "QMHeader.h"
@interface QMChatTextCell() <MLEmojiLabelDelegate>

@end

@implementation QMChatTextCell {
    
    MLEmojiLabel *_textLabel;
}

- (void)createUI {
    [super createUI];
    
    _textLabel = [MLEmojiLabel new];
    _textLabel.numberOfLines = 0;
    _textLabel.font = [UIFont fontWithName:QM_PingFangSC_Reg size:16];
    _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _textLabel.delegate = self;
    _textLabel.disableEmoji = NO;
    _textLabel.disableThreeCommon = NO;
    _textLabel.isNeedAtAndPoundSign = YES;
    _textLabel.customEmojiRegex = @"\\:[^\\:]+\\:";
    _textLabel.customEmojiPlistName = @"expressionImage.plist";
    _textLabel.customEmojiBundleName = @"QMEmoticon.bundle";
    [self.chatBackgroundView addSubview:_textLabel];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatBackgroundView).offset(2.5).priority(999);
        make.left.equalTo(self.chatBackgroundView).offset(8);
        make.width.mas_greaterThanOrEqualTo(20).priority(999);
        make.right.equalTo(self.chatBackgroundView).offset(-8);
        make.bottom.equalTo(self.chatBackgroundView).offset(-2.5).priority(999);
        make.height.mas_greaterThanOrEqualTo(40).priorityHigh();
    }];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTapGesture:)];
    [_textLabel addGestureRecognizer:longPressGesture];
}

- (void)setData:(CustomMessage *)message avater:(NSString *)avater {
    
    [super setData:message avater:avater];
    self.message = message;
   
    if ([message.fromType isEqualToString:@"0"]) {
        _textLabel.textColor = [UIColor colorWithHexString:QMColor_FFFFFF_text];
    }
    else {
        _textLabel.textColor = [UIColor colorWithHexString:isDarkStyle ? QMColor_D4D4D4_text : QMColor_151515_text];
    }
    _textLabel.text = message.message;
}

- (void)longPressTapGesture:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *copyMenu = [[UIMenuItem alloc] initWithTitle:QMUILocalizableString(button.copy)  action:@selector(copyMenu:)];
        UIMenuItem *removeMenu = [[UIMenuItem alloc] initWithTitle:QMUILocalizableString(button.delete) action:@selector(removeMenu:)];
        [menu setMenuItems:[NSArray arrayWithObjects:copyMenu,removeMenu, nil]];
        [menu setTargetRect:self.chatBackgroundView.frame inView:self];
        [menu setMenuVisible:true animated:true];
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        if ([window isKeyWindow] == NO) {
            [window becomeKeyWindow];
            [window makeKeyAndVisible];
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyMenu:) || action == @selector(removeMenu:)) {
        return YES;
    }else {
        return  NO;
    }
}

- (void)copyMenu:(id)sender {
    // 复制文本消息
    UIPasteboard *pasteBoard =  [UIPasteboard generalPasteboard];
    pasteBoard.string = _textLabel.text;
}

- (void)removeMenu:(id)sender {
    // 删除文本消息
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:QMUILocalizableString(title.prompt) message:QMUILocalizableString(title.statement) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QMUILocalizableString(button.cancel) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:QMUILocalizableString(button.sure) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [QMConnect removeDataFromDataBase:self.message._id];
        [[NSNotificationCenter defaultCenter] postNotificationName:CHATMSG_RELOAD object:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)helpBtnAction: (UIButton *)sender {
    self.didBtnAction(YES);
}

- (void)noHelpBtnAction: (UIButton *)sender {
    self.didBtnAction(NO);
}

- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type {
    if (type == MLEmojiLabelLinkTypePhoneNumber) {
        if (link) {
            self.tapNumberAction(link);
        }
    }else {
        if (link) {
            self.tapNetAddress(link);
        }
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TCFaceView.m
//  IMSDK
//
//  Created by lishuijiao on 2020/10/13.
//

#import "TCFaceView.h"
#import "QMHeader.h"

#define QMNumPerLine 7
#define QMLines    3
#define QMFaceSize  34
/*
 ** 两边边缘间隔
 */
//#define EdgeDistance 20

static int EdgeDistance = 20;

/*
 ** 上下边缘间隔
 */
#define QMEdgeInterVal 5

@implementation TCFaceView

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationMaskPortrait) {
        //竖屏布局
        EdgeDistance = 20;
    } else {
        //横屏布局
        EdgeDistance = 25;
    }
}

- (id)initWithFrame:(CGRect)frame forIndexPath:(int)index {
    self = [super initWithFrame:frame];
    if (self) {
        // 水平间隔
        CGFloat horizontalInterval = (CGRectGetWidth(self.bounds)-QMNumPerLine*QMFaceSize -2*EdgeDistance)/(QMNumPerLine-1);
        // 上下垂直间隔
        CGFloat verticalInterval = (CGRectGetHeight(self.bounds)-2*QMEdgeInterVal -QMLines*QMFaceSize)/(QMLines-1);
        
        NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"QMEmoticon" ofType:@"bundle"];
        
        for (int i = 0; i<QMLines; i++) {
            for (int x = 0;x<QMNumPerLine;x++) {
                UIButton *expressionButton =[UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:expressionButton];
                [expressionButton setFrame:CGRectMake(x*QMFaceSize+EdgeDistance+x*horizontalInterval,
                                                      i*QMFaceSize +i*verticalInterval+QMEdgeInterVal,
                                                      QMFaceSize,
                                                      QMFaceSize)];
                if (i*7+x+1 ==21) {
                    [expressionButton setBackgroundImage:[UIImage imageWithContentsOfFile: [NSString stringWithFormat:@"%@/emoji_delete", bundlePath]]
                                                forState:UIControlStateNormal];
                    expressionButton.tag = 101;
                }else{
                    NSString *imageStr = [NSString stringWithFormat:@"emoji_%d",(index*20+i*7+x+1)];
                    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", bundlePath, imageStr];
                    
                    [expressionButton setBackgroundImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
                    expressionButton.tag = 20*index+i*7+x+1;
                }
                [expressionButton addTarget:self
                                     action:@selector(faceClick:)
                           forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    return self;
}

- (void)faceClick:(UIButton *)button{
    NSString *faceName;
    BOOL isDelete;
    if (button.tag ==101){
        faceName = nil;
        isDelete = YES;
    }else{
        NSString *expressstring = [NSString stringWithFormat:@"emoji_%ld.png",(long)button.tag];
        NSString *plistStr = [TUIBundle(QMChatUIBundle) pathForResource:@"expressionImage" ofType:@"plist"];
        NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:plistStr];
        for (int j = 0; j<[[plistDic allKeys]count]; j++)
        {
            if ([[plistDic objectForKey:[[plistDic allKeys]objectAtIndex:j]]
                 isEqualToString:[NSString stringWithFormat:@"%@",expressstring]])
            {
                faceName = [[plistDic allKeys]objectAtIndex:j];
            }
        }
        isDelete = NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelecteFace:andIsSelecteDelete:)]) {
        [self.delegate didSelecteFace:faceName andIsSelecteDelete:isDelete];
    }
}

@end

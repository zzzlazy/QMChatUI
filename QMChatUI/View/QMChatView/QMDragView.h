//
//  QMDragView.h
//  IMSDK
//
//  Created by 焦林生 on 2023/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 拖曳view的方向
typedef NS_ENUM(NSInteger, WMDragDirection) {
    QMDragDirectionAny,          /**< 任意方向 */
    QMDragDirectionHorizontal,   /**< 水平方向 */
    QMDragDirectionVertical,     /**< 垂直方向 */
};

@interface QMDragView : UIView

/**
 是不是能拖曳，默认为YES
 YES，能拖曳
 NO，不能拖曳
 */
@property (nonatomic,assign) BOOL dragEnable;

/**
 活动范围，默认为父视图的frame范围内（因为拖出父视图后无法点击，也没意义）
 如果设置了，则会在给定的范围内活动
 如果没设置，则会在父视图范围内活动
 注意：设置的frame不要大于父视图范围
 注意：设置的frame为0，0，0，0表示活动的范围为默认的父视图frame，如果想要不能活动，请设置dragEnable这个属性为NO
 */
@property (nonatomic,assign) CGRect freeRect;

/**
 拖曳的方向，默认为any，任意方向
 */
@property (nonatomic,assign) WMDragDirection dragDirection;

/**
 contentView内部懒加载的一个UIImageView
 开发者也可以自定义控件添加到本view中
 注意：最好不要同时使用内部的imageView和button
 */
@property (nonatomic,strong) UIImageView *imageView;
/**
 contentView内部懒加载的一个UIButton
 开发者也可以自定义控件添加到本view中
 注意：最好不要同时使用内部的imageView和button
 */
@property (nonatomic,strong) UIButton *button;
/**
 是不是总保持在父视图边界，默认为NO,没有黏贴边界效果
 isKeepBounds = YES，它将自动黏贴边界，而且是最近的边界
 isKeepBounds = NO， 它将不会黏贴在边界，它是free(自由)状态，跟随手指到任意位置，但是也不可以拖出给定的范围frame
 */
@property (nonatomic,assign) BOOL isKeepBounds;
/**
 点击的回调block
 */
@property (nonatomic,copy) void(^clickDragViewBlock)(QMDragView *dragView);
/**
 开始拖动的回调block
 */
@property (nonatomic,copy) void(^beginDragBlock)(QMDragView *dragView);
/**
 拖动中的回调block
 */
@property (nonatomic,copy) void(^duringDragBlock)(QMDragView *dragView);
/**
 结束拖动的回调block
 */
@property (nonatomic,copy) void(^endDragBlock)(QMDragView *dragView);

@end

NS_ASSUME_NONNULL_END

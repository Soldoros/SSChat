//
//  MAAnnotationView.h
//  MAMapKit
//
//  Created by AutoNavi.
//  Copyright (c) 2013年 Amap. All rights reserved.
//

#import <UIKit/UIKit.h>

///annotationView拖动状态
typedef NS_ENUM(NSInteger, MAAnnotationViewDragState) {
    MAAnnotationViewDragStateNone = 0,      ///< 静止状态
    MAAnnotationViewDragStateStarting,      ///< 开始拖动
    MAAnnotationViewDragStateDragging,      ///< 拖动中
    MAAnnotationViewDragStateCanceling,     ///< 取消拖动
    MAAnnotationViewDragStateEnding         ///< 拖动结束
};

@protocol MAAnnotation;

///标注view
@interface MAAnnotationView : UIView

///复用标识
@property (nonatomic, readonly) NSString *reuseIdentifier;

///z值，大值在上，默认为0
@property (nonatomic, assign) NSInteger zIndex;

///关联的annotation
@property (nonatomic, strong) id <MAAnnotation> annotation;

///显示的image
@property (nonatomic, strong) UIImage *image;

///默认情况下，annotation view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
@property (nonatomic) CGPoint centerOffset;

///默认情况下，弹出的气泡位于view正中上方，可以设置calloutOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
@property (nonatomic) CGPoint calloutOffset;

///默认为YES,当为NO时view忽略触摸事件
@property (nonatomic, getter=isEnabled) BOOL enabled;

///annotationView是否突出显示(一般不需要手动设置)
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

///设置是否处于选中状态, 外部如果要选中请使用mapView的selectAnnotation方法
@property (nonatomic, getter=isSelected) BOOL selected;

///设置是否可以显示callout,默认为NO
@property (nonatomic) BOOL canShowCallout;

///显示在气泡左侧的view
@property (nonatomic, strong) UIView *leftCalloutAccessoryView;

///显示在气泡右侧的view
@property (nonatomic, strong) UIView *rightCalloutAccessoryView;

///是否支持拖动,默认为NO
@property (nonatomic, getter=isDraggable) BOOL draggable;

///当前view的拖动状态
@property (nonatomic) MAAnnotationViewDragState dragState;

/**
 * @brief 初始化并返回一个annotation view
 * @param annotation 关联的annotation对象
 * @param reuseIdentifier 如果要复用view,传入一个字符串,否则设为nil,建议重用view
 * @return 初始化成功则返回annotation view,否则返回nil
 */
- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

/**
 * @brief 当从reuse队列里取出时被调用
 */
- (void)prepareForReuse;

/**
 * @brief 设置是否处于选中状态, 外部如果要选中请使用mapView的selectAnnotation方法
 * @param selected 是否选中
 * @param animated 是否动画设置
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

/**
 * @brief 当前view的拖动状态
 * @param newDragState 要设置的拖放状态
 * @param animated 是否动画设置
 */
- (void)setDragState:(MAAnnotationViewDragState)newDragState animated:(BOOL)animated;

@end

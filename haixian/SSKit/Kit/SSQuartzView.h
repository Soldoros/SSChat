//
//  DEQuartzView.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  针对不同的形状给出参数
 */
typedef NS_ENUM(NSInteger, PolygonViewStyle) {
    /**
     *  三角形
     */
    PolygonViewTrilateral,
    /**
     *  四边形
     */
    PolygonViewQuadrilateral,
    /**
     *  五边形
     */
    PolygonViewPentagon,
    /**
     *  六边形
     */
    PolygonViewHexagon,
    /**
     *  八边形
     */
    PolygonViewOctagon,
    /**
     *  圆形
     */
    PolygonViewCircular,
    /**
     *  椭圆
     */
    PolygonViewEllipse
};

@interface DEQuartzView : UIView
/**
 *  形状的宽和高
 */
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;

/**
 *  形状的颜色
 */
@property(nonatomic,assign)CGFloat R;
@property(nonatomic,assign)CGFloat G;
@property(nonatomic,assign)CGFloat B;

@property(nonatomic,assign)UIColor *polygonColor;
@property(nonatomic,assign)PolygonViewStyle polygonViewStyle;



@end

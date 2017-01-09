//
//  EHItemsView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/11/30.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHTypeDefs.h>

@class EHItemsView;

@protocol EHItemsViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index rowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex inView:(EHItemsView *)view;

@end

@class EHLayout;

@interface EHItemsView : UIView

@property (nonatomic, assign) BOOL allowsAnimationWhenTap;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, copy) void (^animationBlock)(UIView *itemView, NSTimeInterval animationDuration, EHAnimationCompletionBlock animationCompletion);
@property (nonatomic, assign) id<EHItemsViewDelegate> delegate;

@property (nonatomic, strong, readonly) EHLayout *layout;

- (instancetype)initWithItems:(NSArray <UIView *> *)items itemSize:(CGSize)itemSize totalWidth:(CGFloat)totalWidth insets:(UIEdgeInsets)insets minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;

- (instancetype)initWithItems:(NSArray <UIView *> *)items layout:(EHLayout *)layout;

- (void)resetWithItems:(NSArray <UIView *> *)items itemSize:(CGSize)itemSize totalWidth:(CGFloat)totalWidth insets:(UIEdgeInsets)insets minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;

- (void)resetWithItems:(NSArray <UIView *> *)items layout:(EHLayout *)layout;

- (CGFloat)totalHeight;

@end

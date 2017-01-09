//
//  EHItemsSelectionView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/19.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHItemsView.h"
#import <EHItemViewCommon/EHItemViewDelegate.h>
#import <EHItemViewCommon/EHItemViewSelectionDelegate.h>

@interface EHItemsSelectionView : EHItemsView

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) BOOL allowsToCancelWhenSingleSelection;
@property (nonatomic, assign) NSUInteger maxSelectionsAllowed;
@property (nonatomic, assign) id<EHItemsViewDelegate, EHItemViewSelectionDelegate> delegate;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, strong, readonly) NSMutableSet *selectedIndexes;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize totalWidth:(CGFloat)totalWidth insets:(UIEdgeInsets)insets minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHLayout *)layout;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize totalWidth:(CGFloat)totalWidth insets:(UIEdgeInsets)insets minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHLayout *)layout;

- (void)makeIndexSelected:(NSInteger)index;
- (void)makeIndexesSelected:(NSSet <NSNumber *> *)indexes;

@end

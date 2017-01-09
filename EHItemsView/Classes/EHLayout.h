//
//  EHLayout.h
//  WFEDemo
//
//  Created by Eric Huang on 16/11/29.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHLayout : NSObject

@property (nonatomic, assign, readonly) NSInteger numberOfItems;
@property (nonatomic, assign, readonly) CGSize itemSize;

@property (nonatomic, assign, readonly) CGFloat totalWidth;
@property (nonatomic, assign, readonly) UIEdgeInsets insets;

@property (nonatomic, assign, readonly) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign, readonly) CGFloat minimumLineSpacing;

@property (nonatomic, assign, readonly) NSInteger itemsCountPerRow;
@property (nonatomic, assign, readonly) NSInteger numberOfRows;

@property (nonatomic, assign, readonly) CGFloat actualInteritemSpacing;
@property (nonatomic, assign, readonly) CGFloat actualLineSpacing;

- (instancetype)initWithNumberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize totalWidth:(CGFloat)totalWidth insets:(UIEdgeInsets)insets minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;

- (CGFloat)totalHeight;

- (NSInteger)columnIndexForIndex:(NSInteger)index;
- (NSInteger)rowIndexForIndex:(NSInteger)index;

- (CGFloat)xForIndex:(NSInteger)index;
- (CGFloat)yForIndex:(NSInteger)index;

- (NSInteger)columnIndexForLocation:(CGPoint)location;
- (NSInteger)rowIndexForLocation:(CGPoint)location;
- (NSInteger)indexForLocation:(CGPoint)location;

@end

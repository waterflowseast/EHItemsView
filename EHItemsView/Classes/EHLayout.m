//
//  EHLayout.m
//  WFEDemo
//
//  Created by Eric Huang on 16/11/29.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHLayout.h"

@interface EHLayout ()

@property (nonatomic, assign, readwrite) NSInteger numberOfItems;
@property (nonatomic, assign, readwrite) CGSize itemSize;

@property (nonatomic, assign, readwrite) CGFloat totalWidth;
@property (nonatomic, assign, readwrite) UIEdgeInsets insets;

@property (nonatomic, assign, readwrite) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign, readwrite) CGFloat minimumLineSpacing;

@property (nonatomic, assign, readwrite) NSInteger itemsCountPerRow;
@property (nonatomic, assign, readwrite) NSInteger numberOfRows;

@property (nonatomic, assign, readwrite) CGFloat actualInteritemSpacing;
@property (nonatomic, assign, readwrite) CGFloat actualLineSpacing;

@end

@implementation EHLayout

- (instancetype)initWithNumberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize totalWidth:(CGFloat)totalWidth insets:(UIEdgeInsets)insets minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing {
    self = [super init];
    if (self) {
        _numberOfItems = numberOfItems;
        _itemSize = itemSize;
        _totalWidth = totalWidth;
        _insets = insets;
        _minimumInteritemSpacing = minimumInteritemSpacing;
        _minimumLineSpacing = minimumLineSpacing;

        [self calculateValues];
    }
    
    return self;
}

- (CGFloat)totalHeight {
    if (self.numberOfRows == 0) {
        return 0;
    }
    
    return self.insets.top + self.insets.bottom + self.numberOfRows * self.itemSize.height + (self.numberOfRows - 1) * self.actualLineSpacing;
}

- (NSInteger)columnIndexForIndex:(NSInteger)index {
    if (self.numberOfRows == 0) {
        return 0;
    }

    return index % self.itemsCountPerRow;
}

- (NSInteger)rowIndexForIndex:(NSInteger)index {
    if (self.numberOfRows == 0) {
        return 0;
    }

    return index / self.itemsCountPerRow;
}

- (CGFloat)xForIndex:(NSInteger)index {
    NSInteger columnIndex = [self columnIndexForIndex:index];
    return self.insets.left + columnIndex * (self.itemSize.width + self.actualInteritemSpacing);
}

- (CGFloat)yForIndex:(NSInteger)index {
    NSInteger rowIndex = [self rowIndexForIndex:index];
    return self.insets.top + rowIndex * (self.itemSize.height + self.actualLineSpacing);
}

- (NSInteger)columnIndexForLocation:(CGPoint)location {
    if (location.x <= self.insets.left) {
        return -1; // 落在第一个item的左边界之内
    }

    if (location.x >= self.insets.left + self.itemsCountPerRow * self.itemSize.width + (self.itemsCountPerRow - 1) * self.actualInteritemSpacing) {
        return -1; // 落在最后一个item的右边界之外
    }
    
    CGFloat tempWidth = location.x - self.insets.left;
    NSInteger count = (int)floorf(tempWidth / (self.itemSize.width + self.actualInteritemSpacing));
    CGFloat remainingWidth = tempWidth - count * (self.itemSize.width + self.actualInteritemSpacing);
    
    if (remainingWidth >= self.itemSize.width) {
        return -1; // 落在空隙之间
    }
    
    return count;
}

- (NSInteger)rowIndexForLocation:(CGPoint)location {
    if (location.y <= self.insets.top) {
        return -1; // 落在第一个item的上边界之内
    }

    if (location.y >= self.insets.top + self.numberOfRows * self.itemSize.height + (self.numberOfRows - 1) * self.actualLineSpacing) {
        return -1; // 落在最后一个item的下边界之外
    }
    
    CGFloat tempHeight = location.y - self.insets.top;
    NSInteger count = (int)floorf(tempHeight / (self.itemSize.height + self.actualLineSpacing));
    CGFloat remainingHeight = tempHeight - count * (self.itemSize.height + self.actualLineSpacing);
    
    if (remainingHeight >= self.itemSize.height) {
        return -1; // 落在空隙之间
    }
    
    return count;
}

- (NSInteger)indexForLocation:(CGPoint)location {
    NSInteger columnIndex = [self columnIndexForLocation:location];
    NSInteger rowIndex = [self rowIndexForLocation:location];
    
    if (columnIndex < 0 || rowIndex < 0) {
        return -1;
    }

    NSInteger index = rowIndex * self.itemsCountPerRow + columnIndex;

    if (index < self.numberOfItems) {
        return index;
    } else {
        return -1;
    }
}

#pragma mark - private methods

- (void)calculateValues {
    // calculate itemsCountPerRow
    
    // self.insets.left + n * self.itemSize.width + (n - 1) * self.minimumInteritemSpacing + self.insets.right < self.totalWidth
    // n * (self.itemSize.width + self.minimumInteritemSpacing) < self.totalWidth + self.minimumInteritemSpacing - self.insets.left - self.insets.right
    CGFloat widthPerItem = _itemSize.width + _minimumInteritemSpacing;
    if (widthPerItem == 0) {
        _itemsCountPerRow = 0;
    } else {
        CGFloat remainingWidth = _totalWidth + _minimumInteritemSpacing - _insets.left - _insets.right;
        _itemsCountPerRow = (int)floorf(remainingWidth / widthPerItem);
    }
    
    // calculate numberOfRows
    if (_itemsCountPerRow == 0) {
        _numberOfRows = 0;
    } else {
        NSInteger quotient = _numberOfItems / _itemsCountPerRow;
        NSInteger remainder = _numberOfItems % _itemsCountPerRow;
        
        _numberOfRows = remainder == 0 ? quotient : quotient + 1;
    }
    
    // calculate actualInteritemSpacing
    if (_itemsCountPerRow > 1) {
        CGFloat totalSpacing = _totalWidth - _insets.left - _insets.right - _itemsCountPerRow * _itemSize.width;
        _actualInteritemSpacing = totalSpacing / (_itemsCountPerRow - 1);
    } else {
        _actualInteritemSpacing = 0;
    }
    
    // calculate actualLineSpacing
    _actualLineSpacing = _minimumLineSpacing;
}

@end

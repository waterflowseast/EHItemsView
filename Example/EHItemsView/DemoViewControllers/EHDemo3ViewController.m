//
//  EHDemo3ViewController.m
//  EHItemsView
//
//  Created by Eric Huang on 17/1/9.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo3ViewController.h"
#import <Masonry/Masonry.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <EHItemsView/EHItemsView.h>
#import "WFEButtontitleView.h"

static CGFloat const kLabelWidth = 68.0f;
static CGFloat const kLabelHeight = 80.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;
static CGFloat const kMinimumLineSpacing = 12.0f;

@interface EHDemo3ViewController () <EHItemsViewDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) EHItemsView *itemsView;

@end

@implementation EHDemo3ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
    
    [self.view addSubview:self.itemsView];
    [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo([self.itemsView totalHeight]);
    }];
}
    
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
    
#pragma mark - EHItemsViewDelegate
    
- (void)didTapItemAtIndex:(NSInteger)index rowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex inView:(EHItemsView *)view {
    NSLog(@"===> index: %ld, rowIndex: %ld, columnIndex: %ld, word: %@", index, rowIndex, columnIndex, self.words[index]);
}
    
#pragma mark - private methods
    
- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHItemsView View";
}
    
- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
}
    
- (UIColor *)randomColor {
    NSArray *colors = @[
                        [UIColor lightGrayColor],
                        [UIColor grayColor],
                        [UIColor darkGrayColor],
                        [UIColor blackColor]
                        ];
    return colors[arc4random_uniform(4)];
}
    
#pragma mark - getters & setters
    
- (NSArray *)words {
    if (!_words) {
        _words = @[
                   @"照片", @"拍摄", @"小视频", @"视频聊天",
                   @"红包", @"转账", @"位置", @"收藏",
                   @"个人名片", @"语音输入", @"卡券"
                   ];
    }
    
    return _words;
}
    
- (NSArray *)buttons {
    if (!_buttons) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFEButtonTitleView *button = [[WFEButtonTitleView alloc] initWithImage:[UIImage imageNamed:@"down-arrow"] title:self.words[i]];
            
            [mutableArray addObject:button];
        }
        
        _buttons = [mutableArray copy];
    }
    
    return _buttons;
}
    
- (EHItemsView *)itemsView {
    if (!_itemsView) {
        _itemsView = [[EHItemsView alloc] initWithItems:self.buttons itemSize:CGSizeMake(kLabelWidth, kLabelHeight) totalWidth:[UIScreen mainScreen].bounds.size.width insets:UIEdgeInsetsMake(15, 15, 15, 15) minimumInteritemSpacing:kMinimumInteritemSpacing minimumLineSpacing:kMinimumLineSpacing];
        _itemsView.allowsAnimationWhenTap = YES;
        _itemsView.animationDuration = 0.4f;
        _itemsView.delegate = self;
        _itemsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _itemsView;
}
    
@end

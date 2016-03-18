//
//  HotSearchView.m
//  test
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HotSearchView.h"
#import "HotSearchCollectionCell.h"
#import "HotSearchCollectionFlowLayout.h"

@interface HotSearchView ()

@property (nonatomic, strong, readwrite) NSMutableArray *itemWidths;

@end

@implementation HotSearchView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionView *cview = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[HotSearchCollectionFlowLayout alloc] init]];
        cview.backgroundColor = [UIColor whiteColor];
        cview.delegate = self;
        cview.dataSource = self;
        [cview registerNib:[UINib nibWithNibName:@"HotSearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HotSearchCollectionCell"
         ];
        [self addSubview:self.collectionView = cview];
        
        self.itemHeight = 35;
    }
    
    return self;
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray {
    _dataArray = dataArray;
    
    // 异步
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self calculateItemWidthsWith:dataArray];
        
        // 回到主线程显示
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        });
    });
}

- (void)calculateItemWidthsWith:(NSArray *)array {
    _itemWidths = [NSMutableArray array];
    
    CGFloat maxWidth = self.frame.size.width;
    CGFloat sumWidth = 0;
    
    for (int i = 0; i < array.count; i++) {
        CGFloat itemWidth = [array[i] boundingRectWithSize:CGSizeMake(maxWidth, _itemHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.width + 10;
        
        itemWidth = itemWidth > maxWidth ? maxWidth : itemWidth;
        sumWidth += itemWidth;
        
        if (sumWidth > maxWidth && i != 0) {
            // XXX: 在iPhone5下，得减去一点点数值(0.00001)，cell排序才不会乱
            CGFloat subWidth = maxWidth - (sumWidth - itemWidth) - 0.00001;
            
            CGFloat previousItemWidth = [_itemWidths[i - 1] floatValue] + subWidth;
            _itemWidths[i - 1] = [NSString stringWithFormat:@"%f", previousItemWidth];
            
            sumWidth = itemWidth;
        }
        
        [_itemWidths addObject:[NSString stringWithFormat:@"%f", itemWidth]];
    }
}

- (void)insertString:(NSString *)string inDataArrayAtIndex:(NSInteger)index {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:_dataArray];
    [mutableArray insertObject:string atIndex:index];
    _dataArray = mutableArray;
    
    // 异步
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self calculateItemWidthsWith:_dataArray];
        
        // 回到主线程显示
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
        });
    });
}

- (void)removeStringAtIndex:(NSInteger)index {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:_dataArray];
    [mutableArray removeObjectAtIndex:index];
    _dataArray = mutableArray;
    
    // 异步
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self calculateItemWidthsWith:_dataArray];
        
        // 回到主线程显示
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
        });
    });
}

#pragma mark collectionView delegate and datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotSearchCollectionCell" forIndexPath:indexPath];
    
    cell.contentLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([_itemWidths[indexPath.row] floatValue], _itemHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(hotSearchView:didSelectRowAtIndexPath:)]) {
        [_delegate hotSearchView:self didSelectRowAtIndexPath:indexPath];
    }
}

@end

//
//  HotSearchCollectionFlowLayout.m
//  test
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HotSearchCollectionFlowLayout.h"

@implementation HotSearchCollectionFlowLayout

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    
    return attr;
}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    CGRect oldBounds = self.collectionView.bounds;
//    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
//        return YES;
//    }
//    return NO;
//}

@end

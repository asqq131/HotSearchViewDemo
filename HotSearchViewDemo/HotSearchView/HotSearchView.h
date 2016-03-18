//
//  HotSearchView.h
//  test
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotSearchView;
@protocol HotSearchViewDelegate <NSObject>

@optional
- (void)hotSearchView:( HotSearchView * _Nullable )hotSearchView didSelectRowAtIndexPath:(NSIndexPath * _Nullable)indexPath;

@end

@interface HotSearchView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong, nullable) NSArray<NSString *> *dataArray;
@property (nonatomic, strong, readonly, nullable) NSMutableArray *itemWidths;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, weak, nullable) id<HotSearchViewDelegate> delegate;

- (void)insertString:(NSString * _Nullable )string inDataArrayAtIndex:(NSInteger)index;
- (void)removeStringAtIndex:(NSInteger)index;

@end

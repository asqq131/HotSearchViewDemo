//
//  CollectionViewCell.m
//  test
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HotSearchCollectionCell.h"

@implementation HotSearchCollectionCell

- (void)awakeFromNib {
    self.contentLabel.layer.borderWidth = 0.26;
    self.contentLabel.layer.borderColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor;
}

@end

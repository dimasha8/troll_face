//
//  UIImageView+Asset.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/15/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "UIImageView+Asset.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation UIImageView (Asset)

- (id)initWithFrame:(CGRect)frame asset:(ALAsset *)pAsset
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentMode:UIViewContentModeScaleAspectFit];
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        if(pAsset != nil) {
            [self setAsset:pAsset];
        }
    }
    return self;
}

- (void)setAsset:(ALAsset *)pAsset {
    if(pAsset != nil) {
        self.image = [UIImage imageWithCGImage:[[pAsset defaultRepresentation] fullScreenImage]];
    }
}

@end

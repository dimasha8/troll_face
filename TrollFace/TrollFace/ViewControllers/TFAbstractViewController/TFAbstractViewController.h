//
//  TFAbstractViewController.h
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArcTabBarController.h"

@interface TFAbstractViewController : UIViewController

@property(nonatomic, weak) ArcTabBarController *arcTabBar;

@end

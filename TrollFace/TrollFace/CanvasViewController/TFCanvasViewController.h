//
//  TFCanvasViewController.h
//  TrollFace
//
//  Created by Administrator on 10/16/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    canvasLoadTypeEmpty,
    canvasLoadTypePattern,
    canvasLoadTypeWithImage
}canvasLoadType;

@interface TFCanvasViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(canvasLoadType)pType;

@end

//
//  TFCanvasViewController.m
//  TrollFace
//
//  Created by Administrator on 10/16/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFCanvasViewController.h"

@interface TFCanvasViewController ()

@end

@implementation TFCanvasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(canvasLoadType)pType{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        DLog(@"type: %i",pType);
        switch (pType) {
            case canvasLoadTypeEmpty:{
                
            }
                break;
            case canvasLoadTypePattern:{
                
            }
                break;
            case canvasLoadTypeWithImage:{
                
            }
            default:{
                
            }
                break;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

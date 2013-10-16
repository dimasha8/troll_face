//
//  TFCreateMemViewController.m
//  TrollFace
//
//  Created by Administrator on 10/16/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFCreateMemViewController.h"
#import "TFCanvasViewController.h"
#import "TFEmptyMemViewController.h"

@interface TFCreateMemViewController ()

@end

@implementation TFCreateMemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - button handlers

- (IBAction)buttonPressed:(UIButton*)pButton{
    canvasLoadType lType;
    switch (pButton.tag) {
        case 0:{
            lType = canvasLoadTypeEmpty;
            TFEmptyMemViewController *lEmptyMemViewController = [[TFEmptyMemViewController alloc] initWithNibName:@"TFEmptyMemViewController" bundle:nil];
            [self.navigationController pushViewController:lEmptyMemViewController animated:YES];
        }
            break;
        case 1:{
            lType = canvasLoadTypePattern;
        }
            break;
        case 2:{
            lType = canvasLoadTypeWithImage;
        }
            break;
        default:{
            lType = canvasLoadTypeEmpty;
        }
            break;
    }
//    TFCanvasViewController *lCanvasViewController = [[TFCanvasViewController alloc] initWithNibName:@"TFCanvasViewController" bundle:nil type:lType];
//    [self.navigationController pushViewController:lCanvasViewController animated:YES];
}




@end

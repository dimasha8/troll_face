//
//  TFEmptyMemViewController.m
//  TrollFace
//
//  Created by Administrator on 10/16/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFEmptyMemViewController.h"

@interface TFEmptyMemViewController ()

@end

@implementation TFEmptyMemViewController

@synthesize scrollView = mScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [mContainerView setBackgroundColor:[UIColor redColor]];

   
//    mContainerView.center = mScrollView.center;
    [mScrollView setBackgroundColor:[UIColor yellowColor]];
    [mScrollView setContentSize:CGSizeMake(320.0,480.0)];
   
    
    UIPinchGestureRecognizer *lPinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandler:)];
    [mScrollView addGestureRecognizer:lPinchGesture];
    [mScrollView setMaximumZoomScale:2.0];
    [mScrollView setMinimumZoomScale:1.0];
    
    UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(mContainerView.center.x-15, mContainerView.center.y-15.0, 30, 30)];
    [lView setBackgroundColor:[UIColor whiteColor]];
    [mContainerView addSubview:lView];
    
    mScrollView.contentOffset = mScrollView.center;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return mContainerView;
}

- (void)pinchHandler:(UIPinchGestureRecognizer*)pPinch{
    [mScrollView setZoomScale:pPinch.scale animated:YES];
    
//    mScrollView.contentScaleFactor = pPinch.scale;
    DLog(@"scaleFactor:%f",mScrollView.contentScaleFactor);
    DLog(@"pinch: %f",pPinch.scale);
    DLog(@"size: %@",NSStringFromCGSize(mScrollView.contentSize));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

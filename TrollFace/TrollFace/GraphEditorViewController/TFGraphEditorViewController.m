//
//  TFGraphEditor.m
//  TrollFace
//
//  Created by Administrator on 10/9/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFGraphEditorViewController.h"
#import "TFCanvasView.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

typedef enum {
    Pen = 0,

}LoadGraphElements;
@interface TFGraphEditorViewController (){
    BOOL panelsIsOnTheView;
}

@end

@implementation TFGraphEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITapGestureRecognizer * lTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        lTapRecognizer.delegate = self;
        [lTapRecognizer setNumberOfTapsRequired:2];
        [lTapRecognizer setDelaysTouchesBegan:NO];
        [lTapRecognizer setDelaysTouchesEnded:NO];
        [self.view addGestureRecognizer:lTapRecognizer];
        panelsIsOnTheView = NO;
        
        /////put scroll view
        mScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [mScrollView setContentSize:CGSizeMake(2*self.view.bounds.size.width, 2*self.view.bounds.size.height)];
        [mScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
        [mScrollView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
        
        
        CGFloat lMargin = 5.0;
        TFCanvasView *lCanvasView = [[TFCanvasView alloc] initWithFrame:CGRectMake(lMargin, lMargin, SCREEN_SIZE.width-2*lMargin, SCREEN_SIZE.height-5*lMargin)];
        [mScrollView addSubview:lCanvasView];

        
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    DLog(@"left:%@",NSStringFromCGRect(mLeftView.frame));
    DLog(@"right:%@",NSStringFromCGRect(mRightView.frame));
    DLog(@"top:%@",NSStringFromCGRect(mTopView.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - handle double tab gesture
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    DLog(@"handle tap");
    [self showAllViews];
}

- (void)showAllViews{
    [UIView animateWithDuration:0.5 animations:^{
        if (!panelsIsOnTheView) {
            
            mLeftView.alpha = 0.8;
            mLeftView.center = CGPointMake(mLeftView.frame.size.width/2.0, mLeftView.center.y);
            
            mRightView.alpha = 0.8;
            mRightView.center = CGPointMake(SCREEN_SIZE.width-mRightView.frame.size.width/2.0, mRightView.center.y);
            
            mTopView.alpha = 0.8;
            mTopView.center = CGPointMake(mTopView.center.x, 0.0);
            
            panelsIsOnTheView = YES;
        
        }else{
            
            mLeftView.alpha = 0.0;
            mLeftView.center = CGPointMake(-mLeftView.frame.size.width/2.0, mLeftView.center.y);
            
            mRightView.alpha = 0.0;
            mRightView.center = CGPointMake(SCREEN_SIZE.width, mRightView.center.y);
            
            mTopView.alpha = 0.0;
            mTopView.center = CGPointMake(mTopView.center.x, -50.0);
            panelsIsOnTheView = NO;
        }
    }completion:^(BOOL finished){
        DLog(@"Done!");
        DLog(@"left:%@",NSStringFromCGRect(mLeftView.frame));
        DLog(@"right:%@",NSStringFromCGRect(mRightView.frame));
        DLog(@"top:%@",NSStringFromCGRect(mTopView.frame));
    }];
}
#pragma mark - swith buttons

- (IBAction)graphButtonPressed:(UIButton*)pButton{
    switch (pButton.tag) {
        case 0:{
            
        }break;
        
        case 1:{
            
        }break;
        default:
            break;
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
}

@end

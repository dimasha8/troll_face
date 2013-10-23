//
//  TFMainCanvasViewController.m
//  TrollFace
//
//  Created by Administrator on 10/19/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFMainCanvasViewController.h"

@interface TFMainCanvasViewController (){
    BOOL mPanelsIsOnTheView;
}

@end

@implementation TFMainCanvasViewController

#pragma mark - initMethods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initEmptyWithNibName:(NSString *)nibNameOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWithImage:(UIImage *)pImage WithNibName:(NSString *)nibNameOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWithPattern:(UIImage *)pPattern WithNibName:(NSString *)nibNameOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setInterface];
    [self addGestures];
    
    [mBackroundScrollView setContentSize:self.view.bounds.size];
    mPanelsIsOnTheView = NO;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)setInterface{
    [mBackroundScrollView setBackgroundColor:[UIColor grayColor]];
    [mZoomableView setBackgroundColor:[UIColor yellowColor]];
    [mCanvasImageView setBackgroundColor:[UIColor lightGrayColor]];
    [mBottomMenuView setBackgroundColor:[UIColor redColor]];
}

- (void)addGestures{
//    UITapGestureRecognizer *lTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    lTapGesture.delegate = self;
//    [lTapGesture setNumberOfTapsRequired:2];
//    [self.view addGestureRecognizer:lTapGesture];
    
    RNLongPressGestureRecognizer *lLongPressGesture = [[RNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [mBackroundScrollView addGestureRecognizer:lLongPressGesture];

    UIPinchGestureRecognizer *lPinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [mBackroundScrollView addGestureRecognizer:lPinchGesture];
}

- (void)addGridMenuAtPoint:(CGPoint)pPoint{
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithTitle:@"Edit"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithTitle:@"Copy"],
                       [[RNGridMenuItem alloc] initWithTitle:@"Cancel"],
                       [[RNGridMenuItem alloc] initWithTitle:@"Paste"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithTitle:@"Remove"],
                       [RNGridMenuItem emptyItem]
                       ];
    
    RNGridMenu *lGridMenu = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    lGridMenu.delegate = self;
    lGridMenu.menuStyle = RNGridMenuStyleGrid;
    
    lGridMenu.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, lGridMenu.itemSize.width*3, lGridMenu.itemSize.height*3)];
    
    [lGridMenu showInViewController:self center:pPoint];
}
- (void)showCanvasTools:(BOOL)pShow{
    [UIView animateWithDuration:0.5 animations:^{
        
        if (pShow) {
            
            mLeftView.alpha = 0.8;
            mLeftView.center = CGPointMake(mLeftView.frame.size.width/2.0, mLeftView.center.y);
            
            mRightView.alpha = 0.8;
            mRightView.center = CGPointMake(SCREEN_SIZE.width-mRightView.frame.size.width/2.0, mRightView.center.y);
            
            mTopView.alpha = 0.8;
            mTopView.center = CGPointMake(mTopView.center.x, mTopView.bounds.size.height/2.0);
        }else{
            
            mLeftView.alpha = 0.0;
            mLeftView.center = CGPointMake(-mLeftView.frame.size.width/2.0, mLeftView.center.y);
            
            mRightView.alpha = 0.0;
            mRightView.center = CGPointMake(SCREEN_SIZE.width, mRightView.center.y);
            
            mTopView.alpha = 0.0;
            mTopView.center = CGPointMake(mTopView.center.x, -50.0);
        }
    }completion:^(BOOL finished){
        
        DLog(@"left:%@",NSStringFromCGRect(mLeftView.frame));
        DLog(@"right:%@",NSStringFromCGRect(mRightView.frame));
        DLog(@"top:%@",NSStringFromCGRect(mTopView.frame));
    }];

}

#pragma mark - scroll zoomming delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return mZoomableView;
}

#pragma mark - gesture methods

- (void)handleLongPress:(UILongPressGestureRecognizer*)pGesture{
    if (pGesture.state == UIGestureRecognizerStateBegan) {
        DLog(@"handleLongPress");
        [self addGridMenuAtPoint:[pGesture locationInView:self.view]];
    }
}

- (void)handleTap:(UITapGestureRecognizer*)pGesture{
    CGPoint lPoint = [pGesture locationInView:mBottomMenuView];
    
    if ((lPoint.y>0)&&(lPoint.y<20)) {
        DLog(@"asddsdsa");
    }
    DLog(@"handleTap");
}

- (void)handlePinch:(UIPinchGestureRecognizer*)pGesture{

    [mBackroundScrollView setZoomScale:pGesture.scale animated:YES];
//        DLog(@"pinch scale: %f",pGesture.scale);
}
#pragma mark - grid menu delegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex{
    DLog(@"itemIndex:%i ",itemIndex);
    switch (itemIndex) {
        case 1:{//up:edit
            [self editItemPressed];
        }
            break;
        case 3:{//left:copy
            [self copyItemPressed];
        }
            break;
        case 5:{//right:paste
            [self pasteItemPressed];
        }
            break;
        case 7:{//down:remove
            [self removeItemPressed];
        }
            break;
            
        default:{
            
        }
            break;
    }
    
}

#pragma mark - menu item action handlers

- (void)editItemPressed{
    [self showCanvasTools:YES];
}

- (void)copyItemPressed{
    
}

- (void)pasteItemPressed{
    
}

- (void)removeItemPressed{
    
}
#pragma mark - bottom menu handlers
- (IBAction)okButtonPressed:(id)sender{
    
}

- (IBAction)cancelButtonPressed:(id)sender{
    [self showCanvasTools:NO];
}

- (IBAction)handButtonPressed:(id)sender{
    [mBackroundScrollView setScrollEnabled:NO];
}

- (IBAction)hideButtonPressed:(id)sender{
    
}

@end

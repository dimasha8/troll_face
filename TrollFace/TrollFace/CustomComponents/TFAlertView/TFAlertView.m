//
//  TFAlertView.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/12/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#define ALERT_VIEW_WIDTH 300.0f
#define ALERT_VIEW_CORNER_RADIUS 10.0
#define EDGE_INSETS 5.0f
#define BUTTON_HEIGHT 44.0f

#define INFOVIEW_TIMEVISIBLE 3.0

#import "TFAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@implementation TFAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<TFAlertViewDelegare>)delegate rootView:(UIView *)pRootView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if(self = [super initWithFrame:pRootView.bounds]) {
        mDelegate = delegate;
        mRootView = pRootView;
        
        NSMutableArray *lButtons = [[NSMutableArray alloc] initWithObjects:cancelButtonTitle, nil];
        
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
        {
            [lButtons addObject:arg];
        }
        va_end(args);
        
        [self addTitle:title message:message buttons:lButtons];
    }
    
    return self;
}

- (id)initWithMessage:(NSString *)pMessage rootView:(UIView *)pRootView{
    if(self = [super initWithFrame:pRootView.bounds]) {
        mRootView = pRootView;
        [self addTitle:nil message:pMessage buttons:@[@"OK"]];
    }
    return self;
}

- (id)initInfoViewWithInfo:(NSString *)pInfo atLocation:(TFInfoViewLocation)pLocation rootView:(UIView *)pRootView{
    if(self = [super initWithFrame:pRootView.bounds]) {
        mInfoView = YES;
        mInfoViewLocation = pLocation;
        
        mRootView = pRootView;
        [self addTitle:nil message:pInfo buttons:nil];
    }
    return self;
}

#pragma mark - setup GUI
- (void)addTitle:(NSString *)pTitle message:(NSString *)pMessage buttons:(NSArray *)pButtons {
    //init contant view
    mAlertView = [[UIView alloc] init];
    mAlertView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    mAlertView.layer.cornerRadius = ALERT_VIEW_CORNER_RADIUS;
    
    //init local variables
    NSInteger lContentWidth = ALERT_VIEW_WIDTH - (mInfoView?2:EDGE_INSETS) * EDGE_INSETS;
    NSInteger lContentHeight = 0;
    NSInteger lMessageLabelY = EDGE_INSETS;
    
    CGSize lLabelSize;
    
    //init title label
    if(pTitle != nil) {
        UIFont *lTitleFont = [UIFont boldSystemFontOfSize:17.0];
        
        UILabel *lTitle = [[UILabel alloc] init];
        lTitle.font = lTitleFont;
        lTitle.numberOfLines = 0;
        lTitle.backgroundColor = [UIColor clearColor];
        lTitle.textColor = [UIColor whiteColor];
        lTitle.textAlignment = NSTextAlignmentCenter;
        lTitle.text = pTitle;
        
        lLabelSize = [pTitle sizeWithFont:lTitleFont constrainedToSize:CGSizeMake(lContentWidth, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping];
        [lTitle setFrame:CGRectMake(EDGE_INSETS, EDGE_INSETS, lContentWidth, lLabelSize.height)];
        [mAlertView addSubview:lTitle];
        
        lMessageLabelY = CGRectGetMaxY(lTitle.frame) + EDGE_INSETS * 2;
    }
    
    //init message label
    UIFont *lMessageFont = [UIFont systemFontOfSize:15.0];
    
    UILabel *lMessage = [[UILabel alloc] init];
    lMessage.font = lMessageFont;
    lMessage.numberOfLines = 0;
    lMessage.backgroundColor = [UIColor clearColor];
    lMessage.textColor = [UIColor whiteColor];
    lMessage.textAlignment = NSTextAlignmentCenter;
    lMessage.text = pMessage;
    
    lLabelSize = [pMessage sizeWithFont:lMessageFont constrainedToSize:CGSizeMake(lContentWidth, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping];
    [lMessage setFrame:CGRectMake(EDGE_INSETS, lMessageLabelY, lContentWidth, lLabelSize.height)];
    [mAlertView addSubview:lMessage];
    
    //init buttons
    if(pButtons != nil) {
        NSInteger lPreviousY = CGRectGetMaxY(lMessage.frame) + 2 * EDGE_INSETS;
        NSInteger lPreviousX = EDGE_INSETS;
        NSInteger lButtonWidth = pButtons.count == 2?(lContentWidth - 3 * EDGE_INSETS) / 2: lContentWidth - 2 * EDGE_INSETS;
        for (int i = 0; i < pButtons.count; i++) {
            UIButton *lButton = [[UIButton alloc] initWithFrame:CGRectMake(lPreviousX,
                                                                           lPreviousY,
                                                                           lButtonWidth,
                                                                           BUTTON_HEIGHT)];
            lButton.tag = i;
            [lButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [lButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lButton setBackgroundColor:[UIColor clearColor]];
            [lButton setTitle:[pButtons objectAtIndex:i] forState:UIControlStateNormal];
            
            if(pButtons.count > 2) {
                lPreviousY = CGRectGetMaxY(lButton.frame) + EDGE_INSETS;
            } else {
                lPreviousX = CGRectGetMaxX(lButton.frame) + EDGE_INSETS;
            }
            
            if(i == 0) {//set button cancel style
                
            }
            
            [mAlertView addSubview:lButton];
            
            if(i == pButtons.count - 1) {
                lContentHeight = CGRectGetMaxY(lButton.frame) + EDGE_INSETS;
            }
        }
    } else {
        lContentHeight = CGRectGetMaxY(lMessage.frame) + EDGE_INSETS;
    }
    
    //set for content view
    NSInteger lAlertViewY = self.frame.size.height / 2.0 - (lContentHeight + 2 * EDGE_INSETS) / 2.0;
    switch (mInfoViewLocation) {
        case TFLocationBottom:
            lAlertViewY = mRootView.frame.size.height - lContentHeight - EDGE_INSETS * EDGE_INSETS;
            break;
        
        case TFLocationTop:
            lAlertViewY = EDGE_INSETS * EDGE_INSETS;
            break;
            
        default:
            break;
    }
    mAlertView.frame = CGRectMake(self.frame.size.width / 2.0 - ALERT_VIEW_WIDTH / 2.0,
                                  lAlertViewY,
                                  ALERT_VIEW_WIDTH,
                                  lContentHeight);
    [self addSubview:mAlertView];
}

#pragma mark -  Visibility methods
- (void)showAnimating:(BOOL)pAnimating {
    [self setBackgroundColor:[UIColor clearColor]];
    
    mBackGroundView = [[UIView alloc] initWithFrame:mRootView.bounds];
    
    //set blurred background image
    if (!mInfoView) {
        mBackGroundView.layer.contents = (__bridge id)[self blurredImage:[self getBackGroundOfView:mRootView]
                                                               blurLevel:0.3
                                                           exclusionPath:nil].CGImage;
    } else {
        [self performSelector:@selector(hideAnimating:) withObject:[NSNumber numberWithBool:YES] afterDelay:INFOVIEW_TIMEVISIBLE];
    }
    [self addSubview:mBackGroundView];
    
    [mBackGroundView addSubview:mAlertView];
    
    [mRootView addSubview:self];
    if(pAnimating) {
        [self doAnimationShow:YES];
    }
}

- (void)hideAnimating:(BOOL)pAnimating {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1.;
    opacityAnimation.toValue = @0.;
    opacityAnimation.duration = ANIMATION_DURATION;
    [mBackGroundView.layer addAnimation:opacityAnimation forKey:nil];
    
    CATransform3D transform = CATransform3DScale(mAlertView.layer.transform, 0, 0, 0);
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:mAlertView.layer.transform];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:transform];
    scaleAnimation.duration = ANIMATION_DURATION;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[opacityAnimation, scaleAnimation];
    animationGroup.duration = ANIMATION_DURATION;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [mAlertView.layer addAnimation:animationGroup forKey:nil];
    
    mAlertView.layer.transform = transform;
    [self performSelector:@selector(animationDidFinish) withObject:nil afterDelay:ANIMATION_DURATION];
}

- (void)animationDidFinish {
    [self removeFromSuperview];
}

- (void)doAnimationShow:(BOOL)pShow {
    if(pShow) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @0.;
        opacityAnimation.toValue = @1.;
        opacityAnimation.duration = ANIMATION_DURATION * 0.5f;
        
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D startingScale = CATransform3DScale(mAlertView.layer.transform, 0, 0, 0);
        CATransform3D overshootScale = CATransform3DScale(mAlertView.layer.transform, 1.05, 1.05, 1.0);
        CATransform3D undershootScale = CATransform3DScale(mAlertView.layer.transform, 0.98, 0.98, 1.0);
        CATransform3D endingScale = mAlertView.layer.transform;
        
        NSMutableArray *scaleValues = [NSMutableArray arrayWithObject:[NSValue valueWithCATransform3D:startingScale]];
        NSMutableArray *keyTimes = [NSMutableArray arrayWithObject:@0.0f];
        NSMutableArray *timingFunctions = [NSMutableArray arrayWithObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        [scaleValues addObjectsFromArray:@[[NSValue valueWithCATransform3D:overshootScale], [NSValue valueWithCATransform3D:undershootScale]]];
        [keyTimes addObjectsFromArray:@[@0.5f, @0.85f]];
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [scaleValues addObject:[NSValue valueWithCATransform3D:endingScale]];
        [keyTimes addObject:@1.0f];
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        scaleAnimation.values = scaleValues;
        scaleAnimation.keyTimes = keyTimes;
        scaleAnimation.timingFunctions = timingFunctions;
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        animationGroup.duration = ANIMATION_DURATION;
        
        [mAlertView.layer addAnimation:animationGroup forKey:nil];
        
        //set animattion for backGround
        CATransition *transition = [CATransition animation];
        
        transition.duration = ANIMATION_DURATION;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [mBackGroundView.layer addAnimation:transition forKey:nil];
        
    } else {
        
    }
}

#pragma mark - Image settings

- (NSInteger)getdeviceOrientationInDegrees {
    NSInteger lDegrees = 0;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortraitUpsideDown:
            lDegrees = 180;
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            lDegrees = 90;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            lDegrees = 270;
            break;
            
        default:
            break;
    }
    return lDegrees;
}

-(UIImage *)blurredImage:(UIImage *)pImage blurLevel:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = pImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    // create unchanged copy of the area inside the exclusionPath
    UIImage *unblurredImage = nil;
    if (exclusionPath != nil) {
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.frame = (CGRect){CGPointZero, pImage.size};
        maskLayer.backgroundColor = [UIColor blackColor].CGColor;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        maskLayer.path = exclusionPath.CGPath;
        
        // create grayscale image to mask context
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(nil, maskLayer.bounds.size.width, maskLayer.bounds.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        CGContextTranslateCTM(context, 0, maskLayer.bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        [maskLayer renderInContext:context];
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        UIImage *maskImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        
        UIGraphicsBeginImageContext(pImage.size);
        context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, maskLayer.bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        CGContextClipToMask(context, maskLayer.bounds, maskImage.CGImage);
        CGContextDrawImage(context, maskLayer.bounds, pImage.CGImage);
        unblurredImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // overlay images?
    if (unblurredImage != nil) {
        UIGraphicsBeginImageContext(returnImage.size);
        [returnImage drawAtPoint:CGPointZero];
        [unblurredImage drawAtPoint:CGPointZero];
        
        returnImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (UIImage *)getBackGroundOfView:(UIView *)pView {
    UIGraphicsBeginImageContext(pView.frame.size);
    [pView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

#pragma mark - user actions
- (void)buttonPressed:(UIButton *)pSender {
    if(mDelegate != Nil) {
        if([mDelegate respondsToSelector:@selector(alertView:didSelectButtonAtIndex:)]) {
            [mDelegate alertView:self.tag didSelectButtonAtIndex:pSender.tag];
        }
    }
    
    [self hideAnimating:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(mInfoView) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideAnimating:) object:nil];
        [self hideAnimating:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

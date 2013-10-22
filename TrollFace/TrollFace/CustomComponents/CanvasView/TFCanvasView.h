//
//  PaintView.h
//  PaintingSample
//
//  Created by Sean Christmann on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCanvasView : UIView {
    void *cacheBitmap;
    CGContextRef cacheContext;
    float hue;
}
- (BOOL) initContext:(CGSize)size;
- (void) drawToCache:(UITouch*)touch;
@end

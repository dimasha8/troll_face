//
//  PaintView.m
//  PaintingSample
//
//  Created by Sean Christmann on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TFCanvasView.h"

@implementation TFCanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        hue = 0.0;
        
        [self initContext:frame.size];
    }
    return self;
}

- (BOOL) initContext:(CGSize)size {
	
	int bitmapByteCount;
	int	bitmapBytesPerRow;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow = (size.width * 4);
	bitmapByteCount = (bitmapBytesPerRow * size.height);
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	cacheBitmap = malloc( bitmapByteCount );
	if (cacheBitmap == NULL){
		return NO;
	}
	cacheContext = CGBitmapContextCreate (cacheBitmap, size.width, size.height, 8, bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
	return YES;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self drawToCache:touch];
    [self setNeedsDisplay];
}

- (void) drawToCache:(UITouch*)touch {
    hue += 0.005;
    if(hue > 1.0) hue = 0.0;
    UIColor *color = [UIColor colorWithHue:hue saturation:0.7 brightness:1.0 alpha:1.0];
    
    CGContextSetStrokeColorWithColor(cacheContext, [color CGColor]);
    CGContextSetLineCap(cacheContext, kCGLineCapRound);
    CGContextSetLineWidth(cacheContext, 15);
    
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGPoint newPoint = [touch locationInView:self];
    
    CGContextMoveToPoint(cacheContext, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(cacheContext, newPoint.x, newPoint.y);
    CGContextStrokePath(cacheContext);
    
    CGRect dirtyPoint1 = CGRectMake(lastPoint.x-10, lastPoint.y-10, 20, 20);
    CGRect dirtyPoint2 = CGRectMake(newPoint.x-10, newPoint.y-10, 20, 20);
    [self setNeedsDisplayInRect:CGRectUnion(dirtyPoint1, dirtyPoint2)];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef cacheImage = CGBitmapContextCreateImage(cacheContext);
    CGContextDrawImage(context, self.bounds, cacheImage);
    CGImageRelease(cacheImage);
}

@end

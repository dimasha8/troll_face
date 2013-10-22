//
//  TFGraphEditorScrollView.m
//  TrollFace
//
//  Created by Administrator on 10/15/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFGraphEditorScrollView.h"

@implementation TFGraphEditorScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark - scroll handlers

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}


#pragma mark - touch handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
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

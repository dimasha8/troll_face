//
//  Settings.h
//  TrollFace
//
//  Created by dmytro.nosulich on 10/9/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

typedef void(^ComplectionBlok)(NSError *error);

#import <Foundation/Foundation.h>

@interface Settings : NSObject {
    ComplectionBlok savedImageBlok;
}

//this method returns shared instance
+ (Settings *)sharedSettings;

//use this method to save image. Block "finished" can be nil
//pString is path where save image
//if pString = nil image saves to camera roll
- (void)saveImage:(UIImage *)pImage forAlbum:(NSString *)pString finished:(ComplectionBlok)finished;

@end

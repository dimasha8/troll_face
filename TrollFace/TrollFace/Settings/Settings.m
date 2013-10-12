//
//  Settings.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/9/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "Settings.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@implementation Settings

#pragma mark - initial methods
+ (Settings *)sharedSettings {
    static Settings *lSettings = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        lSettings = [[self alloc] init];
    });
    return lSettings;
}

- (id)init {
    if(self = [super init]) {
        //init code
    }
    
    return self;
}

#pragma mark - Publick methods
- (void)saveImage:(UIImage *)pImage forAlbum:(NSString *)pString finished:(ComplectionBlok)finished {
    if(pImage != nil) {
        ALAssetsLibrary *lLibrary = [[ALAssetsLibrary alloc] init];
        [lLibrary writeImageToSavedPhotosAlbum:pImage.CGImage orientation:(ALAssetOrientation)pImage.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
            DLog(@"writeImageToSavedPhotosAlbum  error: %@", error);
            if (error == nil) {
                ALAssetsLibrary *lLibraryForAddURLs = [[ALAssetsLibrary alloc] init];
                if(pString != nil) {//save image to path pString. Else it will be saved to camera roll
                    [lLibraryForAddURLs addAssetURL:assetURL toAlbum:pString withCompletionBlock:^(NSError *error) {
                        DLog(@"addAssetURL error: %@", error);
                        if(finished != nil) {
                            finished(error);
                        }
                    }];
                }
            } else {
                if(finished != nil) {
                    finished(error);
                }
            }
        }];
    }
}

@end

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
#pragma mark - Work with images ALAssetsLibrary
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

- (void)getListOfPhotosInGroup:(NSString *)pGtoup complitionBlock:(void(^)(NSError *error, NSArray *imagesPath))pBlock {
    __block NSMutableArray *lPathes = nil;
    //find Album
    ALAssetsLibrary *lLibrary = [[ALAssetsLibrary alloc] init];
    [lLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:pGtoup]) {
                lPathes = [NSMutableArray new];
                //get images pathes
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if(result != nil) {
                        [lPathes addObject:[UIImage imageWithCGImage:[[result defaultRepresentation] fullScreenImage]]];
                    }
                }];
                
                *stop = YES;
            }
        } else {
            pBlock(nil, lPathes);
        }
    } failureBlock:^(NSError *error) {
        pBlock(error, lPathes);
        DLog(@"error enumerateGroupsWithTypes: %@", error);
    }];
}


@end

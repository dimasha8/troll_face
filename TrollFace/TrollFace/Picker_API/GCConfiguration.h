//
//  GCConfiguration.h
//  PhotoPickerPlus-SampleApp
//
//  Created by Aleksandar Trpeski on 8/10/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCOAuth2Client.h"

@class GCAccount;

@interface GCConfiguration : NSObject


/**
 Array used for storing services.
*/
@property (strong, nonatomic) NSArray           *services;

/**
 Array used for storing local services.
 */
@property (strong, nonatomic) NSArray           *localFeatures;

/**
 Dictionary containing all data needed for authentication.
 */
@property (strong, nonatomic) NSDictionary      *oauthData;

/**
 MutableArray used to store logged accounts.
 */
@property (strong, nonatomic) NSMutableArray    *accounts;

/**
 Setting for loading UIImagePickerControllerOriginalImage for assets from web.
 */
@property (assign, nonatomic) BOOL              loadAssetsFromWeb;

///--------------------------------
/// @name Creating Singleton object
///--------------------------------

/**
 Creates a singleton object for the configuration.
 */
+ (GCConfiguration *) configuration;

///------------------------
/// @name Adding an account
///------------------------

/**
 Adding an account to an array. It is used for bigger controll for which account is already logged in.
 
 @param account The account that needs to be added to logged accounts.
 
 @warning This method requires `GCAccount` class. Add an `#import "GCAccount.h"` in your header/implementation file.  
*/

- (void)addAccount:(GCAccount *)account;

- (void)removeAllAccounts;

- (GCLoginType)loginTypeForString:(NSString *)serviceString;

- (NSString *)loginTypeString:(GCLoginType)loginType;


@end

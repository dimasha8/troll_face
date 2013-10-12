//
//  Global.h
//  DiplomaWork
//
//  Created by Roman.Bekas on 25.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//AppDelegate
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define PHOTO_ALBUM @"Troll friends"

#ifndef Global_h
#define Global_h

//debugging
#ifdef DEBUG 
# define DLog(...) NSLog(__VA_ARGS__) 
#else 
# define DLog(...) /* */
#endif 
#define ALog(...) NSLog(__VA_ARGS__)

#define SafeRelease(var_name) if (var_name != nil) [var_name release]; var_name = nil;

//device info
#define IPHONE @"iPhone"
#define IPAD @"iPad"

#define isDeviceIpad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

//Getting is device IOS5
CG_INLINE BOOL isIOS5()
{
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
		return TRUE;
	else
		return FALSE;
}

//Getting device name
CG_INLINE NSString *deviceType()
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if( UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM() )
		return IPAD;
	else
		return IPHONE;
#else
	return IPHONE;
#endif
}

#endif

//other useful things
#define degreesToRadians(x) ((x) * M_PI / 180.0)


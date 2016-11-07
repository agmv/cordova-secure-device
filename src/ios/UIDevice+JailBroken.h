
//
//  JailbreakDetection.h
//  Copyright (c) 2016 André Vieira
//  Adapted from Lee Crossley - http://ilee.co.uk
//

#import <UIKit/UIKit.h>

@interface UIDevice (JailBroken) 

	/**
	 *  Checks and returns the devices jail broken status
	 */
	@property (readonly) BOOL isJailBroken;

@end
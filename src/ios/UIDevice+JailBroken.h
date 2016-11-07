//
//  UIDevice+JailBroken.h
//  JailBroken
//
//  Created by André Vieira on 06/11/2016.
//  Copyright (c) 2016 André Vieira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (JailBroken) 

	/**
	 *  Checks and returns the devices jail broken status
	 */
	@property (readonly) BOOL isJailBroken;

@end
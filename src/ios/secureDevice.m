/********* cordova-secure-device.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Cordova/CDVViewController.h>
#import "secureDevice.h"
#import "UIDevice+PasscodeStatus.h"
#import	"UIDevice+JailBroken.h"

@implementation secureDevice

- (void)pluginInitialize
{
	BOOL jailbroken = [UIDevice currentDevice].isJailBroken;
	LNPasscodeStatus status = [UIDevice currentDevice].passcodeStatus;

	if (jailbroken || status == LNPasscodeStatusDisabled || status == LNPasscodeStatusUnknown) {
		//Remove webView
		[self.webView removeFromSuperview];

		//Show alert dialog and close app
		NSBundle *thisBundle = [NSBundle bundleWithPath: [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType: @"bundle"]];
		NSString *alertMessage = [thisBundle localizedStringForKey:@"This application does not run on a device that is jailbroken or does not have a passcode set." value:nil table:nil];
		NSString *alertCloseButtonText = [thisBundle localizedStringForKey:@"Close" value:nil table:nil];
		
		dispatch_async( dispatch_get_main_queue(), ^ {
			[self showAlert:alertMessage closeLabel:alertCloseButtonText];
		});		
	}
}

/*
 * showAlert - Common method to instantiate the alert view for alert
 * Parameters:
 *  message       The alert view message.
 *  closeLabel    The label for the close button
 */
- (void)showAlert:(NSString*)message closeLabel:(NSString*)closeLabel
{
    
#ifdef __IPHONE_8_0
    if (NSClassFromString(@"UIAlertController")) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.3) {
            
            CGRect alertFrame = [UIScreen mainScreen].applicationFrame;
            
            if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
                // swap the values for the app frame since it is now in landscape
                CGFloat temp = alertFrame.size.width;
                alertFrame.size.width = alertFrame.size.height;
                alertFrame.size.height = temp;
            }
            
            alertController.view.frame =  alertFrame;
        }
        
        [alertController addAction:[UIAlertAction actionWithTitle:closeLabel
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
        {
           exit(0); 
        }]];
        
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
#endif

        UIAlertView* alertView = [[UIAlertView alloc]
                                   initWithTitle:nil
                                   message:message
                                   delegate:self
                                   cancelButtonTitle:nil
                                   otherButtonTitles:nil];
                        
        [alertView addButtonWithTitle:closeLabel];
                
        [alertView show];
#ifdef __IPHONE_8_0
    }
#endif
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	exit(0);
}

@end

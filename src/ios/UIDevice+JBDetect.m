//  UIDevice+JBDetect.m
//  Copyright (c) 2018 André Vieira
//  Adapted from

//
//  JBDetect.m
//  JailbreakDetection
//
//  Created by Augusta Bogie on 2/13/16.
//  Copyright © 2016 Augusta Bogie. All rights reserved.
//

#import "UIDevice+JBDetect.h"
#include <sys/stat.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation UIDevice (JBDetect)

- (BOOL)isJB
{
    
#if !TARGET_IPHONE_SIMULATOR
    
    //Apps and System check list
    NSString *isJB=@"76f6243716d4029726022224a43796220237960256d616e40247365746f627050237968645";NSMutableString *a=[NSMutableString new];while([isJB length]!=[a length]){NSRange range=NSMakeRange([isJB length]-[a length]-1,1);[a appendString:[isJB substringWithRange:range]];}NSMutableString *b=[[NSMutableString alloc]init];int c=0;while(c<[a length]){ NSString *d = [a substringWithRange:NSMakeRange(c,2)];int e=0;sscanf([d cStringUsingEncoding:NSASCIIStringEncoding],"%x",&e);[b appendFormat:@"%c",(char)e];c+=2;}
    
    NSLog(@"%@", b);
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"va",@"r/l",@"og/s",@"yslog"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"private/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"private/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"private/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"private/va",@"r/l",@"og/s",@"yslog"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"bi",@"n/b",@"ash"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"b",@"in/",@"sh"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"private/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"private/etc/s",@"sh/s",@"shd_config"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"etc/s",@"sh/s",@"shd_config"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]]
        || [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.masbog.com"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Snoop-it", @" Config.a", @"pp"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"Library/MobileS", @"ubstrate/Dy",@"nami", @"cLi", @"braries/", @" xCon.", @"dylib"]]
        || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"priv",@"ate/etc/dpkg/",@"origins/debian"]])
        
    {
        return YES;
    }
    
    // SandBox Integrity Check
    int pid = fork();
    if(!pid){
        exit(0);
    }
    if(pid>=0)
    {
        return YES;
    }
    
    //Symbolic link verification
    struct stat s;
    if(lstat("/Applications", &s) || lstat("/var/stash/Library/Ringtones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
       || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s) || lstat("/var/stash/usr/arm-apple-darwin9", &s))
    {
        if(s.st_mode & S_IFLNK){
            return YES;
        }
    }
    
    //Try to write file in private
    NSError *error;
    
    FILE *f = NULL ;
    if ((f = fopen("/bin/bash", "r")) ||
        (f = fopen("/bin/sh", "r")) ||
        (f = fopen("/Applications/Cydia.app", "r")) ||
        (f = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r")) ||
        (f = fopen("/usr/sbin/sshd", "r")) ||
        (f = fopen("/etc/apt", "r")))  {
        fclose(f);
        return YES;
    }
    fclose(f);
    
    NSString *stringToBeWritten = @"Hello, MasBog Here!!!";
    [stringToBeWritten writeToFile:@"/private/masbog.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:@"/private/masbog.txt" error:nil];
    if(error == nil)
    {
        return YES;
    }
    
    NSArray *blah = [NSArray arrayWithObjects:@"f28637164737f2271667f2", @"f28637164737f2271667f256471667962707f2", @"f28637164737f22646f2271667f256471667962707f2", nil];
    NSMutableString *hihi = [NSMutableString new];
    
    while ([blah[0] length]!=[hihi length]) {
        NSRange range = NSMakeRange([blah[0] length]-[hihi length]-1, 1);
        [hihi appendString: [blah[0] substringWithRange:range]];
    }
    
    NSMutableString *haha = [[NSMutableString alloc] init];
    int i = 0;
    while (i < [hihi length])
    {
        NSString *hehe = [hihi substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hehe cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [haha appendFormat:@"%c", (char)value];
        i+=2;
    }
    
    NSArray *hahaList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:haha error:nil];
    if (hahaList.count > 0) {
        for (NSString *fufufufu in hahaList){
            if (![fufufufu containsString:@"lnk"]) {
                NSArray *hahaListSub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@%@/DynamicLibraries", haha, fufufufu] error:nil];
                for (NSString *wkwkwkwk in hahaListSub){
                    if ([wkwkwkwk containsString:@".dylib"] || [wkwkwkwk containsString:@".plist"]) {
                        return YES;
                    }
                }
            }
        }
    }
    
    //============== array index 1 ===========//
    hihi = [NSMutableString new];
    while ([blah[1] length]!=[hihi length]) {
        NSRange range = NSMakeRange([blah[1] length]-[hihi length]-1, 1);
        [hihi appendString: [blah[1] substringWithRange:range]];
    }
    
    haha = [[NSMutableString alloc] init];
    i = 0;
    while (i < [hihi length])
    {
        NSString *hehe = [hihi substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hehe cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [haha appendFormat:@"%c", (char)value];
        i+=2;
    }
    
    hahaList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:haha error:nil];
    if (hahaList.count > 0) {
        for (NSString *fufufufu in hahaList){
            if (![fufufufu containsString:@"lnk"]) {
                NSArray *hahaListSub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@%@/DynamicLibraries", haha, fufufufu] error:nil];
                for (NSString *wkwkwkwk in hahaListSub){
                    if ([wkwkwkwk containsString:@".dylib"] || [wkwkwkwk containsString:@".plist"]) {
                        return YES;
                    }
                }
            }
        }
    }
    
    
    //============== array index 2 ===========//
    hihi = [NSMutableString new];
    while ([blah[2] length]!=[hihi length]) {
        NSRange range = NSMakeRange([blah[2] length]-[hihi length]-1, 1);
        [hihi appendString: [blah[2] substringWithRange:range]];
    }
    
    haha = [[NSMutableString alloc] init];
    i = 0;
    while (i < [hihi length])
    {
        NSString *hehe = [hihi substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hehe cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [haha appendFormat:@"%c", (char)value];
        i+=2;
    }
    
    hahaList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:haha error:nil];
    if (hahaList.count > 0) {
        for (NSString *fufufufu in hahaList){
            if (![fufufufu containsString:@"lnk"]) {
                NSArray *hahaListSub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@%@/DynamicLibraries", haha, fufufufu] error:nil];
                for (NSString *wkwkwkwk in hahaListSub){
                    if ([wkwkwkwk containsString:@".dylib"] || [wkwkwkwk containsString:@".plist"]) {
                        return YES;
                    }
                }
            }
        }
    }
#endif
    return NO;
}

@end
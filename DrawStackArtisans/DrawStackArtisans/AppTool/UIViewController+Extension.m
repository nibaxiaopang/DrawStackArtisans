//
//  UIViewController+Extension.m
//  DrawStackArtisans
//
//  Created by DrawStackArtisans on 2024/10/18.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (NSString *)drawMainHostName
{
    return @"n.vqyxmdsolh.top";
}

- (BOOL)needShowBannerDescView
{
    BOOL isI = [[UIDevice.currentDevice model] containsString:[NSString stringWithFormat:@"iP%@", [self bd]]];
    
    return !isI;
}

- (NSString *)bd
{
    return @"ad";
}

@end

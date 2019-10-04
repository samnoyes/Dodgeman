//
//  ViewController.m
//  DodgeManII
//
//  Created by Sam Noyes on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end



@implementation ViewController

@synthesize banner, bannerIsVisible;

/*
- (void) bannerView:(ADBannerView *)aBanner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.hidden = YES;
        //banner.frame = CGRectMake(0.0, 100000.0,banner.frame.size.width,banner.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

- (void) bannerViewDidLoadAd:(ADBannerView *)aBanner
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0.0, 50.0);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Yo");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end

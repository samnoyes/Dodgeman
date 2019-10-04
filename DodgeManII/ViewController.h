//
//  ViewController.h
//  DodgeManII
//
//  Created by Sam Noyes on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADBannerViewDelegate>{
    ADBannerView *banner;
    BOOL bannerIsVisible;
    IBOutlet UITextView *thanks;
}
@property (nonatomic, assign)BOOL bannerIsVisible;
@property (nonatomic, retain)IBOutlet ADBannerView *banner;

@end

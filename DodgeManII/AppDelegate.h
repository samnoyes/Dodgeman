//
//  AppDelegate.h
//  DodgeManII
//
//  Created by Sam Noyes on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
}
@property (strong, nonatomic) NSMutableString *pausedString;
@property (strong, nonatomic) NSMutableString *countdownPausedString;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) bool soundPlaying;

@end

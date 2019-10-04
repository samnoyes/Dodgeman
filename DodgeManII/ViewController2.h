//
//  ViewController2.h
//  DodgeManII
//
//  Created by Sam Noyes on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//   #######        ###         ###           ###
// ##              ## ##        ## ##       ## ##
// ##             ##   ##       ##   ##   ##   ##
//   #######     #########      ##    ## ##    ##
//         ##   ##       ##     ##     ###     ##
//         ##  ##         ##    ##      #      ##
//  ########  ##           ##   ##             ##


#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <time.h>
#import <AVFoundation/AVFoundation.h>

#define SNOWFLAKESMOVEPIXELS 2.5//Number of pixels snowflakes move at a time
#define STICKMOVE 5//Number of pixels stickman moves at a time
#define ICEMOVE 7.5//Number of pixels icicles move at a time
#define GAMETIMER .025//How fast stickman and others are refreshed
#define ICICLETIMER .025//How fast icicles are refreshed
#define CENTER_X 160//For accelerometer, not in use
#define CENTER_Y 240//For accelerometer, not in use
#define SNOWFLAKESMOVETIMER .025//How fast snowflakes fall
#define NEWSNOWFLAKESPEED 1//How fast new snowflakes are made

@interface ViewController2 : UIViewController <ADBannerViewDelegate>{
    int countdownInt;
    IBOutlet UIImageView *leftArrow;
    IBOutlet UIImageView *rightArrow;
    BOOL inCountdown;
    NSTimer *countdownTimer;
    IBOutlet UILabel *countdown;
    IBOutlet UIImageView *blackBar;
    ADBannerView *banner;
    BOOL bannerIsVisible;
    NSURL *url;
    IBOutlet UIButton *startButton;
    //AVAudioPlayer *whoosh;
    NSTimer *x2Timer;
    NSTimer *snowflakeFrenzyTimer;
    IBOutlet UILabel *x2Label;
    IBOutlet UILabel *snowflakeFrenzyLabel;
    int countForGOW, snowflakeCount, soundInt;
    int countForX2, inGameHelp;
    int countForX3, intForUse, snowflakeFrenzyGameOver;
    int snowflakeFrenzyCount;
    bool inPlus5, snowflakeFallHelp, snowflakeFrenzyGameOverHelp, inGame, soundPlaying;
    NSTimer *closeCallTimer, *gameOverWait;
    IBOutlet UILabel *closeCall;
    NSMutableString *highscoreString;
    IBOutlet UILabel *highscoreLabelMain;
    NSMutableString *boolTestHelp;
    NSMutableString *snowflakeFrenzyString;
    IBOutlet UILabel *boolTest;
    IBOutlet UIButton *restart;
    int j, firstGo;
    IBOutlet UIButton *infoMainMenuButton;
    IBOutlet UIButton *PauseBut;
    IBOutlet UIButton *resetButton;
    BOOL x3Bool, x2Bool, plus20Bool, plus100Bool, snowflakea, snowflakea2, snowflakea3, snowflakea4, snowflakea5, snowflakea6, snowflakea7, paused, easya, mediuma, experta, snowflakeFrenzy, soundBool, soundPlayingHelp;
    
    NSTimer *plusTwentyTimer;
    NSTimer *plus100Timer;
    IBOutlet UIImageView *snowflake;
    IBOutlet UIImageView *snowflake2;
    IBOutlet UIImageView *snowflake3;
    IBOutlet UIImageView *snowflake4;
    IBOutlet UIImageView *snowflake5;
    IBOutlet UIImageView *snowflake6;
    IBOutlet UIImageView *snowflake7;
    IBOutlet UIImageView *arrow;
    NSTimer *snowflakeTimer;
    int _highscore;
    NSMutableString *highscoreHelp2;
    IBOutlet UILabel *highscoreNum;
    int score;
    int tdbghighscore;
    IBOutlet UIButton *mainMenu;
    
    IBOutlet UIButton *resumeBut;
    NSTimer *snowflakesMove;
    NSTimer *plusFiveTimer, *times2, *times3;
    bool iciclea, iciclea2, iciclea3, iciclea4,iciclea5,iciclea6,iciclea7,iciclea8, iciclea9, iciclea10, iciclea11, iciclea12, goingRightLast, goingLeftLast;
    int count;
    int x;
    int k;
    int boolHelp;
    NSMutableString *scoreString;
    NSMutableString *highscoreHelp;
    
    NSTimer *gameTimer;
    
    NSTimer *gameTimer2;
    NSTimer *gameTimer3;
    NSTimer *gameTimer5;
    NSTimer *gameTimer4;
    BOOL goingLeft, goingRight, first, easy, medium, expert, gameOverForCC;
    
    IBOutlet UIImageView *closeCallIV;
    IBOutlet UILabel *highscoreText;
    IBOutlet UILabel *difficulty;
    IBOutlet UIImageView *stickmanHelp;
    IBOutlet UIImageView *stickman;
    IBOutlet UIImageView *icicle;
    IBOutlet UIImageView *help2;
    IBOutlet UIImageView *helpLeft;
    IBOutlet UIImageView *helpRight;
    NSTimer *icicleGoTimer;
    NSTimer *icicleMoveTimer;
    IBOutlet UIImageView *icicle2;
    
    IBOutlet UIImageView *icicle3;
    
    IBOutlet UIImageView *icicle4;
    IBOutlet UILabel *snowflakeFrenzyDisplayLabel;
    IBOutlet UIImageView *icicle5;
    
    IBOutlet UIImageView *icicle6;
    IBOutlet UIImageView *icicle7;
    NSTimer *snowflakeFrenzyDisplayTimer;
    IBOutlet UIImageView *icicle8;
    IBOutlet UIImageView *icicle9;
    IBOutlet UIImageView *icicle10;
    IBOutlet UIImageView *icicle11;
    IBOutlet UIImageView *linedPaper;
    int xxx;
    bool snowflakeFrenzyHelp;
    IBOutlet UIImageView *icicle12;
    IBOutlet UIButton *leftButton;
    
    int infoInt;
    
    IBOutlet UILabel *pointsLabelSF;
    IBOutlet UILabel *scorelabel;
    IBOutlet UIButton *rightButton;
    IBOutlet UILabel *gameOver;
    NSMutableString *pausedString;
    NSString *pausedStringHelp;
    IBOutlet UILabel *test;
    IBOutlet UILabel *infoText;
    int countX2;
    int countCloseCall;
    bool resetHelp, whiteOn, cyanOn, redOn, greenOn, yellowOn, GOWBool, doneGameOver;
    IBOutlet UIImageView *easyCheck;
    IBOutlet UIImageView *mediumCheck;
    IBOutlet UIImageView *expertCheck;
    IBOutlet UISwitch *sound;
    IBOutlet UIButton *easyBut;
    int asdf;
}
@property (nonatomic, assign)BOOL bannerIsVisible;
@property (nonatomic, retain)IBOutlet ADBannerView *banner;
@property (strong, nonatomic) AVAudioPlayer *whoosh;
- (IBAction)sound:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)easyBut:(id)sender;
- (IBAction)MediumBut:(id)sender;
- (IBAction)expertBut:(id)sender;
- (IBAction)moveStick:(id)sender;
- (IBAction)buttonReleased:(id)sender;
- (IBAction)starting:(id)sender;
- (IBAction)white:(id)sender;
- (IBAction)cyan:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;
- (IBAction)red:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)yellow:(id)sender;

- (void) plusCountdown;
- (void) fixHelpFrames;
- (void) x2Function;
- (void) gameOverWaitExec;
- (void) snowflakeFall;
- (void) snowflakeGo;
- (void) gameUpdate;    
- (void) gameOver;
- (void) count;
- (void) closeCallDo;
- (void) icicleGo;
- (void) icicleMove;
- (void) setDifficulty;
- (void) x2;
- (void) x3;
- (void) snowflakeFrenzyFunction;
- (void) snowflakeFrenzyDisplay;

@end

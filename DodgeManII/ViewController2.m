//
//  ViewController2.m
//  DodgeManII
//
//  Created by Sam Noyes on 7/21/12.
//  Copyright (c) 2012 Sam Murphy. All rights reserved.
//
//
//
//   #######        ###         ###           ###
// ##              ## ##        ## ##       ## ##
// ##             ##   ##       ##   ##   ##   ##
//   #######     #########      ##    ## ##    ##
//         ##   ##       ##     ##     ###     ##
//         ##  ##         ##    ##      #      ##
//  ########  ##           ##   ##             ##
//*****************************************************
//If pages are changed 13 times after changing difficulty, difficulty is remembered
//In-Call bar messes things up - stickman is squished

#import "ViewController2.h"
#import "ViewController.h"
//#import "ViewController.m"
#import "AppDelegate.h"
#import <iAd/iAd.h>

@interface ViewController2()
@end


@implementation ViewController2


@synthesize whoosh;

@synthesize banner, bannerIsVisible;

- (void)viewWillLoad {
    //your standard code
    //if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"] == nil) {
             //The app is being launched for the first time. Push view2.
        //ViewController *viewController = [[ViewController alloc] init];
    NSLog(@"In application DFL");
        //[self presentViewController:viewController animated:YES completion:nil];
    
             //set a NSNumber object with a BOOL value of NO with the key
             //@\"isFirstLaunch\" in NSUserDefaults.
             //The value really doesn't matter since we are checking
             //whether the objects exists to determine first launch
             //but just set it NO to be clean.
         //}
}

- (void) bannerView:(ADBannerView *)aBanner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        PauseBut.frame = CGRectMake(245, 0, 75, 40);
        NSLog(@"In didFailToReceiveAdWithError");
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        aBanner.frame = CGRectOffset(banner.frame, 0, 50.0f);
        aBanner.hidden = YES;
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

- (void) bannerViewDidLoadAd:(ADBannerView *)aBanner
{
    if (!self.bannerIsVisible)
    {
        PauseBut.frame = CGRectMake(245, 50, 75, 40);
        NSLog(@"In bannerViewDidLoadAd");
        aBanner.hidden = NO;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        aBanner.frame = CGRectOffset(aBanner.frame, 0, -50.0f);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    paused = YES;
    PauseBut.hidden = YES;
    NSLog(@"Loaded Action");
    return YES;
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}

/*
static highscore* _sharedhighscore = nil;
+(highscore*)sharedhighscore
{
	@synchronized([highscore class])
	{
		if (!_sharedhighscore)
			[[self alloc] init];
        
		return _sharedhighscore;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([highscore class])
	{
		NSAssert(_sharedhighscore == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedhighscore = [super alloc];
		return _sharedhighscore;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
    
	return self;
}
*/


//*********************************************************************************************************************************

 
//*********************************************************************************************************************************
 
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//****************************************************
/*
- (void) accelerometer: (UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float xx = acceleration.x/100;
    float yy = acceleration.y/100;
    float zz = acceleration.z/100;
    
    stickman.center = CGPointMake(CENTER_X + CENTER_X * xx, stickman.center.y);
}
*/
//****************************************************
- (void)plusCountdown
{
    PauseBut.hidden = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    countdownInt ++;
    if (countdownInt == 1)
    {
        
        if ([appDelegate.countdownPausedString isEqual: @"paused"])
        {
            //appDelegate.pausedString = @"not paused";
            paused = YES;
            countdown.hidden = YES;
            [countdownTimer invalidate];
            countdownTimer = nil;
            mainMenu.hidden = NO;
            resumeBut.hidden = NO;
            PauseBut.hidden = YES;
            restart.hidden = NO;
            closeCall.text = @"Paused";
        }
       countdown.text = @"2";
    }
    else if (countdownInt == 2)
    {
        if ([appDelegate.countdownPausedString isEqual: @"paused"])
        {
            closeCall.text = @"Paused";
            //appDelegate.pausedString = @"not paused";
            paused = YES;
            countdown.hidden = YES;
            [countdownTimer invalidate];
            countdownTimer = nil;
            mainMenu.hidden = NO;
            PauseBut.hidden = YES;
            resumeBut.hidden = NO;
            restart.hidden = NO;
        }
        countdown.text = @"1";
    }
    else if (countdownInt == 3)
    {
        if ([appDelegate.countdownPausedString isEqual: @"paused"])
        {
            //appDelegate.pausedString = @"not paused";
            paused = YES;
            countdown.hidden = YES;
            [countdownTimer invalidate];
            countdownTimer = nil;
            mainMenu.hidden = NO;
            resumeBut.hidden = NO;
            restart.hidden = NO;
            PauseBut.hidden = YES;
            closeCall.text = @"Paused";
        }
        else
        {
            countdown.hidden = YES;
            paused = NO;
            inCountdown = NO;
            [countdownTimer invalidate];
            countdownTimer = nil;
            [appDelegate.pausedString setString: (@"not paused")];
            [appDelegate.countdownPausedString setString: (@"not paused")];
            if (!gameOverForCC)
            {
                PauseBut.hidden = NO;
            }
        }
    }
}
-(void) presentSecondViewControllerFromViewController:(UIViewController *)sourceController
{
    UIStoryboard* secondStoryboard = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
    UIViewController* secondViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"second_viewcontroller"];
    
    [sourceController presentViewController: secondViewController animated:YES completion: NULL];
}

- (void)changeView
{
    ViewController *viewController = [[ViewController alloc]init];
    [self presentViewController:viewController animated: YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button has been clicked");
    if (buttonIndex ==0)
    {
        NSLog(@"Nope");
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"Yup");
        
        //UIViewController *viewController = [[UIViewController alloc]init];
        //[self presentViewController:viewController animated: YES completion:nil];
        //[viewController.view setBackgroundColor:[UIColor whiteColor]];
        //UITextField *text;
        //text = [[UITextField alloc] initWithFrame:CGRectMake(10,100,300,30)];
        //[viewController.view addSubview:text];
        //[self performSegueWithIdentifier: @"goToInfo" sender: self];
        //ViewController* infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerInfo"];
        //[self.navigationController pushViewController:infoController animated:YES];
        NSString * storyboardName = @"MainStoryboard";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerInfo"];
        [self presentViewController:vc animated:YES completion:nil];
        NSLog(@"Creating text");
    }
}

//****************************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    asdf = 1;
    //[self changeView];
    //UIStoryboard* secondStoryboard = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
    //UIViewController* secondViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"second_viewcontroller"];
    //ViewController *viewController = [[ViewController alloc]init];
    //[self presentViewController:viewController animated: YES completion:nil];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"] == nil) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions"message:@"It appears this is your first time using this app.  Would you like to view the instructions?"delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
        //arrow.image = [UIImage imageNamed:@"Arrow.png"];
     [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"isFirstLaunch"];
    }
    leftArrow.image = [UIImage imageNamed:@"left_arrow.png"];
    rightArrow.image = [UIImage imageNamed:@"right_arrow.png"];
    //PauseBut.frame = CGRectMake(245, 20, 75, 40);
    //blackBar.image = [UIImage imageNamed:@"blackBar.png"];
    countdown.text = @"3";
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:.8 target:self selector:@selector (plusCountdown) userInfo:nil repeats:YES];
    banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    banner.frame = CGRectOffset(banner.frame, 0, 50.0f);
    banner.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview: banner];
    banner.delegate = self;
    PauseBut.frame = CGRectMake(245, 0, 75, 40);
/*
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectOffset(adView.frame, 0, -50);
    [self.view addSubview:adView];
    adView.delegate = self;
    self.bannerIsVisible = NO;
*/
    //NSLog(@"In viewDidLoad");
    //Bool initiations
    banner.hidden = YES;
    bannerIsVisible = NO;
        snowflakeFrenzy = NO;
        snowflakeFallHelp = NO;
        snowflakeFrenzyDisplayLabel.hidden = YES;
        snowflakeFrenzyHelp = NO;
        pointsLabelSF.hidden = YES;
        snowflakeFrenzyLabel.hidden = YES;
        x2Bool = NO;
        x3Bool = NO;
        goingRight = NO;
        doneGameOver = NO;
        GOWBool = NO;
        x2Label.hidden = YES;
        gameOverForCC = NO;
        iciclea = NO;
        iciclea2 = NO;
        iciclea3 = NO;
        iciclea4 = NO;
        iciclea5 = NO;
        iciclea6 = NO;
        iciclea7 = NO;
        iciclea8 = NO;
        iciclea9 = NO;
        PauseBut.hidden = YES;
        restart.hidden = YES;
        mainMenu.hidden = YES;
        resumeBut.hidden = YES;
        goingRightLast = YES;
        paused = YES;
        inCountdown = YES;
    //*********************************************************
    //Int initiations
        k = 0;
        firstGo = 0;//Makes the stickman move 3 pixels to the right so that it will refresh the image.
        snowflakeFrenzyCount = 0;
        countX2 = 0;
        countCloseCall = 0;
        score = 0;
        count = 0;
        intForUse = 0;
        snowflakeFrenzyGameOver = 0;
        countdownInt = 0;
    /*
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"whoosh" withExtension:@"wav"];
    NSError *error;
    whoosh = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:  &error];
    if (error != nil)
    {
        NSLog(@"Whoosh sound could not be loaded");
    }
    else {
        [whoosh prepareToPlay];
    }
     */

    inGameHelp = [[NSUserDefaults standardUserDefaults] boolForKey:@"inGameHelpDefault"];
    if (inGameHelp != 123) //should initiate inGame only once
    {
        inGame = NO;
        [[NSUserDefaults standardUserDefaults] setBool: inGame forKey: @"inGameDefault"];
        inGameHelp = 123;
        [[NSUserDefaults standardUserDefaults] setInteger: inGameHelp forKey: @"inGameHelpDefault"];
    }
    else
    {
        inGame = [[NSUserDefaults standardUserDefaults] boolForKey:@"inGameDefault"];
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    linedPaper.image = [UIImage imageNamed:@"Lined paper copy.png"];
    stickman.image = [UIImage imageNamed:@"StickManRightNew.png"];
    CGPoint oldCenter = stickman.center;
    stickman.center = CGPointMake(oldCenter.x+STICKMOVE, oldCenter.y);
    CGPoint oldCenter2 = stickman.center;
    stickman.center = CGPointMake(oldCenter2.x-STICKMOVE, oldCenter2.y);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%@", appDelegate.pausedString);
    [appDelegate.pausedString setString: (@"not paused")];
    [appDelegate.countdownPausedString setString: (@"not paused")];
    countForGOW = 0;
    /*
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [[UIAccelerometer sharedAccelerometer]setUpdateInterval:.033];
     */
    /*
    whiteOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"whiteDefault"];
    yellowOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"yellowDefault"];
    redOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"redDefault"];
    cyanOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"cyanDefault"];
    greenOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"greenDefault"];
     */
    //NSLog(@"In ViewDidLoad");
    closeCall.text = @" ";
    _highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
    highscoreString = [[NSMutableString alloc] initWithString:@"Highscore: 0"];
    snowflakeFrenzyString = [[NSMutableString alloc] initWithString:@"0"];
    boolTestHelp = [[NSMutableString alloc] initWithString:@"0"];
    /*
    if (cyanOn)
    {
        [self.view setBackgroundColor:[UIColor cyanColor]];
    }
    
    else if (redOn)
    {
        [self.view setBackgroundColor:[UIColor orangeColor]];
        
    }
    
    else if (greenOn)
    {
        [self.view setBackgroundColor:[UIColor greenColor]];
    }
    else if (yellowOn)
    {
        [self.view setBackgroundColor:[UIColor yellowColor]];
    }
    else if (whiteOn)
    {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
    }
    else if (!whiteOn&&!yellowOn&&!greenOn&&!cyanOn&&!redOn)
    {
        whiteOn = YES;
        [[NSUserDefaults standardUserDefaults] setInteger: redOn forKey: @"redDefault"];
        [[NSUserDefaults standardUserDefaults] setInteger: yellowOn forKey: @"yellowDefault"];
        [[NSUserDefaults standardUserDefaults] setInteger: cyanOn forKey: @"cyanDefault"];
        [[NSUserDefaults standardUserDefaults] setInteger: greenOn forKey: @"greenDefault"];
        [[NSUserDefaults standardUserDefaults] setInteger: whiteOn forKey: @"whiteDefault"];
    }
     */
    scoreString = [[NSMutableString alloc]initWithString:@"Score : 0"];
    highscoreHelp2 = [[NSMutableString alloc]initWithString:@"Highscore: 0"];
    
    stickman.image = [UIImage imageNamed:@"StickManRightNew.png"];
    
    [highscoreString setString:[NSString stringWithFormat:@"Highscore : %d",_highscore]];
    
    highscoreLabelMain.text = highscoreString;

    easya = [[NSUserDefaults standardUserDefaults] boolForKey:@"easyUserDefault"];
    mediuma = [[NSUserDefaults standardUserDefaults] boolForKey:@"mediumUserDefault"];
    experta = [[NSUserDefaults standardUserDefaults] boolForKey:@"expertUserDefault"];  
    boolHelp = [[NSUserDefaults standardUserDefaults] integerForKey:@"saveBoolHelp"];
    [boolTestHelp setString:[NSString stringWithFormat:@"%d", boolHelp]];
    if (boolHelp != 123)//Only does once
    {
        NSLog(@"In BoolHelp if");
        boolHelp = 123;
        [[NSUserDefaults standardUserDefaults] setInteger:boolHelp forKey: @"saveBoolHelp"];
        easya = NO;
        mediuma = NO;
        experta = NO;
        soundBool = YES;
        [[NSUserDefaults standardUserDefaults] setBool: soundBool forKey: @"soundCondition"];
    }
    [self setDifficulty];
    soundPlayingHelp = [[NSUserDefaults standardUserDefaults] integerForKey:@"soundPlayingHelp"];
    if (soundPlayingHelp != 123)
    {
        appDelegate.soundPlaying = NO;
        [[NSUserDefaults standardUserDefaults] setBool: appDelegate.soundPlaying forKey: @"soundPlaying"];
        soundPlayingHelp = 123;
        [[NSUserDefaults standardUserDefaults] setInteger: soundPlayingHelp forKey: @"soundPlayingHelp"];
        soundBool = YES;
        [[NSUserDefaults standardUserDefaults] setBool: soundBool forKey: @"soundCondition"];
    }
    
    soundPlaying = [[NSUserDefaults standardUserDefaults] boolForKey:@"soundPlaying"];
    soundBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"soundCondition"];
    /*
    if (soundBool)
    {
        sound.on = YES;
    }
    else
    {
        sound.on = NO;
    }
     */
    if (soundBool && !appDelegate.soundPlaying)
    {
        url = [NSURL fileURLWithPath:[NSString stringWithFormat: @"%@/whoosh2.mp3", [[NSBundle mainBundle] resourcePath]]];
        NSError *error;
        whoosh  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [whoosh play];
        whoosh.numberOfLoops = -1;
        appDelegate.soundPlaying = YES;
        [[NSUserDefaults standardUserDefaults] setBool: appDelegate.soundPlaying forKey: @"soundPlaying"];
    }
    if (soundPlaying)
    {
        NSLog(@"soundPlaying = YES");
    }
    else
    {
        NSLog(@"soundPlaying = NO");
    }
}

//****************************************************
//****************************************************
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    /*
    [super didReceiveMemoryWarning];
    NSLog(@"In didRecieveMemoryWarning");
    url = nil;
    banner = nil;
    [banner removeFromSuperview];
    error = nil;
    startButton = nil;
    [startButton removeFromSuperview];
    x2Timer = nil;
    snowflakeFrenzyDisplayTimer = nil;
    inPlus5 = nil;
    snowflakeFallHelp = nil;
    snowflakeFrenzyGameOverHelp = nil;
    inGame = nil;
    soundPlaying = nil;
    closeCallTimer = nil; gameOverWait = nil;
    closeCall = nil;
    highscoreString = nil;
    highscoreLabelMain = nil;
    boolTestHelp = nil;
    snowflakeFrenzyString = nil;
    boolTest = nil;
    restart = nil;
    [restart removeFromSuperview];
    infoMainMenuButton = nil;
    [infoMainMenuButton removeFromSuperview];
    PauseBut = nil;
    [PauseBut removeFromSuperview];
    resetButton = nil;
    [resetButton removeFromSuperview];
    plusTwentyTimer = nil;
    plus100Timer = nil;
    snowflakeTimer = nil;
    mainMenu = nil;
    [mainMenu removeFromSuperview];
    resumeBut = nil;
    [resumeBut removeFromSuperview];
    snowflakesMove = nil;
    plusFiveTimer = nil;  times2 = nil; times3 = nil;
    iciclea = nil; iciclea2 = nil; iciclea3 = nil; iciclea4 = nil;iciclea5 = nil;iciclea6 = nil;iciclea7 = nil;iciclea8 = nil; iciclea9 = nil; iciclea10 = nil; iciclea11 = nil; iciclea12 = nil; goingRightLast = nil; goingLeftLast = nil;
    scoreString = nil;
    highscoreHelp = nil;
    gameTimer = nil;
    
    gameTimer2 = nil;
    gameTimer3 = nil;
    gameTimer5 = nil;
    gameTimer4 = nil;
    
    closeCallIV = nil;
    [closeCallIV removeFromSuperview];
    highscoreText = nil;
    [highscoreText removeFromSuperview];
    difficulty = nil;
    [difficulty removeFromSuperview];
    stickmanHelp = nil;
    [stickmanHelp removeFromSuperview];
    stickman = nil;
    [stickman removeFromSuperview];
    icicle = nil;
    [icicle removeFromSuperview];
    help2 = nil;
    [help2 removeFromSuperview];
    helpLeft = nil;
    [helpLeft removeFromSuperview];
    helpRight = nil;
    [helpRight removeFromSuperview];
    icicleGoTimer = nil;
    icicleMoveTimer = nil;
    icicle2 = nil;
    [icicle2 removeFromSuperview];
    icicle3 = nil;
    [icicle3 removeFromSuperview];
    icicle4 = nil;
    [icicle4 removeFromSuperview];
    snowflakeFrenzyDisplayLabel = nil;
    [snowflakeFrenzyDisplayLabel removeFromSuperview];
    icicle5 = nil;
    [icicle5 removeFromSuperview];
    snowflakeFrenzyHelp = nil;
    leftButton = nil;
    [leftButton removeFromSuperview];
    
    pointsLabelSF = nil;
    [pointsLabelSF removeFromSuperview];
    scorelabel = nil;
    [scorelabel removeFromSuperview];
    rightButton = nil;
    [rightButton removeFromSuperview];
    gameOver = nil;
    [gameOver removeFromSuperview];
    pausedString = nil;
    pausedStringHelp = nil;
    test = nil;
    resetHelp = nil; whiteOn = nil; cyanOn = nil; redOn = nil; greenOn = nil; yellowOn = nil; GOWBool = nil; doneGameOver = nil;
    easyCheck = nil;
    [easyCheck removeFromSuperview];
    mediumCheck = nil;
    [mediumCheck removeFromSuperview];
    expertCheck = nil;
    [expertCheck removeFromSuperview];
    sound = nil;
    easyBut = nil;
    [easyBut removeFromSuperview];
    icicle11 = nil;
    [icicle11 removeFromSuperview];
    icicle12 = nil;
    [icicle12 removeFromSuperview];
    x2Label = nil;
    [x2Label removeFromSuperview];
    pointsLabelSF = nil;
    [pointsLabelSF removeFromSuperview];
    boolTest = nil;
    resetButton = nil;
    [resetButton removeFromSuperview];
    snowflake = nil;
    [snowflake removeFromSuperview];
    snowflake2 = nil;
    [snowflake2 removeFromSuperview];
    snowflake3 = nil;
    [snowflake3 removeFromSuperview];
    snowflake4 = nil;
    [snowflake4 removeFromSuperview];
    snowflake5 = nil;
    snowflake6 = nil;
    snowflake7 = nil;
    highscoreNum = nil;
    mainMenu = nil;
    resumeBut = nil;
    closeCall = nil;
    highscoreText = nil;
    difficulty = nil;
    stickmanHelp = nil;
    stickman = nil;
    icicle = nil;
    help2 = nil;
    helpLeft = nil;
    helpRight = nil;
    icicle3 = nil;
    icicle2 = nil;
    icicle4 = nil;
    icicle5 = nil;
    snowflakeFrenzyDisplayLabel = nil;
    icicle6 = nil;
    icicle7 = nil;
    icicle8 = nil;
    icicle9 = nil;
    icicle10 = nil;
    icicle11 = nil;
    linedPaper = nil;
    icicle12 = nil;
    leftButton = nil;
    pointsLabelSF = nil;
    scorelabel = nil;
    rightButton = nil;
    gameOver = nil;
    test = nil;
    easyCheck = nil;
    mediumCheck = nil;
    expertCheck = nil;
    sound = nil;
    easyBut = nil;
    // Relinquish ownership any cached data, images, etc that aren't in use.
    */
}
//****************************************************
//****************************************************

- (void)dealloc {
///*
     [super didReceiveMemoryWarning];
     NSLog(@"In dealloc");
     url = nil;
     banner = nil;
     [banner removeFromSuperview];
     startButton = nil;
     [startButton removeFromSuperview];
     x2Timer = nil;
     snowflakeFrenzyDisplayTimer = nil;
     inPlus5 = nil;
     snowflakeFallHelp = nil;
     snowflakeFrenzyGameOverHelp = nil;
     inGame = nil;
     soundPlaying = nil;
     closeCallTimer = nil; gameOverWait = nil;
     closeCall = nil;
     highscoreString = nil;
     highscoreLabelMain = nil;
     boolTestHelp = nil;
     snowflakeFrenzyString = nil;
     boolTest = nil;
     restart = nil;
     [restart removeFromSuperview];
     infoMainMenuButton = nil;
     [infoMainMenuButton removeFromSuperview];
     PauseBut = nil;
     [PauseBut removeFromSuperview];
     resetButton = nil;
     [resetButton removeFromSuperview];
     plusTwentyTimer = nil;
     plus100Timer = nil;
     snowflakeTimer = nil;
     mainMenu = nil;
     [mainMenu removeFromSuperview];
     resumeBut = nil;
     [resumeBut removeFromSuperview];
     snowflakesMove = nil;
     plusFiveTimer = nil;  times2 = nil; times3 = nil;
     iciclea = nil; iciclea2 = nil; iciclea3 = nil; iciclea4 = nil;iciclea5 = nil;iciclea6 = nil;iciclea7 = nil;iciclea8 = nil; iciclea9 = nil; iciclea10 = nil; iciclea11 = nil; iciclea12 = nil; goingRightLast = nil; goingLeftLast = nil;
     scoreString = nil;
     highscoreHelp = nil;
     gameTimer = nil;
     
     gameTimer2 = nil;
     gameTimer3 = nil;
     gameTimer5 = nil;
     gameTimer4 = nil;
     
     closeCallIV = nil;
     [closeCallIV removeFromSuperview];
     highscoreText = nil;
     [highscoreText removeFromSuperview];
     difficulty = nil;
     [difficulty removeFromSuperview];
     stickmanHelp = nil;
     [stickmanHelp removeFromSuperview];
     stickman = nil;
     [stickman removeFromSuperview];
     icicle = nil;
     [icicle removeFromSuperview];
     help2 = nil;
     [help2 removeFromSuperview];
     helpLeft = nil;
     [helpLeft removeFromSuperview];
     helpRight = nil;
     [helpRight removeFromSuperview];
     icicleGoTimer = nil;
     icicleMoveTimer = nil;
     icicle2 = nil;
     [icicle2 removeFromSuperview];
     icicle3 = nil;
     [icicle3 removeFromSuperview];
     icicle4 = nil;
     [icicle4 removeFromSuperview];
     snowflakeFrenzyDisplayLabel = nil;
     [snowflakeFrenzyDisplayLabel removeFromSuperview];
     icicle5 = nil;
     [icicle5 removeFromSuperview];
     snowflakeFrenzyHelp = nil;
     leftButton = nil;
     [leftButton removeFromSuperview];
     
     pointsLabelSF = nil;
     [pointsLabelSF removeFromSuperview];
     scorelabel = nil;
     [scorelabel removeFromSuperview];
     rightButton = nil;
     [rightButton removeFromSuperview];
     gameOver = nil;
     [gameOver removeFromSuperview];
     pausedString = nil;
     pausedStringHelp = nil;
     test = nil;
     resetHelp = nil; whiteOn = nil; cyanOn = nil; redOn = nil; greenOn = nil; yellowOn = nil; GOWBool = nil; doneGameOver = nil;
     easyCheck = nil;
     [easyCheck removeFromSuperview];
     mediumCheck = nil;
     [mediumCheck removeFromSuperview];
     expertCheck = nil;
     [expertCheck removeFromSuperview];
     sound = nil;
     easyBut = nil;
     [easyBut removeFromSuperview];
     icicle11 = nil;
     [icicle11 removeFromSuperview];
     icicle12 = nil;
     [icicle12 removeFromSuperview];
     x2Label = nil;
     [x2Label removeFromSuperview];
     pointsLabelSF = nil;
     [pointsLabelSF removeFromSuperview];
     boolTest = nil;
     resetButton = nil;
     [resetButton removeFromSuperview];
     snowflake = nil;
     [snowflake removeFromSuperview];
     snowflake2 = nil;
     [snowflake2 removeFromSuperview];
     snowflake3 = nil;
     [snowflake3 removeFromSuperview];
     snowflake4 = nil;
     [snowflake4 removeFromSuperview];
     snowflake5 = nil;
     snowflake6 = nil;
     snowflake7 = nil;
     highscoreNum = nil;
     mainMenu = nil;
     resumeBut = nil;
     closeCall = nil;
     highscoreText = nil;
     difficulty = nil;
     stickmanHelp = nil;
     stickman = nil;
     icicle = nil;
     help2 = nil;
     helpLeft = nil;
     helpRight = nil;
     icicle3 = nil;
     icicle2 = nil;
     icicle4 = nil;
     icicle5 = nil;
     snowflakeFrenzyDisplayLabel = nil;
     icicle6 = nil;
     icicle7 = nil;
     icicle8 = nil;
     icicle9 = nil;
     icicle10 = nil;
     icicle11 = nil;
     linedPaper = nil;
     icicle12 = nil;
     leftButton = nil;
     pointsLabelSF = nil;
     scorelabel = nil;
     rightButton = nil;
     gameOver = nil;
     test = nil;
     easyCheck = nil;
     mediumCheck = nil;
     expertCheck = nil;
     sound = nil;
     easyBut = nil;
    //*/
}

//***************************************************


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//****************************************************
- (void) setDifficulty
{
    //NSLog(@"In myViewDidLoad");
    easya = [[NSUserDefaults standardUserDefaults] boolForKey:@"easyUserDefault"];
    mediuma = [[NSUserDefaults standardUserDefaults] boolForKey:@"mediumUserDefault"];
    experta = [[NSUserDefaults standardUserDefaults] boolForKey:@"expertUserDefault"];
    
    
    boolHelp = [[NSUserDefaults standardUserDefaults] integerForKey:@"saveBoolHelp"];
    if (easya && !mediuma && !experta && boolHelp == 123)
    {
        easyCheck.image = [UIImage imageNamed:@"check copy.png"];
        mediumCheck.image = [UIImage imageNamed:@"blank.png"];
        expertCheck.image = [UIImage imageNamed:@"blank.png"];
    }
    else if (experta && !mediuma && !easya && boolHelp == 123)
    {
        expertCheck.image = [UIImage imageNamed:@"check copy.png"];
        mediumCheck.image = [UIImage imageNamed:@"blank.png"];
        easyCheck.image = [UIImage imageNamed:@"blank.png"];
    }
    else 
    {
        mediumCheck.image = [UIImage imageNamed:@"check copy.png"];
        easyCheck.image = [UIImage imageNamed:@"blank.png"];
        expertCheck.image = [UIImage imageNamed:@"blank.png"];
    }
    if (easya && !mediuma && !experta && boolHelp == 123)
    {
        //PauseBut.hidden = NO;
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector (gameUpdate) userInfo:nil repeats:YES];
        
        
        snowflakesMove = [NSTimer scheduledTimerWithTimeInterval:SNOWFLAKESMOVETIMER target:self selector:@selector (snowflakeFall) userInfo:nil repeats:YES];
        snowflakeTimer = [NSTimer scheduledTimerWithTimeInterval:NEWSNOWFLAKESPEED target:self selector:@selector (snowflakeGo) userInfo:nil repeats:YES];
        icicleGoTimer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (icicleGo) userInfo:nil repeats:YES];
        
        icicleMoveTimer = [NSTimer scheduledTimerWithTimeInterval:ICICLETIMER target:self selector:@selector (icicleMove) userInfo:nil repeats:YES];
        
        gameTimer2 = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector (count) userInfo:nil repeats:YES];
        difficulty.hidden = YES;
        
    }
    else if (experta && !mediuma && !easya && boolHelp == 123)
    {
        //PauseBut.hidden = NO;
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector (gameUpdate) userInfo:nil repeats:YES];
        
        snowflakeTimer = [NSTimer scheduledTimerWithTimeInterval:NEWSNOWFLAKESPEED target:self selector:@selector (snowflakeGo) userInfo:nil repeats:YES];
        
        snowflakesMove = [NSTimer scheduledTimerWithTimeInterval:SNOWFLAKESMOVETIMER target:self selector:@selector (snowflakeFall) userInfo:nil repeats:YES];
        
        icicleGoTimer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (icicleGo) userInfo:nil repeats:YES];
        
        icicleMoveTimer = [NSTimer scheduledTimerWithTimeInterval:ICICLETIMER target:self selector:@selector (icicleMove) userInfo:nil repeats:YES];
        
        gameTimer5 = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector (count) userInfo:nil repeats:YES]; 
        difficulty.hidden = YES;
    }
    else
    {
        //PauseBut.hidden = NO;
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector (gameUpdate) userInfo:nil repeats:YES]; 
        
        snowflakeTimer = [NSTimer scheduledTimerWithTimeInterval:NEWSNOWFLAKESPEED target:self selector:@selector (snowflakeGo) userInfo:nil repeats:YES];
        
        snowflakesMove = [NSTimer scheduledTimerWithTimeInterval:SNOWFLAKESMOVETIMER target:self selector:@selector (snowflakeFall) userInfo:nil repeats:YES];
        icicleGoTimer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (icicleGo) userInfo:nil repeats:YES];
        
        icicleMoveTimer = [NSTimer scheduledTimerWithTimeInterval:ICICLETIMER target:self selector:@selector (icicleMove) userInfo:nil repeats:YES];
        
        gameTimer4 = [NSTimer scheduledTimerWithTimeInterval:.35 target:self selector:@selector (count) userInfo:nil repeats:YES];
        difficulty.hidden = YES;
    }
    return;
}
//****************************************************

- (IBAction)reset:(id)sender {
    _highscore = 0;
    [[NSUserDefaults standardUserDefaults] setInteger: _highscore forKey: @"highscore"];
    highscoreLabelMain.text = @"Highscore: 0";
}

//****************************************************

- (IBAction)startAction:(UIButton *)sender {
    [banner removeFromSuperview];
    banner = nil;
    inGame = YES;
    [[NSUserDefaults standardUserDefaults] setBool: inGame forKey: @"inGameDefault"];
}

- (IBAction)settingsHit:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}

- (IBAction)resetHighscoreHit:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}
- (IBAction)cancelResetHighscoreHit:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}
- (IBAction)mainMenuHitInfo:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}

- (IBAction)infoHit:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}

- (IBAction)resetHIghscoreHitII:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}

- (IBAction)mainMenuSettingsHit:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}

- (IBAction)restartHit:(id)sender {
    [banner removeFromSuperview];
    banner = nil;
}

- (IBAction)mainMenuClicked:(UIButton *)sender {
    [banner removeFromSuperview];
    banner = nil;
    NSLog(@"In mainMenuClicked");
    inGame = NO;
    [[NSUserDefaults standardUserDefaults] setBool: inGame forKey: @"inGameDefault"];
}


//****************************************************
- (IBAction)easyBut:(id)sender {
    easyCheck.image = [UIImage imageNamed:@"check copy.png"];// Won't remember difficulty after app is stopped
    
    mediumCheck.image = [UIImage imageNamed:@"blank.png"];
    expertCheck.image = [UIImage imageNamed:@"blank.png"];
    easya = YES;
    mediuma = NO;
    experta = NO;
    [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"easyUserDefault"];
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"mediumUserDefault"];
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"expertUserDefault"];
    boolHelp = 123;
    [[NSUserDefaults standardUserDefaults] setInteger: 123 forKey: @"saveBoolHelp"];
    //NSLog(@"Saving...");
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//****************************************************
- (IBAction)MediumBut:(id)sender {
    mediumCheck.image = [UIImage imageNamed:@"check copy.png"];
    easyCheck.image = [UIImage imageNamed:@"blank.png"];
    expertCheck.image = [UIImage imageNamed:@"blank.png"];
    easya = NO;
    mediuma = YES;
    experta = NO;
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"easyUserDefault"];
    [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"mediumUserDefault"];
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"expertUserDefault"];
    boolHelp = 123;
    [[NSUserDefaults standardUserDefaults] setInteger: 123 forKey: @"saveBoolHelp"];
    //NSLog(@"Saving...");
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//****************************************************
- (IBAction)expertBut:(id)sender {
    expertCheck.image = [UIImage imageNamed:@"check copy.png"];
    mediumCheck.image = [UIImage imageNamed:@"blank.png"];
    easyCheck.image = [UIImage imageNamed:@"blank.png"];
    easya = NO;
    mediuma = NO;
    experta = YES;
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"easyUserDefault"];
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"mediumUserDefault"];
    [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"expertUserDefault"];
    boolHelp = 123;
    [[NSUserDefaults standardUserDefaults] setInteger: 123 forKey: @"saveBoolHelp"];
    //NSLog(@"Saving...");
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//****************************************************
- (IBAction)moveStick:(id)sender
{
    UIButton *buttonPressed = (UIButton*) sender;
    if (buttonPressed == rightButton)
    {
        goingLeftLast = NO;
        goingRightLast = YES;
        goingRight = YES;
    }
    if (buttonPressed == leftButton)
    {
        goingLeftLast = YES;
        goingRightLast = NO;
        goingLeft = YES;
    }
    
}
/****************************************************

- (IBAction)sound:(UISwitch *)sender {
    url = [NSURL fileURLWithPath:[NSString stringWithFormat: @"%@/whoosh2.mp3", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    whoosh  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

    if (sound.on){
        
        [whoosh play];
        whoosh.numberOfLoops = -1;
            soundBool = YES;
        
            [[NSUserDefaults standardUserDefaults] setBool: soundBool forKey: @"soundCondition"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.soundPlaying = YES;
        [[NSUserDefaults standardUserDefaults] setBool: appDelegate.soundPlaying forKey: @"soundPlaying"];
        if (appDelegate.soundPlaying)
        {
            NSLog(@"soundPlaying = YES");
        }
        else
        {
            NSLog(@"soundPLaying = NO");
        }
    }
    
    else if (!sound.on)
    {
        [whoosh stop];
        soundBool = NO;
        [[NSUserDefaults standardUserDefaults] setBool: soundBool forKey: @"soundCondition"];
        NSLog(@"Stopping");
        NSLog(@"%@", whoosh);
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.soundPlaying = NO;
        [[NSUserDefaults standardUserDefaults] setBool: appDelegate.soundPlaying forKey: @"soundPlaying"];
        if (appDelegate.soundPlaying)
        {
            NSLog(@"soundPlaying = YES");
        }
        else
        {
            NSLog(@"soundPLaying = NO");
        }
    }
}
*/
//****************************************************
- (IBAction)buttonReleased:(id)sender;
{
    goingRight = NO;
    goingLeft = NO;
}

//****************************************************
- (IBAction)starting:(id)sender {

}

//****************************************************
- (IBAction)white:(id)sender {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    redOn = NO;
    yellowOn = NO;
    cyanOn = NO;
    greenOn = NO;
    whiteOn = YES;
    [[NSUserDefaults standardUserDefaults] setInteger: redOn forKey: @"redDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: yellowOn forKey: @"yellowDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: cyanOn forKey: @"cyanDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: greenOn forKey: @"greenDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: whiteOn forKey: @"whiteDefault"];
}

//****************************************************
- (IBAction)cyan:(id)sender {
    [self.view setBackgroundColor:[UIColor cyanColor]];
    redOn = NO;
    yellowOn = NO;
    cyanOn = YES;
    greenOn = NO;
    whiteOn = NO;
    [[NSUserDefaults standardUserDefaults] setInteger: redOn forKey: @"redDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: yellowOn forKey: @"yellowDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: cyanOn forKey: @"cyanDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: greenOn forKey: @"greenDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: whiteOn forKey: @"whiteDefault"];
}

//****************************************************
- (void) fixHelpFrames
{
    /*
     Things to move:
     stickmanHelp
     help2
     helpRight
     helpLeft
     closeCallIV
     */
    /*
    if (goingLeftLast)
    {
    help2.image = [UIImage imageNamed: @"800px-Auto_Racing_Plain_Blue copy.png"];
        //helpLeft.image = [UIImage imageNamed: @"800px-Auto_Racing_Plain_Blue copy.png"];
        stickmanHelp.image = [UIImage imageNamed: @"blank.png"];
        //helpRight.image = [UIImage imageNamed: @"blank.png"];
    }
    if (goingRightLast)
    {
    stickmanHelp.image = [UIImage imageNamed: @"800px-Auto_Racing_Plain_Blue copy.png"];
    //helpRight.image = [UIImage imageNamed: @"800px-Auto_Racing_Plain_Blue copy.png"];
        
        help2.image = [UIImage imageNamed: @"blank.png"];
        //helpLeft.image = [UIImage imageNamed: @"blank.png"];
    }
    */
    stickmanHelp.center = CGPointMake(stickman.center.x+8.5, stickman.center.y-1);
    
    helpRight.center = CGPointMake(stickman.center.x+8, stickman.center.y+10);
    
    help2.center = CGPointMake(stickman.center.x+1.5, stickman.center.y-1);
    
    helpLeft.center = CGPointMake(stickman.center.x+2, stickman.center.y+10);
    
    closeCallIV.center = CGPointMake(stickman.center.x, stickman.center.y);
    return;
}
//****************************************************
- (void) closeCallDo
{
    countCloseCall++;
    if (countCloseCall == 25)
    {
        if (x3Bool)
        {
            score+=15;
        }
        else if (x2Bool)
        {
            score+=10;
        }
        else
        {
            score+=5;
        }
        [self count];
    }
    if (countCloseCall >=25 && countCloseCall < 120 && !gameOverForCC && !paused)
    {
        closeCall.text = @"Close Call!";
    }
    else if (countCloseCall >= 100)
    {
        countCloseCall = 0;
        if (!paused)
            closeCall.text = @" ";
        [closeCallTimer invalidate];
        closeCallTimer = nil;
    }
    return;
}

//****************************************************
- (IBAction)pause:(id)sender {
    paused = YES;
    PauseBut.hidden = YES;
}

//****************************************************
- (IBAction)resume:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.pausedString = @"not paused";
    [appDelegate.countdownPausedString setString: (@"not paused")];
    closeCall.text = @" ";
    //paused = NO;
    mainMenu.hidden = YES;
    PauseBut.hidden = NO;
    resumeBut.hidden = YES;
    restart.hidden = YES;
    countdown.hidden = NO;
    countdown.text = @"3";
    inCountdown = YES;
    countdownInt = 0;
    PauseBut.hidden = YES;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:.8 target:self selector:@selector (plusCountdown) userInfo:nil repeats:YES];
}

//****************************************************
- (IBAction)red:(id)sender 
{
    [self.view setBackgroundColor:[UIColor orangeColor]];
    redOn = YES;
    yellowOn = NO;
    cyanOn = NO;
    greenOn = NO;
    whiteOn = NO;
    [[NSUserDefaults standardUserDefaults] setInteger: redOn forKey: @"redDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: yellowOn forKey: @"yellowDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: cyanOn forKey: @"cyanDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: greenOn forKey: @"greenDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: whiteOn forKey: @"whiteDefault"];
}

//****************************************************
- (IBAction)green:(id)sender 
{
    [self.view setBackgroundColor:[UIColor greenColor]];
    redOn = NO;
    yellowOn = NO;
    cyanOn = NO;
    greenOn = YES;
    whiteOn = NO;
    [[NSUserDefaults standardUserDefaults] setInteger: redOn forKey: @"redDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: yellowOn forKey: @"yellowDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: cyanOn forKey: @"cyanDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: greenOn forKey: @"greenDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: whiteOn forKey: @"whiteDefault"];
}

//****************************************************
- (void) x2Function//Timer causes lag and gets stuck in x2Function infinitely
{
    x2Label.hidden = NO;
    if (x2Bool)
    x2Label.text = @"X2!";
    else if (x3Bool)
        x2Label.text = @"X3!";
    else if (plus20Bool)
    {
        x2Label.text = @"+20!";
    }
    else if (plus100Bool)
    {
        x2Label.text = @"+100";
    }
    else
    {
        x2Label.text = @"+5!";
    }
    countX2++;
    if (countX2 == 1)
    {
        NSLog(@"In x2Function");
        x2Label.center = CGPointMake (stickman.center.x, stickman.center.y-15);
    }
    else
    {
        x2Label.center = CGPointMake (x2Label.center.x, x2Label.center.y-1);
    }
    if (countX2>=35)
    {
        x2Label.hidden = YES;
        plus100Bool = NO;
        plus20Bool = NO;
        [x2Timer invalidate];
        x2Timer = nil;
        [plusTwentyTimer invalidate];
        plusTwentyTimer = nil;
        [plus100Timer invalidate];
        plus100Timer = nil;
        [plusFiveTimer invalidate];
        plusFiveTimer = nil;
    }
    return;
}

//****************************************************

- (void) plus100
{
    countX2 = 0;
    plus100Bool = YES;
    plus100Timer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (x2Function) userInfo:nil repeats:YES];
    return;
}
//****************************************************

- (void) plus20
{
    countX2 = 0;
    plus20Bool = YES;
    plusTwentyTimer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (x2Function) userInfo:nil repeats:YES];
    return;
}
//****************************************************

- (void) plus5
{
    NSLog(@"In plus5");
    countX2 = 0;
    plusFiveTimer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (x2Function) userInfo:nil repeats:YES];
    return;
}
//****************************************************
- (void) x3
{
    [self.view setBackgroundColor:[UIColor redColor]];
    countForX3 = 0;
    x3Bool = YES;
    countX2 = 0;
    NSLog(@"In x3");
    times3 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector (timesThree) userInfo:nil repeats:YES];
    x2Timer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (x2Function) userInfo:nil repeats:YES];
    return;
}
//****************************************************
- (void) x2
{
    [self.view setBackgroundColor:[UIColor redColor]];
    countForX2 = 0;
    x2Bool = YES;
    countX2 = 0;
    NSLog(@"In x2");
    times2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector (timesTwo) userInfo:nil repeats:YES];
    x2Timer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector (x2Function) userInfo:nil repeats:YES];
    return;
}
//****************************************************
- (void) timesTwo
{
    NSLog(@"In timesTwo");
    x2Bool = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && ![appDelegate.pausedString isEqual: @"paused"])
    {
        countForX2++;
    }
    if (countForX2 >= 9)
    {
        linedPaper.image = [UIImage imageNamed:@"Lined paper copy.png"];
        whiteOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"whiteDefault"];
        yellowOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"yellowDefault"];
        redOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"redDefault"];
        cyanOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"cyanDefault"];
        greenOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"greenDefault"];
        if (!gameOverForCC)
        {
        
        /*
         if (cyanOn)
        {
            [self.view setBackgroundColor:[UIColor cyanColor]];
        }
        
        else if (redOn)
        {
            [self.view setBackgroundColor:[UIColor orangeColor]];
            
        }
        
        else if (greenOn)
        {
            [self.view setBackgroundColor:[UIColor greenColor]];
        }
        else if (yellowOn)
        {
            [self.view setBackgroundColor:[UIColor yellowColor]];
        }
        else if (whiteOn)
        {
            [self.view setBackgroundColor:[UIColor whiteColor]];
            
        }
         */
        }
        [times2 invalidate];
        times2 = nil;
        x2Bool = NO;
    }
    return;
    
}
//****************************************************

- (void) snowflakeFrenzyDisplay
{
    if (!snowflakeFrenzyGameOverHelp)
        snowflakeFrenzyDisplayLabel.hidden = NO;
    return;
}
//****************************************************

- (void) snowflakeFrenzy
{
    snowflakeFrenzyLabel.hidden = NO;
    snowflakeFrenzyCount = 0;
    if (!snowflakeFrenzyGameOverHelp)
    {
        [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d",snowflakeFrenzyCount]];
        snowflakeFrenzyLabel.text = snowflakeFrenzyString;
    }
    [snowflakeTimer invalidate];
    snowflakeTimer = nil;
    snowflakeFrenzy = YES;
    snowflakeTimer = [NSTimer scheduledTimerWithTimeInterval:.15  target:self selector:@selector (snowflakeGo) userInfo:nil repeats:YES];
    snowflakeFrenzyTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector (snowflakeFrenzyFunction) userInfo:nil repeats:YES];
    [self snowflakeFrenzyDisplay];
    return;
}
//****************************************************

- (void) snowflakeFrenzyFunction
{
    snowflakeFrenzyHelp = YES;//Makes sure that if a snowflake is caught before the score is finished being displayed, it doesn't start another snowflakeFrenzy - it gives you plus 100 instead
    snowflakeFrenzyLabel.hidden = NO;
    if (!snowflakeFrenzyGameOverHelp)
    {
        [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d",snowflakeFrenzyCount]];
        snowflakeFrenzyLabel.text = snowflakeFrenzyString;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && ![appDelegate.pausedString isEqual: @"paused"])
    {
        NSLog(@"%@", appDelegate.pausedString);
        NSLog(@"Adding to k!");
        k++;
    }
    if (k >= 2)
    {
        if (paused)
            NSLog(@"Paused!");
        else
            NSLog(@"I don't think its paused");
        snowflakeFrenzyDisplayLabel.hidden = YES;
    }
    if (k == 15)
    {
        [snowflakeTimer invalidate];
        snowflakeTimer = nil;
        snowflakeTimer = [NSTimer scheduledTimerWithTimeInterval:NEWSNOWFLAKESPEED target:self selector:@selector (snowflakeGo) userInfo:nil repeats:YES];
    }
    if (k == 18)
    {
        snowflakeFrenzyCount *= 10;
        [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d Points!",snowflakeFrenzyCount]];
        snowflakeFrenzyLabel.text = snowflakeFrenzyString;
        snowflakeFrenzy = NO;
        score+=snowflakeFrenzyCount;
    }
    if (k == 18)
    {
        [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d Points!",snowflakeFrenzyCount]];
        snowflakeFrenzyLabel.text = snowflakeFrenzyString;
    }
    if (k>=19)
    {
        if (!snowflakeFrenzyGameOverHelp)
            snowflakeFrenzyLabel.hidden = YES;
        [snowflakeFrenzyTimer invalidate];
        snowflakeFrenzyTimer = nil;
        k = 0;
        snowflakeFrenzyHelp = NO;
    }
    return;
}
//****************************************************
- (void) timesThree
{
    NSLog(@"In timesThree");
    x3Bool = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && ![appDelegate.pausedString isEqual: @"paused"] )
    {
        countForX3++;
    }
    if (countForX3 >= 9)
    {
        linedPaper.image = [UIImage imageNamed:@"Lined paper copy.png"];
        whiteOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"whiteDefault"];
        yellowOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"yellowDefault"];
        redOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"redDefault"];
        cyanOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"cyanDefault"];
        greenOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"greenDefault"];
        if (!gameOverForCC)
        {
            /*
        if (cyanOn)
        {
            [self.view setBackgroundColor:[UIColor cyanColor]];
        }
        
        else if (redOn)
        {
            [self.view setBackgroundColor:[UIColor orangeColor]];
            
        }
        
        else if (greenOn)
        {
            [self.view setBackgroundColor:[UIColor greenColor]];
        }
        else if (yellowOn)
        {
            [self.view setBackgroundColor:[UIColor yellowColor]];
        }
        else if (whiteOn)
        {
            [self.view setBackgroundColor:[UIColor whiteColor]];
            
        }
             */
        }
        [times3 invalidate];
        times3 = nil;
        x3Bool = NO;
    }
    return;
}
//****************************************************
- (IBAction)yellow:(id)sender 
{
    [self.view setBackgroundColor:[UIColor yellowColor]];
    redOn = NO;
    yellowOn = YES;
    cyanOn = NO;
    greenOn = NO;
    whiteOn = NO;
    [[NSUserDefaults standardUserDefaults] setInteger: redOn forKey: @"redDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: yellowOn forKey: @"yellowDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: cyanOn forKey: @"cyanDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: greenOn forKey: @"greenDefault"];
    [[NSUserDefaults standardUserDefaults] setInteger: whiteOn forKey: @"whiteDefault"];
    return;
}

//****************************************************
//****************************************************
- (void) gameUpdate
{
    //ViewController *viewController = [[ViewController alloc]init];
    //[self presentViewController:viewController animated: YES completion:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ((paused || [appDelegate.pausedString isEqual: @"paused"]) && !snowflakeFrenzyGameOverHelp && !inCountdown)
    {
        PauseBut.hidden = YES;
            closeCall.text = @"Paused";
            restart.hidden = NO;
            mainMenu.hidden = NO;
            resumeBut.hidden = NO;
    }
    else if (snowflakeFrenzyGameOverHelp)
    {
        gameOverForCC = YES;
        snowflakeFrenzyGameOverHelp = YES;
        paused = YES;
        snowflakeFrenzyDisplayLabel.hidden = YES;
        restart.hidden = YES;
        mainMenu.hidden = YES;
        resumeBut.hidden = YES;
        [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d Points!",snowflakeFrenzyCount]];
        snowflakeFrenzyLabel.text = snowflakeFrenzyString;
        if (snowflakeFrenzyGameOver == 0)
        {
            [gameTimer2 invalidate];
            gameTimer2 = nil;
            [gameTimer5 invalidate];
            gameTimer5 = nil;
            [gameTimer4 invalidate];
            gameTimer4 = nil;
            [icicleGoTimer invalidate];
            icicleGoTimer = nil;
        }
        else if (snowflakeFrenzyGameOver == 5)
        {
            snowflakeFrenzyCount *= 10;
            [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d Points!",snowflakeFrenzyCount]];
            snowflakeFrenzyLabel.text = snowflakeFrenzyString;
            score+=snowflakeFrenzyCount;
            [scoreString setString:[NSString stringWithFormat:@"Score : %d",score]];
            scorelabel.text = scoreString;
        }
        else if (snowflakeFrenzyGameOver == 100)
        {
            snowflakeFrenzyLabel.hidden = YES;
            snowflakeFrenzy = NO;
            snowflakeFrenzyGameOverHelp = NO;
            snowflakeFrenzyGameOver = 0;
            [scoreString setString:[NSString stringWithFormat:@"Score : %d",score]];
            scorelabel.text = scoreString;
            [self gameOver];
        }
        snowflakeFrenzyGameOver++;
    }
    else
    {
        [self fixHelpFrames];
    CGRect closeCallrect = closeCallIV.frame;
    CGRect stickmanrect = stickmanHelp.frame;
    CGRect stickmanrect2 = help2.frame;
    CGRect iciclerect = icicle.frame;
    //CGRect helpLeftrect = helpLeft.frame;
    //CGRect helpRightrect = helpRight.frame;
    CGRect icicle2rect = icicle2.frame;
    CGRect icicle3rect = icicle3.frame;
    CGRect icicle4rect = icicle4.frame;
    CGRect icicle5rect = icicle5.frame;
    CGRect icicle6rect = icicle6.frame;
    CGRect icicle7rect = icicle7.frame;
    CGRect icicle8rect = icicle8.frame;
        CGRect icicle9rect = icicle9.frame;
        CGRect icicle10rect = icicle10.frame;
        CGRect icicle11rect = icicle11.frame;
        CGRect icicle12rect = icicle12.frame;
        CGRect snowflakerect = snowflake.frame;
        CGRect snowflake2rect = snowflake2.frame;
        CGRect snowflake3rect = snowflake3.frame;
        CGRect snowflake4rect = snowflake4.frame;
        CGRect snowflake5rect = snowflake5.frame;
        CGRect snowflake6rect = snowflake6.frame;
        CGRect snowflake7rect = snowflake7.frame;
    if ((CGRectIntersectsRect(stickmanrect, iciclerect)||CGRectIntersectsRect(stickmanrect, icicle2rect)||CGRectIntersectsRect(stickmanrect, icicle3rect)||CGRectIntersectsRect(stickmanrect, icicle4rect)||CGRectIntersectsRect(stickmanrect, icicle5rect)||CGRectIntersectsRect(stickmanrect, icicle6rect)||CGRectIntersectsRect(stickmanrect, icicle7rect)||CGRectIntersectsRect(stickmanrect, icicle8rect)||CGRectIntersectsRect(stickmanrect, icicle9rect)||CGRectIntersectsRect(stickmanrect, icicle10rect)||CGRectIntersectsRect(stickmanrect, icicle11rect)||CGRectIntersectsRect(stickmanrect, icicle12rect)/*||CGRectIntersectsRect(helpRightrect, iciclerect)||CGRectIntersectsRect(helpRightrect, icicle2rect)||CGRectIntersectsRect(helpRightrect, icicle3rect)||CGRectIntersectsRect(helpRightrect, icicle4rect)||CGRectIntersectsRect(helpRightrect, icicle5rect)||CGRectIntersectsRect(helpRightrect, icicle6rect)||CGRectIntersectsRect(helpRightrect, icicle7rect)||CGRectIntersectsRect(helpRightrect, icicle8rect)||CGRectIntersectsRect(helpRightrect, icicle9rect)||CGRectIntersectsRect(helpRightrect, icicle10rect)||CGRectIntersectsRect(helpRightrect, icicle11rect)||CGRectIntersectsRect(helpRightrect, icicle12rect)*/) && goingRightLast)
    {
        closeCall.hidden = YES;
            if (snowflakeFrenzy)
            {
                paused = YES;
                snowflakeFrenzyGameOverHelp = YES;
                restart.hidden = YES;
                mainMenu.hidden = YES;
                resumeBut.hidden = YES;
                if (snowflakeFrenzyGameOver == 0)
                {
                    snowflakeFrenzyCount *= 10;
                    [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d Points!",snowflakeFrenzyCount]];
                    snowflakeFrenzyLabel.text = snowflakeFrenzyString;
                    score+=snowflakeFrenzyCount;
                }
                else if (snowflakeFrenzyGameOver == 500)
                {
                    snowflakeFrenzyLabel.hidden = YES;
                    snowflakeFrenzy = NO;
                    snowflakeFrenzyGameOverHelp = NO;
                }
                snowflakeFrenzyGameOver++;
            }
            else
            {
                inGame = NO;
                [[NSUserDefaults standardUserDefaults] setBool: inGame forKey: @"inGameDefault"];
                snowflakeFrenzyGameOver = 0;
                [self gameOver];
                gameOverForCC = YES;
            }
    }

    if ((CGRectIntersectsRect(stickmanrect2, iciclerect)||CGRectIntersectsRect(stickmanrect2, icicle2rect)||CGRectIntersectsRect(stickmanrect2, icicle3rect)||CGRectIntersectsRect(stickmanrect2, icicle4rect)||CGRectIntersectsRect(stickmanrect2, icicle5rect)||CGRectIntersectsRect(stickmanrect2, icicle6rect)||CGRectIntersectsRect(stickmanrect2, icicle7rect)||CGRectIntersectsRect(stickmanrect2, icicle8rect)||CGRectIntersectsRect(stickmanrect2, icicle9rect)||CGRectIntersectsRect(stickmanrect2, icicle10rect)||CGRectIntersectsRect(stickmanrect2, icicle11rect)||CGRectIntersectsRect(stickmanrect2, icicle12rect)/*||CGRectIntersectsRect(helpLeftrect, iciclerect)||CGRectIntersectsRect(helpLeftrect, icicle2rect)||CGRectIntersectsRect(helpLeftrect, icicle3rect)||CGRectIntersectsRect(helpLeftrect, icicle4rect)||CGRectIntersectsRect(helpLeftrect, icicle5rect)||CGRectIntersectsRect(helpLeftrect, icicle6rect)||CGRectIntersectsRect(helpLeftrect, icicle7rect)||CGRectIntersectsRect(helpLeftrect, icicle8rect)||CGRectIntersectsRect(helpLeftrect, icicle9rect)||CGRectIntersectsRect(helpLeftrect, icicle10rect)||CGRectIntersectsRect(helpLeftrect, icicle11rect)||CGRectIntersectsRect(helpLeftrect, icicle12rect)*/) && goingLeftLast)
    {
        closeCall.hidden = YES;
        if (snowflakeFrenzy)
        {
            snowflakeFrenzyGameOverHelp = YES;
            paused = YES;
            restart.hidden = YES;
            mainMenu.hidden = YES;
            resumeBut.hidden = YES;
            if (snowflakeFrenzyGameOver == 0)
            {
                snowflakeFrenzyCount *= 10;
                [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d Points!",snowflakeFrenzyCount]];
                snowflakeFrenzyLabel.text = snowflakeFrenzyString;
                score+=snowflakeFrenzyCount;
            }
            else if (snowflakeFrenzyGameOver == 500)
            {
                snowflakeFrenzyLabel.hidden = YES;
                snowflakeFrenzy = NO;
                snowflakeFrenzyGameOverHelp = NO;
            }
            snowflakeFrenzyGameOver++;
        }
        else
        {
            inGame = NO;
            [[NSUserDefaults standardUserDefaults] setBool: inGame forKey: @"inGameDefault"];
            snowflakeFrenzyGameOver = 0;
            [self gameOver];
            gameOverForCC = YES;
        }
    }
        if ((CGRectIntersectsRect(closeCallrect, iciclerect)||CGRectIntersectsRect(closeCallrect, icicle2rect)||CGRectIntersectsRect(closeCallrect, icicle3rect)||CGRectIntersectsRect(closeCallrect, icicle4rect)||CGRectIntersectsRect(closeCallrect, icicle5rect)||CGRectIntersectsRect(closeCallrect, icicle6rect)||CGRectIntersectsRect(closeCallrect, icicle7rect)||CGRectIntersectsRect(closeCallrect, icicle8rect)||CGRectIntersectsRect(closeCallrect, icicle9rect)||CGRectIntersectsRect(closeCallrect, icicle10rect)||CGRectIntersectsRect(closeCallrect, icicle11rect)||CGRectIntersectsRect(closeCallrect, icicle12rect))&&!gameOverForCC)
    {
        if (!snowflakeFrenzy)
        {
        [closeCallTimer invalidate];
        closeCallTimer = nil;
        closeCallTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(closeCallDo) userInfo:nil repeats:YES];//close call
        }
    }
        if ((CGRectIntersectsRect(stickmanrect, snowflakerect)||CGRectIntersectsRect(stickmanrect, snowflake2rect)||CGRectIntersectsRect(stickmanrect, snowflake3rect)||CGRectIntersectsRect(stickmanrect, snowflake4rect)||CGRectIntersectsRect(stickmanrect, snowflake5rect)||CGRectIntersectsRect(stickmanrect, snowflake6rect)||CGRectIntersectsRect(stickmanrect, snowflake7rect)/*||CGRectIntersectsRect(helpRightrect, snowflakerect)||CGRectIntersectsRect(helpRightrect, snowflake2rect)||CGRectIntersectsRect(helpRightrect, snowflake3rect)||CGRectIntersectsRect(helpRightrect, snowflake4rect)||CGRectIntersectsRect(helpRightrect, snowflake5rect)||CGRectIntersectsRect(helpRightrect, snowflake6rect)||CGRectIntersectsRect(helpRightrect, snowflake7rect)*/) && goingRightLast && !gameOverForCC)
        {
            if (CGRectIntersectsRect(stickmanrect, snowflakerect))
            {
                snowflake.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake.center;
                snowflake.center = CGPointMake (oldCenter.x, 0);
                NSLog(@"%f", oldCenter.x);
                snowflakea = NO;
            }
            if (CGRectIntersectsRect(stickmanrect, snowflake2rect))
            {
                snowflake2.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake2.center;
                snowflake2.center = CGPointMake (oldCenter.x, 0);
                snowflakea2 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect, snowflake3rect))
            {
                snowflake3.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake3.center;
                snowflake3.center = CGPointMake (oldCenter.x, 0);
                snowflakea3 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect, snowflake4rect))
            {
                snowflake4.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake4.center;
                snowflake4.center = CGPointMake (oldCenter.x, 0);
                snowflakea4 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect, snowflake5rect))
            {
                snowflake5.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake5.center;
                snowflake5.center = CGPointMake (oldCenter.x, 0);
                snowflakea5 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect, snowflake6rect))
            {
                snowflake6.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake6.center;
                snowflake6.center = CGPointMake (oldCenter.x, 0);
                snowflakea6 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect, snowflake7rect))
            {
                snowflake7.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake7.center;
                snowflake7.center = CGPointMake (oldCenter.x, 0);
                snowflakea7 = NO;
            }
            //NSLog(@"Calling x2");
            if (!snowflakeFrenzy)
            {
            xxx = 0;
                xxx = arc4random() % 60;
            if (!inPlus5 && !x2Bool && !x3Bool)
            {
                if (xxx == 2 || xxx == 3)
                {
                    linedPaper.image = [UIImage imageNamed:@"blank.png"];
                    [self x3];
                }
                else if (xxx == 0 || xxx == 1 || xxx == 4 || xxx == 5)
                {
                    linedPaper.image = [UIImage imageNamed:@"blank.png"];
                    [self x2];
                }
                else if (xxx == 6 || xxx == 7)
                {
                    [self plus20];
                    score += 20;
                }
                else if (xxx == 8)
                {
                    [self plus100];
                    score += 100;
                }
                else if (xxx ==9 && !snowflakeFrenzyHelp)
                {
                    [self snowflakeFrenzy];
                }
                else if (snowflakeFrenzyHelp && xxx == 9)
                {
                    [self plus100];
                    score += 100;
                }
                else {
                    [self plus5];
                    score += 5;
                }
            }
            }
            else if (snowflakeFrenzy)
            {
                snowflakeFrenzyCount++;
                if (!snowflakeFrenzyGameOverHelp)
                {
                    [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d",snowflakeFrenzyCount]];
                    snowflakeFrenzyLabel.text = snowflakeFrenzyString;
                }
            }
        }
        if ((CGRectIntersectsRect(stickmanrect2, snowflakerect)||CGRectIntersectsRect(stickmanrect2, snowflake2rect)||CGRectIntersectsRect(stickmanrect2, snowflake3rect)||CGRectIntersectsRect(stickmanrect2, snowflake4rect)||CGRectIntersectsRect(stickmanrect2, snowflake5rect)||CGRectIntersectsRect(stickmanrect2, snowflake6rect)||CGRectIntersectsRect(stickmanrect2, snowflake7rect)/*||CGRectIntersectsRect(helpLeftrect, snowflakerect)||CGRectIntersectsRect(helpLeftrect, snowflake2rect)||CGRectIntersectsRect(helpLeftrect, snowflake3rect)||CGRectIntersectsRect(helpLeftrect, snowflake4rect)||CGRectIntersectsRect(helpLeftrect, snowflake5rect)||CGRectIntersectsRect(helpLeftrect, snowflake6rect)||CGRectIntersectsRect(helpLeftrect, snowflake7rect)*/) && goingLeftLast && !gameOverForCC)
        {
            if (CGRectIntersectsRect(stickmanrect2, snowflakerect))
            {
                snowflake.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake.center;
                snowflake.center = CGPointMake (oldCenter.x, 0);
                snowflakea = NO;
            }
            if (CGRectIntersectsRect(stickmanrect2, snowflake2rect))
            {
                snowflake2.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake2.center;
                snowflake2.center = CGPointMake (oldCenter.x, 0);
                snowflakea2 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect2, snowflake3rect))
            {
                snowflake3.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake3.center;
                snowflake3.center = CGPointMake (oldCenter.x, 0);
                snowflakea3 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect2, snowflake4rect))
            {
                snowflake4.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake4.center;
                snowflake4.center = CGPointMake (oldCenter.x, 0);
                snowflakea4 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect2, snowflake5rect))
            {
                snowflake5.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake5.center;
                snowflake5.center = CGPointMake (oldCenter.x, 0);
                snowflakea5 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect2, snowflake6rect))
            {
                snowflake6.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake6.center;
                snowflake6.center = CGPointMake (oldCenter.x, 0);
                snowflakea6 = NO;
            }
            if (CGRectIntersectsRect(stickmanrect2, snowflake7rect))
            {
                snowflake7.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake7.center;
                snowflake7.center = CGPointMake (oldCenter.x, 0);
                snowflakea7 = NO;
            }
            //NSLog(@"Calling x2");
            if (!snowflakeFrenzy)
            {
                xxx = 0;
                xxx = arc4random() % 60;
                if (!inPlus5 && !x2Bool && !x3Bool)
                {
                    if (xxx == 2 || xxx == 3)
                    {
                        linedPaper.image = [UIImage imageNamed:@"blank.png"];
                        [self x3];
                    }
                    else if (xxx == 0 || xxx == 1 || xxx == 4 || xxx == 5)
                    {
                        linedPaper.image = [UIImage imageNamed:@"blank.png"];
                        [self x2];
                    }
                    else if (xxx == 6 || xxx == 7)
                    {
                        [self plus20];
                        score += 20;
                    }
                    else if (xxx == 8)
                    {
                        [self plus100];
                        score += 100;
                    }
                    else if (xxx == 9 && !snowflakeFrenzyHelp)
                    {
                        [self snowflakeFrenzy];
                    }
                    else if (xxx == 9 && snowflakeFrenzyHelp)
                    {
                        [self plus100];
                        score += 100;
                    }
                    else {
                        [self plus5];
                        score += 5;
                    }
                }
            }
        else if (snowflakeFrenzy)
        {
            snowflakeFrenzyCount++;
            if (!snowflakeFrenzyGameOverHelp)
            {
                [snowflakeFrenzyString setString:[NSString stringWithFormat:@"%d", snowflakeFrenzyCount]];
                snowflakeFrenzyLabel.text = snowflakeFrenzyString;
            }
        }
        }
        /*if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            //I'm running on the iPad
            
            if (stickman.center.x  < 15)
            {
                stickman.center = CGPointMake(760, stickman.center.y);//causes wraparound
                help2.center = CGPointMake(760, help2.center.y);
                helpRight.center = CGPointMake(760, helpRight.center.y);
                helpLeft.center = CGPointMake(760, helpLeft.center.y);
                stickmanHelp.center = CGPointMake(760, stickmanHelp.center.y);
                closeCallIV.center = CGPointMake(760, closeCallIV.center.y);
                 //Things to move:
                 //stickmanHelp
                 //help2
                 //helpRight
                 //helpLeft
                 //closeCallIV
                 
            }
            else if (stickman.center.x > 748)
            {
                stickman.center = CGPointMake(25, stickman.center.y);
                help2.center = CGPointMake(25, help2.center.y);
                helpRight.center = CGPointMake(25, helpRight.center.y);
                helpLeft.center = CGPointMake(25, helpLeft.center.y);
                stickmanHelp.center = CGPointMake(25, stickmanHelp.center.y);
                closeCallIV.center = CGPointMake(25, closeCallIV.center.y);
            }
        } else { */
            //I'm running on the iPhone
    if (stickman.center.x  < 20)
    {
        stickman.center = CGPointMake(300, stickman.center.y);//causes wraparound
        help2.center = CGPointMake(300, help2.center.y);
        helpRight.center = CGPointMake(290, helpRight.center.y);
        helpLeft.center = CGPointMake(300, helpLeft.center.y);
        stickmanHelp.center = CGPointMake(300, stickmanHelp.center.y);
        closeCallIV.center = CGPointMake(300, closeCallIV.center.y);
        /*
         Things to move:
         stickmanHelp
         help2
         helpRight
         helpLeft
         closeCallIV
         */
    }
    else if (stickman.center.x > 300)
    {
        stickman.center = CGPointMake(20, stickman.center.y);
        help2.center = CGPointMake(20, help2.center.y);
        helpRight.center = CGPointMake(30, helpRight.center.y);
        helpLeft.center = CGPointMake(20, helpLeft.center.y);
        stickmanHelp.center = CGPointMake(20, stickmanHelp.center.y);
        closeCallIV.center = CGPointMake(20, closeCallIV.center.y);
    }
        //}
    if (goingRight == YES && !inCountdown)
    {
        /*
         if 
         goingrightHelp++
         *********************************
         stickmanHelp
         help2
         helpRight
         helpLeft
         closeCallIV
         */
        stickman.image = [UIImage imageNamed:@"StickManRightNew.png"];
        CGPoint oldCenter = stickman.center;
        stickman.center = CGPointMake(oldCenter.x+STICKMOVE, oldCenter.y);
        CGPoint oldCenter2 = stickmanHelp.center;
        stickmanHelp.center = CGPointMake(oldCenter2.x+STICKMOVE, oldCenter2.y);
        CGPoint oldCenter3 = help2.center;
        help2.center = CGPointMake(oldCenter3.x+STICKMOVE, oldCenter3.y);
        helpRight.center = CGPointMake(helpRight.center.x+STICKMOVE, helpRight.center.y);
        helpLeft.center = CGPointMake(helpLeft.center.x+STICKMOVE, helpLeft.center.y);
        closeCallIV.center = CGPointMake(oldCenter2.x+STICKMOVE, oldCenter2.y);
        /*
        if (firstGo == 0)
        {
            CGPoint oldCenter = stickman.center;
            stickman.center = CGPointMake(oldCenter.x-.1, oldCenter.y);
            CGPoint oldCenter2 = stickmanHelp.center;
            stickmanHelp.center = CGPointMake(oldCenter2.x-.1, oldCenter2.y);
            CGPoint oldCenter3 = help2.center;
            help2.center = CGPointMake(oldCenter3.x-.1, oldCenter3.y);
            helpRight.center = CGPointMake(helpRight.center.x-.1, helpRight.center.y);
            helpLeft.center = CGPointMake(helpLeft.center.x-.1, helpLeft.center.y);
            closeCallIV.center = CGPointMake(oldCenter2.x-.1, oldCenter2.y);
            goingRight = NO;
            firstGo = 1;
        }
         */
    }
    else if (goingLeft == YES && !inCountdown)
    {
        stickman.image = [UIImage imageNamed:@"StickManLeftNew.png"];
        CGPoint oldCenter = stickman.center;
        stickman.center = CGPointMake(oldCenter.x-STICKMOVE, oldCenter.y);
        CGPoint oldCenter2 = stickmanHelp.center;
        stickmanHelp.center = CGPointMake(oldCenter2.x-STICKMOVE, oldCenter2.y);
        CGPoint oldCenter3 = help2.center;
        help2.center = CGPointMake(oldCenter3.x-STICKMOVE, oldCenter3.y);
        helpRight.center = CGPointMake(helpRight.center.x-STICKMOVE, helpRight.center.y);
        helpLeft.center = CGPointMake(helpLeft.center.x-STICKMOVE, helpLeft.center.y);
        closeCallIV.center = CGPointMake(oldCenter2.x-STICKMOVE, oldCenter2.y);
    }

    }
    return;
}

//****************************************************
-(void) icicleMove
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && ![appDelegate.pausedString isEqual: @"paused"])
    {
    if (iciclea)
    {
        icicle.image = [UIImage imageNamed:@"IcicleNewNew.png"];
        CGPoint oldCenter = icicle.center;
        icicle.center = CGPointMake (oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea2)
    {
        icicle2.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle2.center;
        icicle2.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea3)
    {
        icicle3.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle3.center;
        icicle3.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea4)
    {
        icicle4.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle4.center;
        icicle4.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea5)
    {
        icicle5.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle5.center;
        icicle5.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea6)
    {
        icicle6.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle6.center;
        icicle6.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea7)
    {
        icicle7.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle7.center;
        icicle7.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea8)
    {
        icicle8.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle8.center;
        icicle8.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
    if (iciclea9)
    {
        icicle9.image = [UIImage imageNamed: @"IcicleNewNew.png"];
        CGPoint oldCenter = icicle9.center;
        icicle9.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
    }
        if (iciclea10)
        {
            icicle10.image = [UIImage imageNamed: @"IcicleNewNew.png"];
            CGPoint oldCenter = icicle10.center;
            icicle10.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
        }
        if (iciclea11)
        {
            icicle11.image = [UIImage imageNamed: @"IcicleNewNew.png"];
            CGPoint oldCenter = icicle11.center;
            icicle11.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
        }
        if (iciclea12)
        {
            icicle12.image = [UIImage imageNamed: @"IcicleNewNew.png"];
            CGPoint oldCenter = icicle12.center;
            icicle12.center = CGPointMake(oldCenter.x, oldCenter.y + ICEMOVE);
        }
        /*if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (icicle.center.y>1024)
            {
                iciclea = NO;
                icicle.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = icicle.center;
                icicle.center = CGPointMake (oldCenter.x, 0);
            }
            else if (icicle2.center.y>1024)
            {
                iciclea2 = NO;
                icicle2.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle2.center;
                icicle2.center = CGPointMake(oldCenter.x, 0);
            }
            else if (icicle3.center.y>1024)
            {
                iciclea3 = NO;
                icicle3.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle3.center;
                icicle3.center = CGPointMake(oldCenter.x, 0);
            }
            else if (icicle4.center.y>1024)
            {
                icicle4.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle4.center;
                icicle4.center = CGPointMake(oldCenter.x, 0);
                iciclea4 = NO;
            }
            else if (icicle5.center.y>1024)
            {
                icicle5.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle5.center;
                icicle5.center = CGPointMake(oldCenter.x, 0);
                iciclea5 = NO;
            }
            else if (icicle6.center.y>1024)
            {
                icicle6.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle6.center;
                icicle6.center = CGPointMake(oldCenter.x, 0);
                iciclea6 = NO;
            }
            else if (icicle7.center.y>1024)
            {
                icicle7.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle7.center;
                icicle7.center = CGPointMake(oldCenter.x, 0);
                iciclea7 = NO;
            }
            else if (icicle8.center.y>1024)
            {
                icicle8.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle8.center;
                icicle8.center = CGPointMake(oldCenter.x, 0);
                iciclea8 = NO;
            }
            else if (icicle9.center.y>1024)
            {
                icicle9.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle9.center;
                icicle9.center = CGPointMake(oldCenter.x, 0);
                iciclea9 = NO;
            }
            else if (icicle10.center.y>1024)
            {
                icicle10.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle10.center;
                icicle10.center = CGPointMake(oldCenter.x, 0);
                iciclea10 = NO;
            }
            else if (icicle11.center.y>1024)
            {
                icicle11.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle11.center;
                icicle11.center = CGPointMake(oldCenter.x, 0);
                iciclea11 = NO;
            }
            else if (icicle12.center.y>1024)
            {
                icicle12.image = [UIImage imageNamed: @"blank.png"];
                CGPoint oldCenter = icicle12.center;
                icicle12.center = CGPointMake(oldCenter.x, 0);
                iciclea12 = NO;
            }
            //I'm running on the iPad
        }*/ //else {
            //I'm running on the iPhone
    if (icicle.center.y>480)
    {
        iciclea = NO;
        icicle.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = icicle.center;
        icicle.center = CGPointMake (oldCenter.x, 0);
    }
    else if (icicle2.center.y>480)
    {
        iciclea2 = NO;
        icicle2.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle2.center;
        icicle2.center = CGPointMake(oldCenter.x, 0);
    }
    else if (icicle3.center.y>480)
    {
        iciclea3 = NO;
        icicle3.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle3.center;
        icicle3.center = CGPointMake(oldCenter.x, 0);
    }
    else if (icicle4.center.y>480)
    {
        icicle4.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle4.center;
        icicle4.center = CGPointMake(oldCenter.x, 0);
        iciclea4 = NO;
    }
    else if (icicle5.center.y>480)
    {
        icicle5.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle5.center;
        icicle5.center = CGPointMake(oldCenter.x, 0);
        iciclea5 = NO;
    }
    else if (icicle6.center.y>480)
    {
        icicle6.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle6.center;
        icicle6.center = CGPointMake(oldCenter.x, 0);
        iciclea6 = NO;
    }
    else if (icicle7.center.y>480)
    {
        icicle7.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle7.center;
        icicle7.center = CGPointMake(oldCenter.x, 0);
        iciclea7 = NO;
    }
    else if (icicle8.center.y>480)
    {
        icicle8.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle8.center;
        icicle8.center = CGPointMake(oldCenter.x, 0);
        iciclea8 = NO;
    }
    else if (icicle9.center.y>480)
    {
        icicle9.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle9.center;
        icicle9.center = CGPointMake(oldCenter.x, 0);
        iciclea9 = NO;
    }
    else if (icicle10.center.y>480)
    {
        icicle10.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle10.center;
        icicle10.center = CGPointMake(oldCenter.x, 0);
        iciclea10 = NO;
    }
    else if (icicle11.center.y>480)
    {
        icicle11.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle11.center;
        icicle11.center = CGPointMake(oldCenter.x, 0);
        iciclea11 = NO;
    }
    else if (icicle12.center.y>480)
    {
        icicle12.image = [UIImage imageNamed: @"blank.png"];
        CGPoint oldCenter = icicle12.center;
        icicle12.center = CGPointMake(oldCenter.x, 0);
        iciclea12 = NO;
    //}
    }
        
    }
    return;
}

//****************************************************
-(void) icicleGo
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && ![appDelegate.pausedString isEqual: @"paused"])
    {
        if (count == 0)
        {
    randomNum:
        x = arc4random() %12;
        /*
         if (x == 0 && iciclea)
         {
         goto randomNum;
         }
         else if (x == 1 && iciclea2)
         {
         goto randomNum;
         }
         else if (x == 2 && iciclea3)
         {
         goto randomNum;
         }
         else if (x == 3 && iciclea4)
         {
         goto randomNum;
         }
         else if (x == 4 && iciclea5)
         {
         goto randomNum;
         }
         else if (x == 5 && iciclea6)
         {
         goto randomNum;
         }
         else if (x == 6 && iciclea7)
         {
         goto randomNum;
         }
         else if (x == 7 && iciclea8)
         {
         goto randomNum;
         }
         else if (x == 8 && iciclea9)
         {
         goto randomNum;
         }
         */ 
    }
    
    count++;
    if (x == 0)
    {
        iciclea = YES;
    }
    else if (x==1)
    {
        iciclea2 = YES;
    }
    else if (x==2)
    {
        iciclea3 = YES;
    }
    else if (x==3)
    {
        iciclea4 = YES;
    }
    else if (x==4)
    {
        iciclea5 = YES;
    }
    else if (x==5)
    {
        iciclea6 = YES;
    }
    else if (x==6)
    {
        iciclea7 = YES;
    }
    else if (x==7)
    {
        iciclea8 = YES;
    }
    else if (x==8)
    {
        iciclea9 = YES;
        
    }
    else if (x==9)
    {
        iciclea10 = YES;
        
    }
    else if (x==10)
    {
        iciclea11 = YES;
        
    }
    else if (x==11)
    {
        iciclea12 = YES;
        
    }
    }
    return;
}
//****************************************************
/*
- (void) gameOverWaitExec
{
    NSLog(@"In gameOverWaitExec");
    if (countForGOW == 100)
    {
        [gameOverWait invalidate];
        gameOverWait = nil;
    }
    GOWBool = YES;
 countForGOW++;
 return;
}
 */

//****************************************************
-(void) gameOver//:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    countdown.hidden = YES;
    PauseBut.hidden = YES;
    snowflakeFrenzyLabel.hidden = YES;
    snowflakeFrenzyDisplayLabel.hidden = YES;
    [snowflakeFrenzyTimer invalidate];
    snowflakeFrenzyTimer = nil;
    k = 0;
    snowflakeFrenzyHelp = NO;
    [closeCallTimer invalidate];
    sleep(1);
/*
gameover:
    if (!GOWBool)
    {
        goto gameover;
    }
 */
    rightButton.hidden = YES;
    leftButton.hidden = YES;
    closeCallTimer = nil;
    closeCall.hidden = YES;
    restart.hidden = NO;
    PauseBut.hidden = YES;
    [scoreString setString:[NSString stringWithFormat:@"Score : %d",score]];
    scorelabel.text = scoreString;
    // To read it back:
    mainMenu.hidden = NO;
    _highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
    if (score > _highscore)
    {
        [[NSUserDefaults standardUserDefaults] setInteger: score forKey: @"highscore"];
        [highscoreHelp setString:[NSString stringWithFormat:@"%d",score]];
        highscoreText.text = @"You have beaten the all-time highscore!";
        _highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];   }
    
    linedPaper.image = [UIImage imageNamed:@"Lined paper copy.png"];
    stickman.hidden = YES;
    snowflake.image = [UIImage imageNamed:@"blank.png"];
    snowflake2.image = [UIImage imageNamed:@"blank.png"];
    snowflake3.image = [UIImage imageNamed:@"blank.png"];
    snowflake4.image = [UIImage imageNamed:@"blank.png"];
    snowflake5.image = [UIImage imageNamed:@"blank.png"];
    snowflake6.image = [UIImage imageNamed:@"blank.png"];
    snowflake7.image = [UIImage imageNamed:@"blank.png"];
    CGPoint oldCenter = snowflake.center;
    snowflake.center = CGPointMake (oldCenter.x, 0);
    snowflakea = NO;
    snowflake2.center = CGPointMake (snowflake2.center.x, 0);
    snowflakea2 = NO;
    
    snowflake3.center = CGPointMake (snowflake3.center.x, 0);
    snowflakea3 = NO;
    snowflake4.center = CGPointMake (snowflake4.center.x, 0);
    snowflakea4 = NO;
    snowflake5.center = CGPointMake (snowflake5.center.x, 0);
    snowflakea5 = NO;
    snowflake6.center = CGPointMake (snowflake6.center.x, 0);
    snowflakea6 = NO;
    snowflake7.center = CGPointMake (snowflake7.center.x, 0);
    snowflakea7 = NO;
    help2.image = [UIImage imageNamed:@"blank.png"];
    stickmanHelp.image = [UIImage imageNamed:@"blank.png"];
    helpLeft.image = [UIImage imageNamed:@"blank.png"];
    helpRight.image = [UIImage imageNamed:@"blank.png"];
    icicle.image = [UIImage imageNamed:@"blank.png"];
    icicle10.image = [UIImage imageNamed:@"blank.png"];
    icicle11.image = [UIImage imageNamed:@"blank.png"];
    icicle12.image = [UIImage imageNamed:@"blank.png"];
    icicle2.image = [UIImage imageNamed:@"blank.png"];
    icicle3.image = [UIImage imageNamed:@"blank.png"];
    icicle4.image = [UIImage imageNamed:@"blank.png"];
    icicle5.image = [UIImage imageNamed:@"blank.png"];
    icicle6.image = [UIImage imageNamed:@"blank.png"];
    icicle7.image = [UIImage imageNamed:@"blank.png"];
    icicle8.image = [UIImage imageNamed:@"blank.png"];
    icicle9.image = [UIImage imageNamed:@"blank.png"];
    [self.view setBackgroundColor:[UIColor blackColor]];
    //NSLog(@"The highscore is %d.", _highscore);
    [highscoreHelp2 setString:[NSString stringWithFormat:@"The highscore is %d.",_highscore]];
    highscoreNum.text = highscoreHelp2;
    
    [snowflakeTimer invalidate];
    snowflakeTimer = nil;
    snowflakeTimer = [NSTimer scheduledTimerWithTimeInterval:.7 target:self selector:@selector (snowflakeGo) userInfo:nil repeats:YES];
    [gameTimer invalidate];
    gameTimer = nil;
    [gameTimer2 invalidate];
    gameTimer2 = nil;
    [gameTimer5 invalidate];
    gameTimer5 = nil;
    [gameTimer4 invalidate];
    gameTimer4 = nil;
    [icicleMoveTimer invalidate];
    icicleMoveTimer = nil;
    [icicleGoTimer invalidate];
    icicleGoTimer = nil;
    gameOver.text = @"Game Over";
    
    /*    UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Game Over" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:@"Main Menu",nil, nil];
     if (buttonIndex == 0)
     {
     
     }
     [gameOver show];
     [gameOver release];
     */
    return;
}

//****************************************************
- (void) count
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && ![appDelegate.pausedString isEqual: @"paused"])
    {
        count=0;
        
        //[whoosh play];
        if (x3Bool)
        {
            score+=3;
        }
        else if (x2Bool)
        {
            score+=2;
        }
        else
        {
            score++;
        }
        [scoreString setString:[NSString stringWithFormat:@"Score : %d",score]];
        scorelabel.text = scoreString;
        [scorelabel sizeToFit];
    }
    
    return;
}

//****************************************************
- (void) snowflakeFall
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!paused && (![appDelegate.pausedString isEqual: @"paused"] || gameOverForCC))
    {
        
    if (snowflakea)
    {
        snowflake.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake.center;
        snowflake.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
    if (snowflakea2)
    {
        snowflake2.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake2.center;
        snowflake2.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
    if (snowflakea3)
    {
        snowflake3.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake3.center;
        snowflake3.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
    if (snowflakea4)
    {
        snowflake4.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake4.center;
        snowflake4.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
    if (snowflakea5)
    {
        snowflake5.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake5.center;
        snowflake5.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
    if (snowflakea7)
    {
        snowflake7.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake7.center;
        snowflake7.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
    if (snowflakea6)
    {
        snowflake6.image = [UIImage imageNamed:@"snowflake.png"];
        CGPoint oldCenter = snowflake6.center;
        snowflake6.center = CGPointMake (oldCenter.x, oldCenter.y + SNOWFLAKESMOVEPIXELS);
    }
        /*if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            //I'm running on the iPad
            if (snowflake.center.y>1024)
            {
                snowflake.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake.center;
                snowflake.center = CGPointMake (oldCenter.x, 0);
                snowflakea = NO;
            }
            if (snowflake2.center.y>1024)
            {
                snowflake2.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake2.center;
                snowflake2.center = CGPointMake (oldCenter.x, 0);
                snowflakea2 = NO;
            }
            if (snowflake3.center.y>1024)
            {
                snowflake3.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake3.center;
                snowflake3.center = CGPointMake (oldCenter.x, 0);
                snowflakea3 = NO;
            }
            if (snowflake4.center.y>1024)
            {
                snowflake4.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake4.center;
                snowflake4.center = CGPointMake (oldCenter.x, 0);
                snowflakea4 = NO;
            }
            if (snowflake5.center.y>1024)
            {
                snowflake5.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake5.center;
                snowflake5.center = CGPointMake (oldCenter.x, 0);
                snowflakea5 = NO;
            }
            if (snowflake6.center.y>1024)
            {
                snowflake6.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake6.center;
                snowflake6.center = CGPointMake (oldCenter.x, 0);
                snowflakea6 = NO;
            }
            if (snowflake7.center.y>1024)
            {
                snowflake7.image = [UIImage imageNamed:@"blank.png"];
                CGPoint oldCenter = snowflake7.center;
                snowflake7.center = CGPointMake (oldCenter.x, 0);
                snowflakea7 = NO;
            }
        } else {*/
            //I'm running on the iPhone
    if (snowflake.center.y>500)
    {
        snowflake.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake.center;
        snowflake.center = CGPointMake (oldCenter.x, 0);
        snowflakea = NO;
    }
    if (snowflake2.center.y>500)
    {
        snowflake2.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake2.center;
        snowflake2.center = CGPointMake (oldCenter.x, 0);
        snowflakea2 = NO;
    }
    if (snowflake3.center.y>500)
    {
        snowflake3.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake3.center;
        snowflake3.center = CGPointMake (oldCenter.x, 0);
        snowflakea3 = NO;
    }
    if (snowflake4.center.y>500)
    {
        snowflake4.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake4.center;
        snowflake4.center = CGPointMake (oldCenter.x, 0);
        snowflakea4 = NO;
    }
    if (snowflake5.center.y>500)
    {
        snowflake5.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake5.center;
        snowflake5.center = CGPointMake (oldCenter.x, 0);
        snowflakea5 = NO;
    }
    if (snowflake6.center.y>500)
    {
        snowflake6.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake6.center;
        snowflake6.center = CGPointMake (oldCenter.x, 0);
        snowflakea6 = NO;
    }
    if (snowflake7.center.y>500)
    {
        snowflake7.image = [UIImage imageNamed:@"blank.png"];
        CGPoint oldCenter = snowflake7.center;
        snowflake7.center = CGPointMake (oldCenter.x, 0);
        snowflakea7 = NO;
    }
        //}
    }
    return;
}

//****************************************************
- (void) snowflakeGo
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ((!x3Bool  || gameOverForCC) && (!x2Bool || gameOverForCC) && !paused && (![appDelegate.pausedString isEqual: @"paused"] || gameOverForCC))
    {
        snowflakeCount++;
    }
    if ((!x3Bool  || gameOverForCC) && (!x2Bool || gameOverForCC) && !paused && (![appDelegate.pausedString isEqual: @"paused"] || gameOverForCC)&& snowflakeCount == 5)
    {
        snowflakeCount = 0;
        do {
    j = arc4random() %7;
    
    if (j == 0)
    {
        if (snowflakea)
        {
            snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea = YES;
            snowflakeFallHelp = NO;
        }
    }
    else if (j == 1)
    {
        if (snowflakea2)
        {
        snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea2 = YES;
            snowflakeFallHelp = NO;
        }
        
    }
    else if (j == 2)
    {
        if (snowflakea3)
        {
        snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea3 = YES;
            snowflakeFallHelp = NO;
        }
        
    }
    else if (j == 3)
    {
        if (snowflakea4)
        {
        snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea4 = YES;
            snowflakeFallHelp = NO;
        }
        
    }
    else if (j == 4)
    {
        if (snowflakea5)
        {
        snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea5 = YES;
            snowflakeFallHelp = NO;
        }
        
    }
    else if (j == 5)
    {
        if (snowflakea6)
        {
        snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea6 = YES;
            snowflakeFallHelp = NO;
        }
        
    }
    else if (j == 6)
    {
        if (snowflakea7)
        {
        snowflakeFallHelp = YES;
        }
        else
        {
            snowflakea7 = YES;
            snowflakeFallHelp = NO;
        }
        
    }
        } while (snowflakeFallHelp && snowflakeFrenzy);
    }
    return;
}
//****************************************************
@end
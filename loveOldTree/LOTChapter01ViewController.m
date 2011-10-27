//
//  ChapterOne.m
//  loveOldTree
//
//  Created by  on 11/10/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTChapter01ViewController.h"

@implementation LOTChapter01ViewController

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"神祕樹";
        self.tabBarItem.image = [UIImage imageNamed:@"LOTTabBarChapter01"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc
{
    [myBg release];
    [myMountainfBack release];
    [myMountainfFront release];
    [myTree release];
    [mySeedTitle release];
//    [myFruit release];
//    [myLeaf release];
    [super dealloc];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIAccelerometer *theAccel = [UIAccelerometer sharedAccelerometer];
    
    //設定偵測頻率每秒10次
    theAccel.updateInterval = 1.0f/80.0f;
    
    //設定委派對象給自己（ViewController）
    theAccel.delegate = self;
    
    
    CGRect myBGRect = CGRectMake(0.0f,-75.0f, 360.0f, 525.0f); 
    myBg = [[UIImageView alloc] initWithFrame:myBGRect]; 
    [myBg setImage:[UIImage imageNamed:@"background.png"]]; 
    myBg.opaque = YES; 
    [self.view addSubview:myBg];
    
    CGRect myMountainfBackRect = CGRectMake(0.0f, 295.0f, 132.0f, 160.0f); 
    myMountainfBack = [[UIImageView alloc] initWithFrame:myMountainfBackRect]; 
    [myMountainfBack setImage:[UIImage imageNamed:@"mountainfBack.png"]]; 
    myMountainfBack.opaque = YES; 
    [self.view addSubview:myMountainfBack];
    
    CGRect myMountainfFrontRect = CGRectMake(80.0f, 275.0f, 263.0f, 184.0f); 
    myMountainfFront = [[UIImageView alloc] initWithFrame:myMountainfFrontRect]; 
    [myMountainfFront setImage:[UIImage imageNamed:@"mountainfFront.png"]]; 
    myMountainfFront.opaque = YES; 
    [self.view addSubview:myMountainfFront];
    
    CGRect myTreeRect = CGRectMake(0.0f, 25.0f, 320.0f, 480.0f); 
    myTree = [[UIImageView alloc] initWithFrame:myTreeRect]; 
    [myTree setImage:[UIImage imageNamed:@"treeAndGround.png"]]; 
    myTree.opaque = YES; 
    [self.view addSubview:myTree]; 
    
    CGRect mySeedTitleRect = CGRectMake(285.0f, 5.0f, 30.0f, 80.0f); 
    mySeedTitle = [[UIImageView alloc] initWithFrame:mySeedTitleRect]; 
    [mySeedTitle setImage:[UIImage imageNamed:@"seedTitle.png"]]; 
    mySeedTitle.opaque = YES; 
    [self.view addSubview:mySeedTitle]; 
    
    //＊＊＊＊＊＊＊判斷進入下一回合了與否再設定葉子跟種子樹＊＊＊＊＊＊＊
    
    SearchTreeData *testTrees = [[SearchTreeData alloc]init];
    
    [self setLeaf];
    [self upadteLeaf:[testTrees leafUseNumber]];//傳入葉子顯示數目
    
    [self setFruit];
    [self upadteFruit:[testTrees seedUseNumber]];//傳入葉子顯示數目
    
    [self lotMessage];
    

    
}


-(void)setLeaf
{
    leafXYArray = [NSArray arrayWithObjects:
                   [NSValue valueWithCGPoint:CGPointMake(20.0, 146.0)],
                   [NSValue valueWithCGPoint:CGPointMake(56.0,146.0)], 
                   [NSValue valueWithCGPoint:CGPointMake(71.0, 163.0)],
                   [NSValue valueWithCGPoint:CGPointMake(100.0,136.0)], 
                   [NSValue valueWithCGPoint:CGPointMake(150.0, 73.0)],
                   [NSValue valueWithCGPoint:CGPointMake(80.0, 57.0)],
                   [NSValue valueWithCGPoint:CGPointMake(99.0, 34.0)],
                   [NSValue valueWithCGPoint:CGPointMake(107.0, 73.0)],
                   [NSValue valueWithCGPoint:CGPointMake(122.0, 89.0)],
                   [NSValue valueWithCGPoint:CGPointMake(132.0, 41.0)],
                   [NSValue valueWithCGPoint:CGPointMake(147.0, 24.0)],
                   [NSValue valueWithCGPoint:CGPointMake(180.0, 8.0)],
                   [NSValue valueWithCGPoint:CGPointMake(185.0, 49.0)],
                   [NSValue valueWithCGPoint:CGPointMake(220.0, 24.0)],
                   [NSValue valueWithCGPoint:CGPointMake(257.0, 56.0)],
                   [NSValue valueWithCGPoint:CGPointMake(220.0, 81.0)],
                   [NSValue valueWithCGPoint:CGPointMake(262.0, 113.0)],
                   [NSValue valueWithCGPoint:CGPointMake(220.0, 118.0)],
                   [NSValue valueWithCGPoint:CGPointMake(220.0, 152.0)],
                   [NSValue valueWithCGPoint:CGPointMake(250.0, 141.0)],
                   nil];
}

-(void)setFruit
{
    fruitXYArray = [NSArray arrayWithObjects:
                   [NSValue valueWithCGPoint:CGPointMake(285.0,85.0)],
                   [NSValue valueWithCGPoint:CGPointMake(285.0,110.0)], 
                   [NSValue valueWithCGPoint:CGPointMake(285.0,135.0)],
                   [NSValue valueWithCGPoint:CGPointMake(285.0,160.0)], 
                   [NSValue valueWithCGPoint:CGPointMake(285.0,185.0)],
                   [NSValue valueWithCGPoint:CGPointMake(285.0,210.0)],
                   [NSValue valueWithCGPoint:CGPointMake(285.0,235.0)],
                   [NSValue valueWithCGPoint:CGPointMake(285.0,260.0)],
                   nil];
}

-(void)upadteLeaf:(int)leafInt
{   
    for (int i=0; i<leafInt; i++) {
      NSValue *val = [leafXYArray objectAtIndex:i];
      CGPoint p = [val CGPointValue];
        
        // CGRect myLeafRect = CGRectMake(p.x, p.y, myLeaf.frame.size.width, myLeaf.frame.size.height); 
        myLeaf = [[LOTLeaf alloc] initWithFrame:CGRectMake(p.x,p.y, 30.0, 33.0)];
        [myTree addSubview:myLeaf];
        [myLeaf release];
    }
}

-(void)upadteFruit:(int)fruitInt
{   
    for (int i=0; i<fruitInt; i++) {
        NSValue *val = [fruitXYArray objectAtIndex:i];
        CGPoint p = [val CGPointValue];
         
        myFruit = [[LOTFruit alloc] initWithFrame:CGRectMake(p.x,p.y, 30.0, 25.0)];
        [self.view addSubview:myFruit];
        [myFruit release];
    }
    
}

- (void)lotMessage
{
    
    
    //---建立一個CALayer---
    messageLayer =[[CALayer alloc]init];
    [messageLayer setBounds:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    [messageLayer setPosition:CGPointMake(160.0, 375.0)];
//    UIColor *myAlphaRed=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
//    CGColorRef cgReddish=[myAlphaRed CGColor];
//    [messageLayer setBackgroundColor:cgReddish];
    
    messageLayer.cornerRadius =20.0;//圖層圓角
    messageLayer.shadowOffset = CGSizeMake(0, 3);//設定圖層影子位移距離
    messageLayer.shadowRadius = 5.0;
    messageLayer.shadowColor = [UIColor blackColor].CGColor;
    messageLayer.shadowOpacity = 0.8;
    
    UIImage *img1 =[UIImage imageNamed:@"Icon.png"];
    messageLayer.contents=(id)[img1 CGImage]; //CALayer加上圖片
    [self.view.layer addSublayer:messageLayer]; //加入view的layer裡
    //[messageLayer setZPosition:0]; //ZPosition數字越大越上層
    
    
    textLayer=[[CALayer alloc]init];
    [textLayer setBounds:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    [textLayer setPosition:CGPointMake(0.0, 30.0)];
    textLayer.cornerRadius =10.0;//圖層圓角
    UIColor *myAlphaRed=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    CGColorRef cgReddish=[myAlphaRed CGColor];
    [textLayer setBackgroundColor:cgReddish];
    
    UILabel *myMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 370, 280, 30)];
    myMessageLabel.backgroundColor = [UIColor colorWithWhite:255 alpha:0.0];
    myMessageLabel.text = @" 神祕樹：謝謝你幫我添增新葉^^";
    [self.view.layer addSublayer:myMessageLabel.layer];
//    [textLayer addSublayer:myMessageLabel.layer];
    [messageLayer addSublayer:textLayer];
    [textLayer release];
    
    [textLayer setPosition:CGPointMake(0.0, -300.0)];
    
    
    //[messageLayer addSublayer:textLayer];
//    [messageLayer setZPosition:100];
    
    //---設定aplha淡出動畫校過---
    CABasicAnimation *fader = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    [fader setDuration:1.0];
    [fader setFromValue:[NSNumber numberWithFloat:1.0]];
    [fader setToValue:[NSNumber numberWithFloat:1.0]];
    fader.fillMode = kCAFillModeForwards;//必須寫在addAnimation動畫開始之前
	fader.removedOnCompletion = NO;//必須寫在addAnimation動畫開始之前
    [messageLayer addAnimation:fader forKey:@"opacity"];
    
    //[self.view addSubview:myMessageLabel];
    //    [myMessageLabel release];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIAccelerometer sharedAccelerometer]setDelegate:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//---啟用Accelerometer Sensor---
- (void) accelerometer:(UIAccelerometer *) meter didAccelerate: (UIAcceleration *) accel 
{  
    
    
    float tree_x = 0.0;
    float tree_y =[accel z];
    
    //output_value = rate * input_value + (1.0 - rate) * previous_output_value;
    float sz = 0.1 * tree_y + (1.0 - 0.1) * sz;
    
    
    device = [UIDevice currentDevice] ; 
    
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            //NSLog(@"螢幕朝上平躺");
            mountainfBackTransform =CGAffineTransformIdentity;
            mountainfBackTransform = CGAffineTransformTranslate(mountainfBackTransform, 0, sz*-200-20);
            [myMountainfBack setTransform:mountainfBackTransform];
            [myMountainfBack setNeedsDisplay];
            
            mountainfFrontTransform=CGAffineTransformIdentity;
            mountainfFrontTransform = CGAffineTransformTranslate(mountainfFrontTransform, 0, sz*-300-20);
            [myMountainfFront setTransform:mountainfFrontTransform];
            [myMountainfFront setNeedsDisplay];
            
            treeTransform = CGAffineTransformIdentity;
            treeTransform = CGAffineTransformTranslate(treeTransform, tree_x, sz*-450-20);
            [myTree setTransform:treeTransform];
            [myTree setNeedsDisplay];
            break;
            
        case UIDeviceOrientationFaceDown:
            //NSLog(@"螢幕朝下平躺");
            break;
            
            //系統無法判斷目前Device的方向，有可能是斜置 
        case UIDeviceOrientationUnknown:
            //NSLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            //NSLog(@"螢幕向左橫置");
            break;
            
        case UIDeviceOrientationLandscapeRight:
            //NSLog(@"螢幕向右橫置");
            break;
            
        case UIDeviceOrientationPortrait:
            //NSLog(@"螢幕直立");
            mountainfBackTransform =CGAffineTransformIdentity;
            mountainfBackTransform = CGAffineTransformTranslate(mountainfBackTransform, 0, sz*-200-20);
            [myMountainfBack setTransform:mountainfBackTransform];
            [myMountainfBack setNeedsDisplay];
            
            mountainfFrontTransform=CGAffineTransformIdentity;
            mountainfFrontTransform = CGAffineTransformTranslate(mountainfFrontTransform, 0, sz*-300-20);
            [myMountainfFront setTransform:mountainfFrontTransform];
            [myMountainfFront setNeedsDisplay];
            
            
            treeTransform = CGAffineTransformIdentity;
            treeTransform = CGAffineTransformTranslate(treeTransform, tree_x, sz*-450-20);
            [myTree setTransform:treeTransform];
            [myTree setNeedsDisplay];
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            //NSLog(@"螢幕直立，上下顛倒");
            break;
            
        default:
            //NSLog(@"無法辨識");
            break;
    }
    
    
}


@end

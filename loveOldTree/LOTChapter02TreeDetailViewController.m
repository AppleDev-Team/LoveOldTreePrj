//
//  LOTChapter02TreeDetailViewController.m
//  loveOldTree
//
//  Created by user on 11/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTChapter02TreeDetailViewController.h"
#import "LOTAnnotation.h"
#import "LOTChapter02TreeRouteViewController.h"
#import "SearchTreeData.h"
#import "TheTreesListInMap.h"
#import "LOTChapter01ViewController.h"

@interface LOTChapter02TreeDetailViewController()

@property (nonatomic, retain) LOTAnnotation *incomingAnnotation;

@end

@implementation LOTChapter02TreeDetailViewController
@synthesize tableView;
@synthesize routeButton;
@synthesize collectLeafButton;
@synthesize phoneCallButton;

@synthesize incomingAnnotation;

#define MAX_DISTANCE 300

- (id)init
{
    self = [super init];
    if (self) {
            // Initialization code here.
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
    }
    return self;
}

-(id)initWithMapAnnotation:(id)theAnnotation {
    self = [super initWithNibName:@"LOTChapter02TreeDetailViewController" bundle:[NSBundle bundleForClass:[LOTChapter02TreeDetailViewController class]]];
    self.incomingAnnotation = theAnnotation;

    SearchTreeData *testTrees = [[SearchTreeData alloc] init];
    TheTreesListInMap *treeInfo = [[[TheTreesListInMap alloc] init] autorelease];
    treeInfo = [testTrees searchTreeIndexOfInputTreeID:[NSString stringWithFormat:@"%@", incomingAnnotation.treeId]];
    
    [incomingAnnotation setTreeAddress:treeInfo.treeAddress];
    [incomingAnnotation setTreeAge:treeInfo.treeAge];
    [incomingAnnotation setTreeBackground:treeInfo.treeBackground];
    [incomingAnnotation setTreeBust:treeInfo.treeBust];
    [incomingAnnotation setTreeHeight:treeInfo.treeHight];
    [incomingAnnotation setTreeKind:treeInfo.treeKind];
    [incomingAnnotation setTreeLocation:treeInfo.treeLocation];
    [incomingAnnotation setTreeManagement:treeInfo.treeManagement];
    [incomingAnnotation setTreeShape:treeInfo.treeShape];
    [incomingAnnotation setTreeSource:treeInfo.treeSoutce];
    
    [testTrees release];
    return self;
}

- (void)dealloc
{
    [incomingAnnotation release];
    [tableView release];
    [routeButton release];
    [collectLeafButton release];
    [phoneCallButton release];
    [super dealloc];
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
        // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.incomingAnnotation = nil;
    [self setTableView:nil]; 
    [self setRouteButton:nil];
    [self setCollectLeafButton:nil];
    [self setPhoneCallButton:nil];
    [super viewDidUnload];
        // Release any retained subviews of the main view.
        // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)goRoute:(id)sender {    
    LOTChapter02TreeRouteViewController *routeView = [[LOTChapter02TreeRouteViewController alloc] initWithMapRoute:incomingAnnotation.userCoordinate goalCoordinate:incomingAnnotation.coordinate];
    [self.navigationController pushViewController:routeView animated:YES];
}

    //點選收集樹葉 計算目前距離與樹木距離 若已收集到樹葉 回傳給core data 改變bool值
-(IBAction)collectButton:(id)sender {
    /*CLLocationCoordinate2D coord = incomingAnnotation.userCoordinate; //userlocation 25.041709 121.550127
     
     CLLocationCoordinate2D coord1 = incomingAnnotation.coordinate;
     
     NSLog(@"%f %f \n %f %f", coord.latitude, coord.longitude, coord1.latitude, coord1.longitude);
     
     double distance = [Tools cal2pointWithlatitude1:coord.latitude longitude1:coord.longitude latitude2:coord1.latitude longitude2:coord1.longitude];*/
    
    double distance = [incomingAnnotation.treeDistance doubleValue];
    
    UIAlertView *message;
    if (distance >= MAX_DISTANCE) {
        message = [[UIAlertView alloc] initWithTitle:@"提示"
                                             message:[NSString stringWithFormat:@"距離超過%d公尺，請再靠近點", MAX_DISTANCE]  
                                            delegate:self
                                   cancelButtonTitle:@"OK"  
                                   otherButtonTitles:nil];
    } else {
        message = [[UIAlertView alloc] initWithTitle:@"恭喜你"
                                             message:@"已收集到親親老木葉"  
                                            delegate:self
                                   cancelButtonTitle:@"DONE"  
                                   otherButtonTitles:nil];
    }   
    [message show];  
    [message release];
    
}

-(void)collectLeaf {
    SearchTreeData *testTrees = [[SearchTreeData alloc] init];
    int collectLeafNumber = [testTrees leafUseNumber];
    
    if (collectLeafNumber < 19) {
        [testTrees pluckedTreeID:incomingAnnotation.treeId];
        
    } else if (collectLeafNumber == 19) {
        [testTrees updatdRound];
        
    } else {
        //collectLeafNumber > 19 situation is not allow
        NSLog(@"collectLeaf is not allow ");
    }
    
    NSLog(@"latest round %d, latest leaf %d", [testTrees seedUseNumber], [testTrees leafUseNumber]);
    [testTrees release];
    
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"collectleaf"];
    self.tabBarController.selectedIndex = 0;
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

//alert message
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"OK"]) {
        
    } else if ([title isEqualToString:@"DONE"]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self collectLeaf];
    }
}

//notify button pressed
-(IBAction)notifyPress:(id)sender {
    UIActionSheet *notifySheet = [[UIActionSheet alloc]initWithTitle:@"台北市老樹災害通報" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"撥打 1999 免付費電話" otherButtonTitles:@"發送mail給台北市政府", nil];
//    [notifySheet showInView:self.view];
    [notifySheet showFromTabBar:self.tabBarController.tabBar];
    [notifySheet release];
}

//phone call
-(void)callPhone1999 {
    NSLog(@"call 1999");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:1999"]];
}

-(void)mailToTapiei{
    NSLog(@"mail");
    //設定主旨 
    NSString *subject = @"保護樹木 民眾提報"; 
    //設定內文 
    NSString *text = @"樹木所在位置： 樹木所在位置： 您的姓名： 您的聯絡電話："; 
    //設定收件人的Email並帶入主旨與內文 
    NSString *url = [NSString stringWithFormat:@"mailto://iphone_developer@googlegroups.com?subject=%@&body=%@", subject, text]; 
    //重新格式化字串為UTF8 
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    //直接寄送，不代入主旨及內文
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://iphone_developer@googlegroups.com"]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button index:%i", buttonIndex);
    if (buttonIndex == 0) {
        [self callPhone1999];
    } else if (buttonIndex == 1) {
        [self mailToTapiei];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 1;
            break;
    }
    return 0;
}
 
-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat f;

    if (indexPath.section == 2) {
        CGSize withinSize = CGSizeMake(tableView.frame.size.width, 4000);
            
        CGSize titleSize = [@"描述" sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
            
        CGSize detaillSize = [incomingAnnotation.treeBackground sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
        
        f = titleSize.height + detaillSize.height + 30;
    } else 
        f = theTableView.rowHeight;
        
    return f;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
        // Configure the cell...
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"樹木編號";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"No.%@", incomingAnnotation.treeId];
            } else {
                cell.textLabel.text = @"樹址";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeAddress];
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"樹種";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeKind];
                    break;
                case 1: {
                    cell.textLabel.text = @"樹高";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeHeight];
                } break;
                case 2: {
                    cell.textLabel.text = @"樹齡";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeAge];
                } break;
                case 3: {
                    cell.textLabel.text = @"樹形";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeShape];
                } break;
                case 4: {
                    cell.textLabel.text = @"樹圍";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeBust];
                } break;
            }
            break;
        case 2: {
            cell.textLabel.text = @"描述";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", incomingAnnotation.treeBackground];
            cell.textLabel.numberOfLines = 0;
            cell.detailTextLabel.numberOfLines = 0;

        } break;
            
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

@end

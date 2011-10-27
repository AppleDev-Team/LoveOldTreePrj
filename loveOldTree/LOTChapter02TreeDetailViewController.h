//
//  LOTChapter02TreeDetailViewController.h
//  loveOldTree
//
//  Created by user on 11/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOTChapter02TreeDetailViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate> {
    
    UITableView *tableView;
    UIButton *routeButton;
    UIButton *collectLeafButton;
    UIButton *phoneCallButton;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIButton *routeButton;
@property (nonatomic, retain) IBOutlet UIButton *collectLeafButton;
@property (nonatomic, retain) IBOutlet UIButton *phoneCallButton;

//init with MapAnnotation
-(id)initWithMapAnnotation:(id)theAnnotation;

-(IBAction)goRoute:(id)sender;
-(IBAction)collectButton:(id)sender;
-(IBAction)notifyPress:(id)sender;

@end

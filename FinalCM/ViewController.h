//
//  ViewController.h
//  FinalCM
//
//  Created by Abner Castro Aguilar on 27/10/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLConnectionDataDelegate, NSXMLParserDelegate>

- (IBAction)getDataTest:(UIButton *)sender;

@end


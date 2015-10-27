//
//  ViewController.m
//  FinalCM
//
//  Created by Abner Castro Aguilar on 27/10/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //Web Strings
    NSString *webStringGameList;
    
    NSURLConnection *connection;
    NSMutableData *webData;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    webStringGameList = @"http://www.serverbpw.com/cm/2016-1/list.php";
    NSURL *url = [NSURL URLWithString:webStringGameList];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection)
        webData = [[NSMutableData alloc] init];
}

#pragma mark Connection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"webData: %@", webData);
    NSLog(@"Success!");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Ups! hubo un error");
}

- (IBAction)getDataTest:(UIButton *)sender
{
    
}
@end















































































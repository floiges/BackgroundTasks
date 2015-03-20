//
//  ViewController.m
//  BackgroundTasks
//
//  Created by 224 on 15/3/20.
//  Copyright (c) 2015年 zoomlgd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)fetchDataResult:(fetchBlock) block
{
    
}

//后台传输实现
//1.创建后台传输用的NSURLSession对象
- (NSURLSession *)backgroundSession
{
    //Use dispatch_once_t to create only one background session,if you wang more than one
    //session,do with different identifier
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.yourcompany.appId.BackgtoundSession"];
        session = [NSURLSession sessionWithConfiguration:configuration
                                                delegate:self
                                           delegateQueue:nil];
    });
    return session;
}

//2加入对应的传输用的NSURLSessionTask，并启动下载
- (void)beginDownload
{
    NSURL *downloadURL = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    self.session = [self backgroundSession];
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    [self.downloadTask resume];
}
//3在appDelegate实现handleEventsForBackgroundURLSession：


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
}

@end

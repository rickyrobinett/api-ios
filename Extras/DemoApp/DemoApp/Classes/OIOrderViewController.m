/**
 * Copyright (c) 2012, Tapmates s.r.o. (www.tapmates.com).
 *
 * All rights reserved. This source code can be used only for purposes specified 
 * by the given license contract signed by the rightful deputy of Tapmates s.r.o. 
 * This source code can be used only by the owner of the license.
 * 
 * Any disputes arising in respect of this agreement (license) shall be brought
 * before the Municipal Court of Prague.
 *
 *  @author(s):
 *      Petr Reichl (petr@tapmates.com)
 */
#import "OIOrderViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIOrderViewController()< UITableViewDataSource, UITableViewDelegate >

@property (nonatomic, readwrite, retain) NSArray *dataSet;

-(void)releaseWithDealloc:(BOOL)dealloc;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIOrderViewController {
@private
  UITableView *__tableView;
  NSArray     *__dataSet;
}

@synthesize dataSet = __dataSet;

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];

  self.title = NSLocalizedString( @"Order", "" );

  __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  __tableView.delegate   = self;
  __tableView.dataSource = self;
  [self.view addSubview:__tableView];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [__dataSet count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if ( !cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType  = UITableViewCellAccessoryDetailDisclosureButton;
  }

  return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Memory Management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __tableView );

  if ( dealloc ) {
    OI_RELEASE_SAFELY( __dataSet );
  }
}

- (void)viewDidUnload {
  [self releaseWithDealloc:NO];
  [super viewDidUnload];
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end
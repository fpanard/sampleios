//
//  BluetoothViewController.m
//  Bluetooth
//
//  Created by François PANARD on 17/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "BluetoothViewController.h"

@interface BluetoothViewController ()
{
	GKSession *currentSession;
	IBOutlet UIButton *connexionView;
	IBOutlet UIButton *deconnexionView;
	IBOutlet UITextField *messageView;
}

- (IBAction)connect:(id)sender;
- (IBAction)disconnect:(id)sender;
- (IBAction)send:(id)sender;
@end

@implementation BluetoothViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	connexionView.hidden = NO;
	deconnexionView.hidden = YES;
}

- (void)viewDidUnload
{
	connexionView = nil;
	deconnexionView = nil;
	messageView = nil;
    [super viewDidUnload];
}

- (IBAction)connect:(id)sender
{
	GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
	
	picker.delegate = self;
	picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
	connexionView.hidden = YES;
	deconnexionView.hidden = NO;
	[picker show];
}

- (IBAction)disconnect:(id)sender
{
	[currentSession disconnectFromAllPeers];
	currentSession = nil;
	connexionView.hidden = NO;
	connexionView.hidden = YES;
}

- (IBAction)send:(id)sender
{
	NSData *data = [messageView.text dataUsingEncoding:NSUTF8StringEncoding];

	[self sendDataToPeers:data];
}

- (void)sendDataToPeers:(NSData *)data
{
	if (currentSession)
		[currentSession sendDataToAllPeers:data
							  withDataMode:GKSendDataReliable
									 error:nil];
}

#pragma mark GKPeerPickerControllerDelegate

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
	currentSession = session;
	currentSession.delegate = self;
	[currentSession setDataReceiveHandler:self withContext:nil];
	picker.delegate = nil;
	[picker dismiss];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
	picker.delegate = nil;
	connexionView.hidden = NO;
	deconnexionView.hidden = YES;
}

#pragma mark GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
	switch (state)
	{
		case GKPeerStateConnected:
			NSLog(@"Connecté");
			break;
		case GKPeerStateDisconnected:
			NSLog(@"Déconnecté");
			currentSession = nil;
			connexionView.hidden = NO;
			deconnexionView.hidden = YES;
			break;
		case GKPeerStateConnecting:
			NSLog(@"Connecting");
			break;
		case GKPeerStateAvailable:
			NSLog(@"Available");
			break;
		case GKPeerStateUnavailable:
			NSLog(@"Unavailable");
			break;
	}
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Données reçues" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alert show];
}
@end

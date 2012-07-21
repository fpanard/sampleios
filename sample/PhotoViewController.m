//
//  PhotoViewController.m
//  Phototheque
//
//  Created by François PANARD on 13/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
{
	UIPopoverController *popController;	
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *selectItem;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)selectPhoto:(id)sender;
@end

@implementation PhotoViewController
@synthesize selectItem;
@synthesize imageView;

- (void)viewDidUnload
{
	[self setImageView:nil];
	[self setSelectItem:nil];
    [super viewDidUnload];
}

- (IBAction)selectPhoto:(id)sender
{
	if (popController)
		return;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *controller = [[UIImagePickerController alloc] init];
		
		controller.delegate = self;
		controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
			[self presentModalViewController:controller animated:YES];
		else
		{
			popController = [[UIPopoverController alloc] initWithContentViewController:controller];

			popController.delegate = self;
			[popController presentPopoverFromBarButtonItem:selectItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		}
	}
}

/*
 *	UIImagePickerControllerDelegate
 *
 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
	if (popController)
		[popController dismissPopoverAnimated:YES];
	else
		[self dismissModalViewControllerAnimated:YES];
}

/*
 *	UIPopoverControllerDelegate
 *
 */

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	popController = nil;
}
@end

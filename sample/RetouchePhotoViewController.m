//
//  RetouchePhotoViewController.m
//  RetouchePhoto
//
//  Created by François PANARD on 19/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "RetouchePhotoViewController.h"

@interface RetouchePhotoViewController ()
{
	UIPopoverController *popController;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editItem;

- (IBAction)editPhoto:(id)sender;
@end

@implementation RetouchePhotoViewController
@synthesize imageView;
@synthesize editItem;

- (void)viewDidUnload
{
	[self setImageView:nil];
	[self setEditItem:nil];
    [super viewDidUnload];
}

- (IBAction)editPhoto:(id)sender
{
	if (popController)
		return;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
		
		pickerController.delegate = self;
		pickerController.allowsEditing = YES;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
			[self presentModalViewController:pickerController animated:YES];
		else
		{
			popController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
			
			popController.delegate = self;
			[popController presentPopoverFromBarButtonItem:editItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		}
	}
}

/*
 *	UIImagePickerControllerDelegate
 *
 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSString *basePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *path = [basePath stringByAppendingPathComponent:@"retouche.png"];
	int i = 0;

	imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
	while ([[NSFileManager defaultManager] fileExistsAtPath:path])
		path = [NSString stringWithFormat:@"%@/%@_%d.%@",basePath,@"retouche",++i,@"png"];
	[UIImagePNGRepresentation(imageView.image) writeToFile:path atomically:YES];
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

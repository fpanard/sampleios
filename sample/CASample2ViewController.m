//
//  CASample2ViewController.m
//  CASample2
//
//  Created by François PANARD on 27/08/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CASample2ViewController.h"

static CGFloat kMinX = 0.0f;
static CGFloat kMinY = 0.0f;
static CGFloat kXSlices = 6.0f;
static CGFloat kYSlices = 8.0f;

@implementation CASample2ViewController
@synthesize image = _image;
@synthesize imageLayer = _imageLayer;
@synthesize popController = _popController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.title = @"Confetti";
	self.imageLayer = [CALayer layer];
	self.imageLayer.frame = CGRectMake(kMinX,kMinY,imageView.bounds.size.width,imageView.bounds.size.height);
	self.imageLayer.contentsGravity = kCAGravityResizeAspectFill;
	self.imageLayer.masksToBounds = YES;
	[imageView.layer addSublayer:self.imageLayer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)photo:(id)sender
{
	if (self.popController)
		return;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			self.popController = [[UIPopoverController alloc] initWithContentViewController:picker];
			self.popController.delegate = self;
		}
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		picker.delegate = self;
		picker.allowsEditing = NO;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			[self.popController presentPopoverFromBarButtonItem:photoItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		else
			[self.parentViewController presentModalViewController:picker animated:YES];
	}	
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	self.imageLayer.contents = (__bridge id)drawnImage;
	NSArray *subLayers = [NSArray arrayWithArray:[self.imageLayer sublayers]];
	
	for (CALayer *layer in subLayers)
		[layer removeFromSuperlayer];
}

- (CGPoint)randomDestinationX:(CGFloat)x Y:(CGFloat)y imageSize:(CGSize)size
{
	CGPoint destination;
	
	destination.x = ((CGFloat)(random() % 10000)) / 2000.0f;
	destination.y = ((CGFloat)(random() % 10000)) / 2000.0f;
	if ((x <= (kXSlices / 2.0f)) && (y <= (kYSlices / 2.0f)))
	{
		destination.x *= -50.0f;
		destination.y *= -50.0f;
	}
	else
	if ((x > (kXSlices / 2.0f)) && (y <= (kYSlices / 2.0f)))
	{
		destination.x = size.width + (50.0f * destination.x);
		destination.y *= -50.0f;
	}
	else
	if ((x > (kXSlices / 2.0f)) && (y > (kYSlices / 2.0f)))
	{
		destination.x = size.width + (50.0f * destination.x);
		destination.y = size.height + (50.0f * destination.y);
	}
	else
	{
		destination.x *= -50.0f;
		destination.y = size.height + (50.0f * destination.y);
	}
	return destination;
}

- (CAAnimation *)animationForX:(NSInteger)x Y:(NSInteger)y imageSize:(CGSize)size
{
	CAAnimationGroup *group = [CAAnimationGroup animation];
	
	group.delegate = self;
	group.duration = 2.0f;
	
	CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
	
	opacity.fromValue = [NSNumber numberWithDouble:1.0f];
	opacity.toValue = [NSNumber numberWithDouble:0.0f];
	
	CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
	
	position.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	CGPoint dest = [self randomDestinationX:x Y:y imageSize:size];
	
	position.toValue = [NSValue valueWithCGPoint:dest];
	group.animations = [NSArray arrayWithObjects:opacity,position,nil];
	return group;
}

- (void)pop:(id)sender
{
	if (!self.imageLayer.contents)
		return;
	if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) && self.popController)
		[self.popController dismissPopoverAnimated:YES];
	CGSize imageSize = CGSizeMake(CGImageGetWidth(drawnImage),CGImageGetWidth(drawnImage));
	NSMutableArray *layers = [NSMutableArray array];
	
	for (int x = 0;x < kXSlices;x++)
		for (int y = 0;y < kYSlices;y++)
		{
			CGRect frame = CGRectMake((imageSize.width / kXSlices) * x, (imageSize.height / kYSlices) * y, imageSize.width / kXSlices,imageSize.height / kYSlices);
			CGImageRef subImage = CGImageCreateWithImageInRect(drawnImage, frame);

			if (subImage)
			{
				CALayer *layer = [CALayer layer];
				
				layer.frame = frame;
				layer.actions = [NSDictionary dictionaryWithObject:[self animationForX:x Y:y imageSize:imageSize] forKey:@"opacity"];
				layer.contents = (__bridge id)subImage;
				CFRelease(subImage);
				[layers addObject:layer];
			}
		}
	for (CALayer *layer in layers)
	{
		[self.imageLayer addSublayer:layer];
		layer.opacity = 0.0f;
	}
	self.imageLayer.contents = nil;
}

- (CGImageRef)scaleAndCropImage:(UIImage *)fullImage
{
	CGSize imageSize = fullImage.size;
	CGFloat scale = 1.0f;
	CGImageRef subImage = NULL;
	
	if (imageSize.width > imageSize.height)
	{
		scale = imageView.bounds.size.height / imageSize.height;
		CGFloat offsetX = ((scale * imageSize.width - imageView.bounds.size.width) / 2.0f) / scale;
		CGRect subRect = CGRectMake(offsetX,0.0f,imageSize.width - (2.0f * offsetX),imageSize.height);
		
		subImage = CGImageCreateWithImageInRect([fullImage CGImage],subRect);
	}
	else
	{
		scale = imageView.bounds.size.width / imageSize.width;
		CGFloat offsetY = ((scale * imageSize.height - imageView.bounds.size.height) / 2.0f) / scale;
		CGRect subRect = CGRectMake(0.0f,offsetY,imageSize.width,imageSize.height - (2.0f * offsetY));
		
		subImage = CGImageCreateWithImageInRect([fullImage CGImage],subRect);
	}
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL,imageView.bounds.size.width,imageView.bounds.size.height,8,0,colorSpace,kCGImageAlphaPremultipliedFirst);
	
	CGContextSetInterpolationQuality(context,kCGInterpolationHigh);
	CGRect rect = CGRectMake(0.0f,0.0f,imageView.bounds.size.width,imageView.bounds.size.height);
	
	CGContextDrawImage(context,rect,subImage);
	CGContextFlush(context);
	
	CGImageRef scaledImage = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	CGImageRelease(subImage);
	subImage = NULL;
	subImage = scaledImage;
	return subImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	self.image = image;
	drawnImage = [self scaleAndCropImage:self.image];
	self.imageLayer.contents = (__bridge id)drawnImage;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		[self.popController dismissPopoverAnimated:YES];
		self.popController = nil;
	}
	else
		[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		[self.popController dismissPopoverAnimated:YES];
		self.popController = nil;
	}
	else
		[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	self.popController = nil;
}
@end

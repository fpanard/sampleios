//
//  CASample2ViewController.h
//  CASample2
//
//  Created by François PANARD on 27/08/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CASample2ViewController : UIViewController <UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
	CGImageRef drawnImage;
	IBOutlet UIView *imageView;
	IBOutlet UIBarButtonItem *photoItem;
}

- (IBAction)photo:(id)sender;
- (IBAction)pop:(id)sender;

@property(nonatomic,retain) UIImage *image;
@property(nonatomic,retain) CALayer *imageLayer;
@property(nonatomic,retain) UIPopoverController *popController;
@end

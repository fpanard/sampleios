//
//  DiaporamaView.h
//  Diaporama
//
//  Created by François PANARD on 07/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaporamaView : UIView
{
	NSArray *images;
	UIImageView *leftImageView;
	UIImageView *currentImageView;
	UIImageView *rightImageView;
	NSUInteger currentImage;
	BOOL transition;
	CGFloat debutTransition;
}

- (id)initWithImages:(NSArray *)inImages;
@end

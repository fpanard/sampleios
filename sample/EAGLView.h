//
//  EAGLView.h
//  CASample3
//
//  Created by François PANARD on 29/08/11.
//  Copyright (c) 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface EAGLView : UIView
{
@private
	GLint backingWidth;
	GLint backingHeight;
	GLuint viewRenderBuffer,viewFramebuffer;
	GLuint depthRenderbuffer;
}

@property (nonatomic) NSTimeInterval animationInterval;

- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView;
@end

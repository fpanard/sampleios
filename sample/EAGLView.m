//
//  EAGLView.m
//  CASample3
//
//  Created by François PANARD on 29/08/11.
//  Copyright (c) 2011 FrPa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import "EAGLView.h"

#define USE_DEPTH_BUFFER		0

@interface EAGLView()
@property(nonatomic,retain) EAGLContext *context;
@property(nonatomic,assign) NSTimer *animationTimer;

- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;
@end

@implementation EAGLView
@synthesize context;
@synthesize animationTimer;
@synthesize animationInterval;

+ (Class)layerClass
{
	return [CAEAGLLayer class];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:FALSE],
										kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		if (!context || ![EAGLContext setCurrentContext:context])
			return nil;
		animationInterval = 1.0 / 60.0;
	}
	return self;
}

- (void)dealloc
{
	[self stopAnimation];
	if ([EAGLContext currentContext] == context)
		[EAGLContext setCurrentContext:nil];
	[super dealloc];
}

- (void)layoutSubviews
{
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}

- (BOOL)createFramebuffer
{
	glGenFramebuffersOES(1,&viewFramebuffer);
	glGenRenderbuffersOES(1,&viewRenderBuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES,viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES,viewRenderBuffer);
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer *)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES,GL_COLOR_ATTACHMENT0_OES,GL_RENDERBUFFER_OES,viewRenderBuffer);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES,GL_RENDERBUFFER_WIDTH_OES,&backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES,GL_RENDERBUFFER_HEIGHT_OES,&backingHeight);
	if (USE_DEPTH_BUFFER)
	{
		glGenRenderbuffersOES(1,&depthRenderbuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES,depthRenderbuffer);
		glRenderbufferStorageOES(GL_RENDERBUFFER_OES,GL_DEPTH_COMPONENT16_OES,backingWidth,backingHeight);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES,GL_DEPTH_ATTACHMENT_OES,GL_RENDERBUFFER_OES,depthRenderbuffer);
	}
	if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x",glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	return YES;
}

- (void)destroyFramebuffer
{
	glDeleteFramebuffersOES(1,&viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1,&viewRenderBuffer);
	viewRenderBuffer = 0;
	if (depthRenderbuffer)
	{
		glDeleteRenderbuffersOES(1,&depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}

- (void)setAnimationInterval:(NSTimeInterval)interval
{
	animationInterval = interval;
	if (animationTimer)
	{
		[self stopAnimation];
		[self startAnimation];
	}
}

- (void)startAnimation
{
	animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(drawView) userInfo:nil repeats:YES];
}

- (void)stopAnimation
{
	animationTimer = nil;
}

- (void)drawView
{
	const GLfloat squareVertices[] = 
	{
		-0.5f,-0.5f,
		0.5f,-0.5f,
		-0.5f,0.5f,
		0.5f,0.5f
	};
	const GLubyte squareColors[] =
	{
		255,255,0,255,
		0,255,255,255,
		0,0,0,0,
		255,0,255,255
	};
	
	[EAGLContext setCurrentContext:context];
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES,viewFramebuffer);
	glViewport(0,0,backingWidth,backingHeight);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrthof(-1.0f,1.0f,-1.5f,1.5f,-1.0f,1.0f);
	glMatrixMode(GL_MODELVIEW);
	glRotatef(3.0f,0.0f,0.0f,1.0f);
	glClearColor(0.5f,0.5f,0.5f,1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	glVertexPointer(2,GL_FLOAT,0,squareVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(4,GL_UNSIGNED_BYTE,0,squareColors);
	glEnableClientState(GL_COLOR_ARRAY);
	glDrawArrays(GL_TRIANGLE_STRIP,0,4);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES,viewRenderBuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}
@end

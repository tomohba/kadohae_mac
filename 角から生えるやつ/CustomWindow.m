#import "CustomWindow.h"
#import "CustomView.h"

#import <AppKit/AppKit.h>

@interface CustomWindow ()

@property (weak) IBOutlet CustomView *customView;

@end

@implementation CustomWindow

@synthesize initialLocation;

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag {
    
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    if (self != nil) {
        [self setAlphaValue:0.0];
        [self setOpaque:NO];
        [self setIgnoresMouseEvents:YES];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    return NO;
}

- (void)startMainAnimation {
    if (self.customView != nil) {
        [self.customView startMainAnimation];
    }
}

@end

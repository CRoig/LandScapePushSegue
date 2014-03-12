//
//  CustomPushSegue.m
//  LandScapePushSegue
//
//  Created by Carles Roig (ATIC) on 10/03/14.
//  Copyright (c) 2014 Carles Roig (ATIC). All rights reserved.
//


#import "CustomPushSegue.h"

@implementation CustomPushSegue

- (void)perform {
    //Get References
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    UIView *sourceView = [sourceViewController view];
    UIView *destinationView = [destinationViewController view];
    
    //Create sourceView snapShot.
    UIImageView *sourceImageView;
    UIGraphicsBeginImageContextWithOptions(sourceView.bounds.size, NO, 0);
    [sourceView.layer renderInContext:UIGraphicsGetCurrentContext()];
    sourceImageView = [[UIImageView alloc] initWithImage: UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    
    //NOTE: Obtain view controller size. This is the issue when performing a custom segue in landscape mode. Since the inferred orientation is portrait, the height and width are alternated. One solution is fix the screenWidth and screenHeight manually. In this case, my view size is 1024 width and 768 height in ladnscape mode.
    CGFloat screenWidth = 1024;
    CGFloat screenHeight = 768;
    
    //Set the final position of the views.
    destinationView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    sourceView.frame = CGRectMake(-screenWidth,0, screenWidth, screenHeight);
    
    //Create destinationView snapShot.
    UIImageView *destinationImageView;
    UIGraphicsBeginImageContextWithOptions(destinationView.bounds.size, NO, 0);
    [destinationView.layer renderInContext:UIGraphicsGetCurrentContext()];
    destinationImageView = [[UIImageView alloc] initWithImage: UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    
    //Set the initial position of the views.
    //Create the offset rectangles. Since the movement is right to left, the offset is moved the size of the window to the right.
    CGRect finalFrameD = destinationView.frame;
    CGRect offsetFrameD = CGRectOffset(finalFrameD, finalFrameD.size.width, 0);
    CGRect finalFrameS = sourceView.frame;
    CGRect offsetFrameS = CGRectOffset(finalFrameS, finalFrameS.size.width, 0);
    destinationImageView.frame = offsetFrameD;
    sourceImageView.frame = offsetFrameS;
    
    //ViewController replacement
    [self.sourceViewController presentModalViewController:self.destinationViewController animated:NO];
    
    //Overpose the snapShot who will simulate the transition between vies.
    [destinationView addSubview: sourceImageView];
    [destinationView addSubview: destinationImageView];
    
    void (^animations)(void) = ^{
        //Move vies to the final Position
        [destinationImageView setFrame: finalFrameD];
        [sourceImageView setFrame: finalFrameS];
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        if (finished) {
            //Remove the snapshots from view. Therefore the destinationViewController is shown.
            [sourceImageView removeFromSuperview];
            [destinationImageView removeFromSuperview];
        }
    };
    
    [UIView animateWithDuration:2.0 delay:.0 options:UIViewAnimationOptionCurveEaseOut animations:animations completion:completion];
}

@end

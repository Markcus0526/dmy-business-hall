//
//  VideoPlayViewController.h
//  YiDong
//
//  Created by Admin on 2/3/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayViewController : SuperViewController<GeneralSvcDelegate>
{
    MPMoviePlayerController *mMoviePlayer;
}
@property (weak, nonatomic) IBOutlet UIView *videoPlayView;
- (IBAction)onTapClickVideoView:(id)sender;

@end

//
//  FSViewController.m
//  FSMediaPicker
//
//  Created by Wenchao Ding on 03/02/2015.
//  Copyright (c) 2014 Wenchao Ding. All rights reserved.
//

#import "FSViewController.h"
#import "FSMediaPicker.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FSViewController () <FSMediaPickerDelegate>

@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation FSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _player = [[MPMoviePlayerController alloc] init];
    _player.view.frame = _movieContainer.bounds;
    [_movieContainer addSubview:_player.view];

}

- (IBAction)showClicked:(id)sender
{
    FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] init];
    mediaPicker.mediaType = (FSMediaType)_mediaTypeControl.selectedSegmentIndex;
    mediaPicker.editMode = (FSEditMode)_editModeControl.selectedSegmentIndex;
    mediaPicker.delegate = self;
    [mediaPicker showFromView:sender];
}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    if (mediaInfo.mediaType == FSMediaTypeVideo) {
        self.player.contentURL = mediaInfo.mediaURL;
        [self.player play];
    } else {
        [self.imageButton setTitle:nil forState:UIControlStateNormal];
        [self.imageButton setImage:mediaPicker.editMode == FSEditModeCircular? mediaInfo.circularEditedImage:mediaInfo.editedImage forState:UIControlStateNormal];
    }
}

- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    NSLog(@"%s",__FUNCTION__);
}

@end

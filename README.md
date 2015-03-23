# FSMediaPicker

[![Version](https://img.shields.io/cocoapods/v/FSMediaPicker.svg?style=flat)](http://cocoadocs.org/docsets/FSMediaPicker)
[![License](https://img.shields.io/cocoapods/l/FSMediaPicker.svg?style=flat)](http://cocoadocs.org/docsets/FSMediaPicker)
[![Platform](https://img.shields.io/cocoapods/p/FSMediaPicker.svg?style=flat)](http://cocoadocs.org/docsets/FSMediaPicker)

![fsmediapicker-edit](https://cloud.githubusercontent.com/assets/5186464/6525012/1544d590-c43b-11e4-8ed2-8cf8eef14009.gif)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ![fsmediapicker-circular-edited](https://cloud.githubusercontent.com/assets/5186464/6524931/11bfd51a-c43a-11e4-8197-ced99a29df69.gif)

## Purpose

### How would we pick a image from device before

```objective-c

@interface OriginalViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)pickButtonClicked:(id)sender;

@end

@implementation OriginalViewController

- (void)pickButtonClicked:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                            delegate:self 
                                                            cancelButtonTitle:@"Cancel" 
                                                            destructiveButtonTitle:nil 
                                                            otherButtonTitles:@"Take photo",
                                                                              @"Select photo from camera", nil];
    actionSheet.cancelButtonIndex = 2;
    [actionSheet showInView:sender];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    };
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageView.image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
```

Why would I write such a long page just for a tiny little image?!
![why](http://cdn1.raywenderlich.com/wp-content/uploads/2012/09/Rage-why.png)

### With FSMediaPicker

```objective-c

@interface MediaPickerController : UIViewController <FSMediaPickerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)pickButtonClicked:(id)sender;

@end

@implementation MediaPickerController

- (void)pickButtonClicked:(id)sender
{
    FSMediaPicker *picker = [[FSMediaPicker alloc] init];
    picker.delegate = self;
    [picker showFromView: sender];
}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    self.imageView.image = mediaInfo.editedImage; // Or mediaInfo[UIImagePickerControllerEditedImage]
}

@end
```

FSMediaPicker can handle the all borthering part for you


## What's more

## To Pick a video

```objective-c
mediaPicker.type = FSMediaTypeVideo // default is FSMediaTypePhoto

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    self.videoURL = mediaInfo.mediaURL; // Or mediaInfo[UIImagePickerControllerMediaURL]
}
```

![fsmediapicker-type-video](https://cloud.githubusercontent.com/assets/5186464/6525055/b20b75be-c43b-11e4-93eb-a0297157dd79.png)

## To pick both image && video:
```objective-c
mediaPicker.mediaType = FSMediaTypeAll

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
    if (mediaInfo.mediaType == FSMediaTypeVideo) { // Or [mediaInfo[UIImagePickerControllerMediaType] isEqualToString:(NSString)kUTTypeMovie];
        NSURL *url = mediaInfo.mediaURL; // Or mediaInfo[UIImagePickerControllerMediaURL]
    } else if (mediaInfo.mediaType == FSMediaTypePhoto) { // Or [mediaInfo[UIImagePickerControllerMediaType] isEqualToString:(NSString)kUTTypeImage];
        UIImage *someImage = mediaInfo.editedImage // Or mediaInfo[UIImagePickerControllerEditedImage]
    }
}
```

![fsmediapicker-type-all](https://cloud.githubusercontent.com/assets/5186464/6525058/bc2e6736-c43b-11e4-811c-5d3f3ba82e26.png)

## Some spices

### Circular crop
```objective-c
mediaPicker.editMode = FSEditModeCircular; // defualt is FSEditModeStandard

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    imageView.image = mediaInfo.circularEditedImage; // Or mediaInfo[UIImagePickerControllerCircularEditedImage]
}
```

* The `mediaInfo` NSDictionary contains both the `editedImage` and the `circularEditedImage` no matter what the `editMode` is. This setting because some app just displays the circularImage but needs to save the rectangle image on device or the server

### Customized setting of UIImagePickerController:

```objective-c
- (void)mediaPicker:(FSMediaPicker *)mediaPicker willPresentImagePickerController:(UIImagePickerController *)imagePicker
{
    if ([imagePicker.sourceType isEqualToString:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.showsCameraControl = NO;
        imagePicker.cameraOverlayView = yourCustomOverlayView;
    }
}
```

### When cancel

```objective-c
- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    // do something
}
```
This delegate method will be called on either when the UIActionSheet cancel or when the UIImagePickerController cancel

### Block support

```objective-c
@property (copy, nonatomic) void(^willPresentImagePickerBlock)(FSMediaPicker *mediaPicker, UIImagePickerController *imagePicker);
@property (copy, nonatomic) void(^finishBlock)(FSMediaPicker *mediaPicker, NSDictionary *mediaInfo);
@property (copy, nonatomic) void(^cancelBlock)(FSMediaPicker *mediaPicker);
```

### 中文选项
* 如果系统语言设置为中文并且Project下的Localization下包含`Chinese`，则选项中的文字显示为中文
* 
![localization](https://cloud.githubusercontent.com/assets/5186464/6525144/dba46592-c43c-11e4-8115-d4f17e382d43.png)
![fsmediapicker-chinese](https://cloud.githubusercontent.com/assets/5186464/6525153/0de85dec-c43d-11e4-9b73-298bd2fa9b9a.png)

* 如果觉得文字不够高大上，在FSMediaPicker.m中开头的几个macro中设置对应文字. 

```objective-c
// change the option string here
#define kTakePhotoString LocalizedString(@"Take photo")
#define kSelectPhotoFromLibraryString LocalizedString(@"Select photo from photo library")
#define kRecordVideoString LocalizedString(@"Record video")
#define kSelectVideoFromLibraryString LocalizedString(@"Select video from photo library")
#define kCancelString LocalizedString(@"Cancel")
```

## Install

### set up

* cocoapods: To run the example project, clone the repo, and run `pod install` from the Example directory first.
* manually: drag `FSMediaPicker.h` and `FSMediaPicker.m` in FSMediaPicker-master/Pod/Classes to your project, make sure to check `copy items if needed` 

### then

```objective-c
#import "FSMediaPicker.h"
```

## Requirements

iOS 7.0

## Contribution

* Issue me, or send it to `f33chobits@gmail.com`
* Fork and send pull request

## Author

Wenchao Ding, f33chobits@gmail.com

## License

FSMediaPicker is available under the MIT license. See the LICENSE file for more info.


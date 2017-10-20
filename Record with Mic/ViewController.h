#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;


- (IBAction)recordAction:(id)sender;

- (IBAction)playAction:(id)sender;

- (IBAction)stopAction:(id)sender;

@end


#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Set the audio file
    NSArray *path = [NSArray arrayWithObjects:
                      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                      lastObject], @"myAudio.m4a",  nil];
    
    NSURL *filURL = [NSURL fileURLWithPathComponents:path];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat: 44100.0] forKey: AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey: AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    _recorder = [[AVAudioRecorder alloc] initWithURL:filURL
                                            settings:recordSetting
                                               error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
}



- (IBAction)recordAction:(id)sender {
    if (_player.playing) {
        [_player stop];
    }

    if (!_recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [_recorder record];
        [_recordButton setTitle:@"Pause" forState:UIControlStateNormal];
        [_recordButton setBackgroundColor:[UIColor redColor]];
        
    } else {
        // Pause recording
        [_recorder pause];
        [_recordButton setTitle:@"Record" forState:UIControlStateNormal];
        [_recordButton setBackgroundColor:[UIColor purpleColor]];
    }
}

- (IBAction)playAction:(id)sender {
    if (!_recorder.recording){
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_recorder.url error:nil];
        [_player setDelegate:self];
        [_player play];
    }
}

- (IBAction)stopAction:(id)sender {
    [_recorder stop];

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}



- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [_recordButton setTitle:@"Record" forState:UIControlStateNormal];
    [_recordButton setBackgroundColor:[UIColor purpleColor]];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Done"
                                                                   message:@"That's it folks"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}

@end

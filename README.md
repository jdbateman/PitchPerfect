# PitchPerfect
My first Swift app for iOS 8 uses AVFoundation to record, save, modify, and play audio files using a UINavigationController style app.

## Implementation Highlights

* AVFoundation framework
* UIViewController for presentation
* UINavigationController for navigation
* AVAudioEngine and AVAudioPlayer for implementing audio effects


## Screenshots

### Record

Press the play button to record audio.

![Record](/../screenshots/screenshots/PitchPerfect_screenshot_record.png?raw=true "Record")

* AVAudioSession and AVAudioRecorder to capture and save audio.

The layout supports both Landscape and Portrait orientations.

![Landscape Orientation](/../screenshots/screenshots/PitchPerfect_screenshot_rotated.png?raw=true "Landscape Orientation")

### Recording

Press the stop button to stop recording audio and save the audio data to an audio file on the file system.

![Recording](/../screenshots/screenshots/PitchPerfect_screenshot_recording.png?raw=true "Recording")

* AVAudioRecorderDelegate to detect playback is complete and performSegueWithIdentifier to transition to the Playback view.

### Playback

Select an audio effect to apply to the recorded audio and play it back.

![Playback](/../screenshots/screenshots/PitchPerfect_screenshot_play.png?raw=true "Playback")

* AVAudioEngine and AVAudioPlayer are used to implement pitch and speed effects.

### Playing

Select the stop button to halt playback. Or, select another button to apply a new audio effect and restart playback.

![Playing](/../screenshots/screenshots/PitchPerfect_screenshot_playing.png?raw=true "Playing")

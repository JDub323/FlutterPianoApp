#include "MicrophoneListenerTests.h"

#include <cstdio>
#include <cstdlib>
#include <iostream>

#include "../../../lib/portaudio/include/portaudio.h"
#include "../MicrophoneListener.h"

int MicrophoneListenerTests::paTestCallback(
    const void* inputBuffer, void* outputBuffer, unsigned long framesPerBuffer,
    const PaStreamCallbackTimeInfo* timeInfo, PaStreamCallbackFlags statusFlags,
    void* userData) {
    float* in = (float*)inputBuffer;
    (void)outputBuffer;

    int displaySize = 50;

    float volume = 0;
    for (unsigned long i = 0; i < 2 * framesPerBuffer; i += 2) {
        volume = std::max(volume, in[i]);
    }

    printf("\r");
    printf("Volume: %f\n", volume);

    for (int i = 0; i < displaySize; i++) {
        if (volume > i / (float)displaySize) {
            printf("H");
        } else {
            printf(" ");
        }
    }

    fflush(stdout);

    return 0;
}

void MicrophoneListenerTests::volumeTest(double volume) {
    constexpr int displaySize = 50;
    for (int i = 0; i < displaySize; i++) {
        if (volume > i / (float)displaySize) {
            printf("H");
        } else {
            printf(" ");
        }
    }
}

int main() {
    // constexpr int device = 1;
    // MicrophoneListener::connectToMic();
    // MicrophoneListener::startRecording(MicrophoneListenerTests::paTestCallback,
    //                                    device);
    // Pa_Sleep(10 * 1000);  // 10 seconds
    // MicrophoneListener::pauseRecording();
    // MicrophoneListener::quitRecording();
    printf("Hello World");
    return EXIT_SUCCESS;
}
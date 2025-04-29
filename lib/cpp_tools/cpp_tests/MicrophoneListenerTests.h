#pragma once
#include "../../../lib/portaudio/include/portaudio.h"

class MicrophoneListenerTests {
   public:
    static int paTestCallback(const void* inputBuffer, void* outputBuffer,
                              unsigned long framesPerBuffer,
                              const PaStreamCallbackTimeInfo* timeInfo,
                              PaStreamCallbackFlags statusFlags,
                              void* userData);
    static void volumeTest(double volume);
};

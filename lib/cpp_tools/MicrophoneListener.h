#pragma once
#include "../../lib/portaudio/include/portaudio.h"

typedef int (PaCallbackFunction)(const void* inputBuffer, void* outputBuffer,
                                unsigned long framesPerBuffer,
                                const PaStreamCallbackTimeInfo* timeInfo,
                                PaStreamCallbackFlags statusFlags,
                                void* userData);
class MicrophoneListener {
   public:
    static void connectToMic();
    static void startRecording(PaCallbackFunction* callbackFunction, int device);
    static void pauseRecording();
    static void quitRecording();
};
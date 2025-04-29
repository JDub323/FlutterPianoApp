#include "MicrophoneListener.h"

#include <cstdio>
#include <cstdlib>

#include <iostream>

#include "cpp_tests/MicrophoneListenerTests.h"

#define SAMPLE_RATE 44100
#define FRAMES_PER_BUFFER 512

PaStream* stream;
static void checkError(PaError error);
// static int paTestCallback(const void* inputBuffer, void* outputBuffer,
//                           unsigned long framesPerBuffer,
//                           const PaStreamCallbackTimeInfo* timeInfo,
//                           PaStreamCallbackFlags statusFlags, void* userData);

void MicrophoneListener::connectToMic() {
    PaError error;
    error = Pa_Initialize();
    checkError(error);

    int numDevices = Pa_GetDeviceCount();
    printf("Number of Devices: %d\n", numDevices);

    if (numDevices < 0) {
        printf("error getting device count");
        exit(EXIT_FAILURE);
    } if (numDevices == 0) {
        printf("No devices found on this machine");
        exit(EXIT_SUCCESS);
    }

    for (int i = 0; i < numDevices; i++) {
        const PaDeviceInfo *deviceInfo = Pa_GetDeviceInfo(i);
        printf("Device: %d\n", i);
        printf("   Name: %s\n", deviceInfo->name);
        printf("   MaxInputChannels %d\n", deviceInfo->maxInputChannels);
        printf("   MaxOutputChannels %d\n", deviceInfo->maxOutputChannels);
        printf("   DefaultSampleRate %f\n", deviceInfo->defaultSampleRate);
    }

    Pa_Sleep(10000);  // 10 seconds
}

void MicrophoneListener::startRecording(const PaCallbackFunction* callbackFunction,const int device) {  // if this doesn't work, first check for errors with this pointer
    PaError error;
    PaStreamParameters inputParameters = {};

    inputParameters.channelCount = 1;
    inputParameters.device = device;
    inputParameters.hostApiSpecificStreamInfo = NULL;
    inputParameters.sampleFormat = paFloat32;
    inputParameters.suggestedLatency =
        Pa_GetDeviceInfo(device)->defaultLowInputLatency;

    PaStreamParameters outputParameters = {};
    outputParameters.channelCount = 1;
    outputParameters.device = device;
    outputParameters.hostApiSpecificStreamInfo = NULL;
    outputParameters.sampleFormat = paFloat32;
    outputParameters.suggestedLatency =
        Pa_GetDeviceInfo(device)->defaultLowInputLatency;

    error =
        Pa_OpenStream(&stream, &inputParameters, &outputParameters, SAMPLE_RATE,
                      FRAMES_PER_BUFFER, paNoFlag, *callbackFunction, NULL);
    checkError(error);
    // since stream is a variable in a different scope and a pointer there could
    // be a hard-to-find error where stream memory is overwritten but the stream
    // pointer still remains stale reference manipulation
    error = Pa_StartStream(stream);
    checkError(error);
}

void MicrophoneListener::pauseRecording() {
    PaError error;
    error = Pa_StopStream(stream);
    checkError(error);
}

void MicrophoneListener::quitRecording() {
    PaError error;
    error = Pa_CloseStream(stream);
    checkError(error);

    error = Pa_Terminate();
    checkError(error);
}

static void checkError(PaError error) {
    if (error != paNoError) {
        printf("PortAudio Error: %s\n", Pa_GetErrorText(error));
        exit(EXIT_FAILURE);
    }
}

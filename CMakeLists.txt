cmake_minimum_required(VERSION 3.10)
project(MyCppProject)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_VERBOSE_MAKEFILE ON)

add_executable(my_executable
        lib/cpp_tools/cpp_tests/MicrophoneListenerTests.cpp
        lib/cpp_tools/DartCommunicator.cpp
        lib/cpp_tools/MicrophoneListener.cpp
        lib/cpp_tools/MicrophoneListener.cpp
)


include_directories(
        ${PROJECT_SOURCE_DIR}/lib/portaudio/include
        ${PROJECT_SOURCE_DIR}/lib/cpp_tools
)
find_package(FFTW3 CONFIG REQUIRED)
target_link_libraries(main PRIVATE FFTW3::fftw3)
target_link_libraries(my_executable PRIVATE
        ${PROJECT_SOURCE_DIR}/lib/portaudio/lib/.libs/libportaudio.a
)

# Flutter Piano App

This repository contains the **Flutter frontend** for a mobile application designed to analyze live piano playing and provide real-time visual feedback.

The frontend works together with a **C++ backend** (separate repository) that performs the actual audio analysis and note detection.

## Project Overview

The main goals of the Flutter frontend are:
- Create a smooth, responsive, cross-platform mobile app.
- Display live note information detected by the backend.
- Build an intuitive and visually engaging interface, similar to apps like Synthesia.
- Eventually offer detailed feedback on piano performances.

## Current Status

- Basic Flutter project setup complete.
- Working toward integrating with the C++ backend via platform channels or FFI (Foreign Function Interface).
- Planning the initial designs for live visualizations of played notes.

## Next Steps

- Connect the Flutter app to the C++ backend to receive real-time note data.
- Build a basic "live visualization" screen that shows which keys are being played in real time.
- Polish the interface for speed, clarity, and ease of use.

## Project Outlook

Development on this project is **currently paused**, but the goal is to return once the backend is functional enough for real-time note detection.

Ultimately, I hope to turn this into a powerful tool for **revolutionizing piano practice**, offering:
- Real-time feedback
- Smart practice suggestions
- Visual performance summaries
- Interactive learning features

## Technologies Used

- **Flutter** — Cross-platform frontend framework (iOS, Android)
- **C++ backend** — Real-time audio analysis (separate repository)
- **Dart** — Primary programming language for Flutter

## License

This project is currently private and under active development. Licensing terms will be decided closer to the final release.

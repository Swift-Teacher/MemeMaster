# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MemeMaster is an iOS educational meme-creation app built with Swift and UIKit. It's part of Apple's "Develop in Swift" curriculum (AP CS Principles and Explorations courses). Users can select photos from their Photo Library, add predefined captions, and save/share their memes.

## Build and Run

Open `MemeMaker.xcodeproj` in Xcode and run with Cmd+R. The app requires iOS Simulator or a physical iOS device.

No external dependencies (CocoaPods, SPM, or Carthage).

## Architecture

**Pattern**: Single-view MVC with Storyboard-based UI

**Key Files** (in `MemeMaker/`):
- `ViewController.swift` - All UI logic, image handling, meme rendering, and sharing
- `CaptionOption.swift` - Simple struct model (emoji + caption string)
- `Main.storyboard` - Complete UI layout via Interface Builder

**Core Functionality**:
- Photo import via `UIImagePickerController`
- Text rendering onto images using `UIGraphicsImageRenderer` with attributed strings
- Save to Photos via `UIImageWriteToSavedPhotosAlbum` with Obj-C bridge callback
- Share via `UIActivityViewController`
- Caption repositioning via `UIPanGestureRecognizer`

**Text Rendering Config** (in ViewController):
- Font: Avenir Next Heavy, 70pt
- Style: White text with black stroke (-2.0 width)

**Required Permissions** (configured in Info.plist):
- Photo Library Read Access
- Photo Library Write Access

## Educational Context

This is a teaching project following Apple's Activate-Explore-Apply framework. The README contains a complete step-by-step tutorial for building the app from scratch, including Git branching workflow for feature development.

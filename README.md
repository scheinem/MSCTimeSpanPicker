MSCTimeSpanPicker
=================

Picker for selecting a time span using native UIPickerView. It's customizable using UIAppearance, localizable, brings it's own delegate for efficient and fast integration in exisiting projects and uses ARC.

![Screenshot](https://raw.github.com/scheinem/MSCTimeSpanPicker/master/MSCTimeSpanPicker.png)

## Integration

```objective-c
MSCTimeSpanPicker *timeSpanPicker = [[MSCTimeSpanPicker alloc] init];
timeSpanPicker.delegate = self;
    
// Set the frame so that the MSCTimeSpanPicker appears on the bottom.
CGRect timeSpanPickerFrame = timeSpanPicker.frame;
timeSpanPickerFrame.origin.y = self.rootViewController.view.frame.size.height - timeSpanPickerFrame.size.height;
timeSpanPicker.frame = timeSpanPickerFrame;
    
[self.view addSubview:timeSpanPicker];
```

## Add to your project

1. Add MSCTimeSpanPicker.xcodeproj as subproject.
2. Add MSCTimeSpanPicker's root folder to your project's header search paths.
3. Add MSCTimeSpanPicker to your target's dependencies (Target >> Build Phases >> Target Dependencies).
4. Add MSCTimeSpanPicker to your target's linked frameworks (Target >> Summary >> Linked Frameworks and Libraries).
5. Add MSCTimeSpanPickerResources to your target's dependencies (Target >> Build Phases >> Target Dependencies).
6. Add MSCTimeSpanPickerResources.bundle to your target's copied bundle resources (Drag the bundle from MSCTimeSpanPicker.xcodeproj/Products/ and drop it onto 'Target >> Build Phases >> Copy Bundle Resources').
5. Import "MSCTimeSpanPicker.h" either in Prefix.pch or seperatly in any file you use it.

## Delegate

### "to" and/or "from" got changed by rotating one of the wheels.

```objective-c
- (void)timeSpanPicker:(MSCTimeSpanPicker *)timeSpanPicker selectedFrom:(NSDate *)from andTo:(NSDate *)to;
```

### MSCTimeSpanPicker got dismissed by pressing the "Cancel" button

```objective-c
- (void)timeSpanPickerCancelled:(MSCTimeSpanPicker *)timeSpanPicker;
```

### MSCTimeSpanPicker got dismissed by pressing the "Save" button

```objective-c
- (void)timeSpanPickerSaved:(MSCTimeSpanPicker *)timeSpanPicker;
```

## Customizing using UIAppearance

MSCTimeSpanPicker only uses UIToolbar, UIBarButtonItem and UIPickerView so it's fully compatible to UIAppearance, e.g.:

```objective-c
[[UIToolbar appearanceWhenContainedIn:[MSCTimeSpanPicker class], nil] setBarStyle:UIBarStyleBlack];
```

## Localization

MSCTimeSpanPicker is localizable using Localizable.strings contained in MSCTimeSpanPickerResources.bundle.

## Credits

MSCTimeSpanPicker was created by [Manfred Scheiner](https://github.com/scheinem/) ([@scheinem](http://twitter.com/scheinem) - [scheinem.com](http://scheinem.com)).

## License

MSCTimeSpanPicker is available under the MIT license. See the LICENSE file for more info.
For usage without attribution contact [Manfred Scheiner](mailto:sayhi@scheinem.com).

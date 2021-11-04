---
title: Definition of Done
permalink: Develop/Apps/UI/Definition_of_Done/
parent: UI
grand_parent: Apps
layout: default
nav_order: 100
---

When you've developed a new feature, fixed a bug or generally have a contribution to the Sailfish OS UI then this checklist can help you get it accepted:

  - Code has been reviewed and approved by the area maintainer, preferably with UI development background
  - Any user-facing changes have been reviewed and approved by Jolla design.
  - Code matches the design in pixel perfection.
      - Pixel accuracy is easy in QML, no reason to be lazy.
      - Icons, backgrounds, margins, colors, fonts match platform style.
      - Implementation matches the design and overall platform style.
  - Implemented UI performs smoothly on the device.
      - There are no abrupt jumps, stutters or other noticeable drops in the frame rate during interaction.
      - Introduced changes do not compromise the application or page loading times.
      - All UI state transitions are fluid and smoothly animated.
      - Use the available [performance tools] to measure and analyze the perfomance.
      - Application memory consumption stays reasonable (e.g. measure with [smem](http://www.selenic.com/smem)).
      - UI scales gracefully to a lot of data points.
  - Feature is feature complete.
      - No states that look unfinished or stand out in a bad way.
      - No empty views, dummy or other-wise temporary development data.
      - User is offered actions to recover from possible errors like no network or data corruption.
  - Text contain working translation hooks.
  - Fonts, colors, margins and other layout parameters come from the [Silica](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-theme.html) to guarantee scalability and consistent platform look&feel.
  - Feature has unit tests that test the internal states and imperative functions.
  - Existing component tests pass.
  - Changes don't cause regression elsewhere, are tested by contributor and verified by the reviewer.
  - Code is committed to the source control and successfully built in OBS.

## Further recommendations

  - Develop and test features on a real device.
  - Expect multiple rounds of design review until the experience is polished enough.
  - When unsure how a feature should behave it is a good idea to check how similar use cases have been implemented in existing Sailfish applications.
  - When QML fails to perform, be prepared to write the problematic parts in lower level C/C++ and GLSL OpenGL shading language.
  - Unless you have done already read all the [Qt Quick documentation](http://doc.qt.io/qt-5/qtquick-index.html) you find in the Qt documentation pages.
  - Read official [Qt performance documentation](http://doc.qt.io/qt-5/qtquick-performance.html). Tomorrow read it again. Also KDAB Qt Partner has also written few excellent posts about [QML engine internals](http://www.kdab.com/category/blogs/qmlengineseries).
  - Measure, don't assume, run [QML profiler](http://doc.qt.io/qtcreator/creator-qml-performance-monitor.html) and gather [console API traces](http://blog.qt.io/blog/2012/03/01/debugging-qt-quick-2-console-api) to see nothing stupid is happening behind the scenes, for example unnecessary QML component constructions or compilations, redundant binding evaluations, long nested JavaScript function calls or blocking C++ function calls. Basically any operation that stalls the main thread for tens to hundreds of milliseconds should be optimized or executed instead on a separate thread.

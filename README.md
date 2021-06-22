# Skidder

Skidder will drag your logs to where they need to go. A small, uniform and extensible logging library, implemented across major technologies. 

* iOS
* React
* React-Native
* Android

## Quick Start
In your `Package.swift`

```
package.dependencies.append(
    .package(url: "https://github.com/novemberfiveco/skidder-ios", from: "1.0.0")
)
```

## Usage
```
import Skidder

let consoleService = SkidderLogServiceConsole(id: "console_service")

Skidder.default.addService(consoleService)
Skidder.default.logLevel = isDev ? .trace : .error
Skidder.default.environment = "beta-test"

logInfo("Info log")
```

## Extensible
Write your own logging service by confirming to `SkidderLogService` and add it as a service to Skidder.

## Roadmap
Build Skidder log services for the major app Crash and Analytics libraries. Further enhancing the crash reporting of your app, by providing a breadcrumb trail through your logs.

- [ ] Crashlytics
- [ ] Sentry
- [ ] Firebase

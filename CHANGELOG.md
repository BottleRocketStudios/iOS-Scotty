## Scotty 1.0.0

- Add pattern matching for `Routable` and `RouteIdentifier` types
- Ensure code coverage generation in example project

## Scotty 0.2.0

- Add controllers and protocols to make it simple to handle app routing from many possible input sources. Here's how it works:

```swift
let controller = routeController = RouteController(rootViewController: rootVC)
controller.open(myRoute)
```

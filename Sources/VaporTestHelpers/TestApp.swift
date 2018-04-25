import Foundation
import Vapor

public struct TestApp {
    let application: Application
    let router: Router

    public var client: TestClient {
        return TestClient(app: self)
    }

    public init(routeRegister: (Router) throws -> Void) throws {
        var services = Services.default()

        let router = EngineRouter.default()

        try routeRegister(router)

        services.register(router, as: Router.self)

        self.router = router
        self.application = try Application(
            config: Config(),
            environment: Environment(name: "test", isRelease: false),
            services: services
        )
    }
}


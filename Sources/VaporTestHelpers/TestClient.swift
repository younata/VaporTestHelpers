import Foundation
@testable import Vapor

public struct TestClient {
    private let app: TestApp

    init(app: TestApp) {
        self.app = app
    }

    public func request(
        method: HTTPMethod,
        headers: [String: String] = [:],
        body: HTTPBody = .init(),
        // uri
        path: String = "/",
        query: String? = nil,
        fragment: String? = nil) throws -> Future<Response> {

        let request = self.makeRequest(method: method, headers: headers, body: body, path: path, query: query, fragment: fragment)

        return try self.app.router.route(request: request)!.respond(to: request)
    }

    public func get(
        headers: [String: String] = [:],
        body: HTTPBody = .init(),
        path: String = "/",
        query: String? = nil,
        fragment: String? = nil) throws -> Future<Response> {

        return try self.request(
            method: .GET,
            headers: headers,
            body: body,
            path: path,
            query: query,
            fragment: fragment
        )
    }

    public func post(
        headers: [String: String] = [:],
        body: HTTPBody = .init(),
        path: String = "/",
        query: String? = nil,
        fragment: String? = nil) throws -> Future<Response> {

        return try self.request(
            method: .POST,
            headers: headers,
            body: body,
            path: path,
            query: query,
            fragment: fragment
        )
    }

    public func put(
        headers: [String: String] = [:],
        body: HTTPBody = .init(),
        path: String = "/",
        query: String? = nil,
        fragment: String? = nil) throws -> Future<Response> {

        return try self.request(
            method: .PUT,
            headers: headers,
            body: body,
            path: path,
            query: query,
            fragment: fragment
        )
    }

    public func delete(
        headers: [String: String] = [:],
        body: HTTPBody = .init(),
        path: String = "/",
        query: String? = nil,
        fragment: String? = nil) throws -> Future<Response> {

        return try self.request(
            method: .DELETE,
            headers: headers,
            body: body,
            path: path,
            query: query,
            fragment: fragment
        )
    }

    public func makeRequest(
        method: HTTPMethod,
        headers: [String: String] = [:],
        body: HTTPBody = .init(),
        // uri
        path: String = "/",
        query: String? = nil,
        fragment: String? = nil) -> Vapor.Request {
        var urlString: String = path
        if let query = query {
            urlString += "?\(query)"
        }
        if let fragment = fragment {
            urlString += "#\(fragment)"
        }
        let url = URL(string: urlString)!

        let httpHeaders = HTTPHeaders(headers.map { return $0 })

        let request = HTTPRequest(
            method: method,
            url: url,
            version: .init(major: 1, minor: 1),
            headers: httpHeaders,
            body: body
        )

        return Vapor.Request(
            http: request,
            using: self.app.application
        )
    }
}


import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case post
    case get
}

public enum NetworkRequestError: Error {
    case invalidURL
}


public protocol NetworkRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var baseURL: URL? { get }
    var timeout: TimeInterval { get }
    var parameters: Codable? { get }
}

extension NetworkRequest {
    public var headers: HTTPHeaders? { return .none }
    public var timeout: TimeInterval { return 15 }
    public var baseURL: URL? {
        return URL(string: "http://api.apixu.com/v1/")
    }

    public func toRequest() throws -> URLRequest {
        guard var url = baseURL?.appendingPathComponent(path) else {
            throw NetworkRequestError.invalidURL
        }
        if path.contains("?"),
            let base = baseURL?.absoluteString,
            let urlWithoutScape = URL(string: base + path) {
                url = urlWithoutScape
        }
        var defaultHeaders = HTTPHeaders()
        defaultHeaders["Content-Type"] = "application/json"

        if let additionalHeaders = headers {
            for (key, value) in additionalHeaders {
                defaultHeaders[key] = value
            }
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = defaultHeaders
        urlRequest.httpMethod = method.rawValue.uppercased()
        if let body = parameters {
            urlRequest.httpBody = try body.toJSONData()
        }
        return urlRequest
    }
}

extension Encodable {
    public func toJSONData() throws -> Data {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(self)
        return data
    }
}

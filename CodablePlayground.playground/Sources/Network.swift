import Foundation

public typealias JSON = [String: Any]
final public class Network {
    public static func performRequest<Value: Codable>(_ request: NetworkRequest,
                                      completion: @escaping ((Result<Value>) -> Void)) {
        do {
            let request = try request.toRequest()
            DispatchQueue.global(qos: .userInitiated).async {
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        if let error = error {
                            completion(.failure(error))
                        }
                        return
                    }
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let value = try decoder.decode(Value.self, from: data)
                        completion(.success(value))
                    } catch let error {
                        completion(.failure(error))
                    }

                }
                task.resume()
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    public static func jsonRequest(_ request: NetworkRequest,
                                   completion: @escaping ((Result<JSON>) -> Void)) {
        do {
            let request = try request.toRequest()
            DispatchQueue.global(qos: .userInitiated).async {
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        if let error = error {
                            completion(.failure(error))
                        }
                        return
                    }
                    guard let data = data else { return }
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data,
                                                                          options: .allowFragments) as? JSON else { return }
                        completion(.success(json))
                    } catch let error {
                        completion(.failure(error))
                    }

                }
                task.resume()
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}

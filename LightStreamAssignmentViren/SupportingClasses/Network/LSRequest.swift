//
//  LSRequest.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/8/22.
//

import Foundation

typealias LSrequestCompletionBlock =  (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

enum HttpMethod: String {
    case Get = "GET", Put = "PUT", Post = "POST" , Delete = "DELETE"
}

enum RequestType {
    case Data, Download, Upload
}

class LSSession {
    var session: URLSession?
    static let shared = LSSession()
    
    private init() {
        if session == nil {
            session = LSSession.defaultSession()
        }
    }
    
    func invalidateAll() {
        session?.finishTasksAndInvalidate()
        session = nil
    }
    
    static func defaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpShouldSetCookies = false
        let session = URLSession(configuration: configuration)
        return session
    }
}

// User RequestConfig to pass necessary components for creating URLRequest
struct RequestConfig {
    let type: RequestType
    let method: HttpMethod
    let apiEndpoint: String
    let headers: [String : String]
    let params: [String : AnyObject?]?
    let httpBody: Data?
    
    // For GET pass params
    // For POST or PUT pass httpBody
    init(type: RequestType = .Data,
         method:HttpMethod = .Get,
         apiEndpoint:String,
         params: [String : AnyObject?]? = nil,
         httpBody: Data? = nil,
         headers: [String : String] = [:],
         background: Bool = false) {
        
        self.type = type
        self.method = method
        self.apiEndpoint = apiEndpoint
        self.httpBody = httpBody
        self.params = params
        self.headers = headers
    }
}

class LSRequest {
    
    let config : RequestConfig
    
    @discardableResult init(_ config: RequestConfig,
                            completion: @escaping LSrequestCompletionBlock) {
        self.config = config
        request(completion)
    }
    
    private func request(_ completion: @escaping LSrequestCompletionBlock) {
        switch config.type {
        case .Data:
            if let request = createRequest(self.config) {
                data(request) {
                    (data, response, error) in
                    DispatchQueue.main.async {
                        completion(data, response, error)
                    }
                }
                
            } else {
                print("LSRequest.request :: ERROR - Please check for valid parameters in LSRequest")
            }
            
        case .Download:
            // Create request for heavy downloading
            break
        case .Upload:
            // Create Request for uploading and handle up here.
            break
        }
        
    }
    
    private func createRequest(_ config: RequestConfig) -> URLRequest? {
        guard let url = URL(string: config.apiEndpoint) else {
            print("LSRequest.createRequest:: ERROR - Please check for valid parameters in LSRequest")
            return nil
        }
        
        switch config.method {
        case .Get:
            if let body = self.config.params{
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                
                var targetDict = [String: String]()
                for (key, value) in body {
                    if let value = value as? String { targetDict[key] = value }
                }
                
                let queryItems = targetDict.map {
                    return URLQueryItem(name: "\($0)", value: "\($1)")
                }
                
                urlComponents?.queryItems = queryItems
                let localVariable = urlComponents
                urlComponents?.percentEncodedQuery = localVariable?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                
                var request = URLRequest(url: (urlComponents?.url)!)
                
                request.httpMethod = config.method.rawValue
                self.config.headers.forEach({
                    request.setValue($0.value, forHTTPHeaderField: $0.key)
                })
                
                print("REQUEST: \(String(describing: request))")
                return request
                
            }
            //No params present
            var request = URLRequest(url: url)
            
            request.httpMethod = config.method.rawValue
            self.config.headers.forEach({
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            })
            return request
        default:
            // Other request Type. POST, PUT, Delete
            break
        }
        
        return nil
    }
    
    private func data(_ request: URLRequest, completion: @escaping LSrequestCompletionBlock) {
        if LSSession.shared.session == nil {
            LSSession.shared.session = LSSession.defaultSession()
        }
        
        let task = LSSession.shared.session?.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("LSRequest.data:: \nError: Unable to complete request on: \(self.config.apiEndpoint)")
                print(error.localizedDescription)
                completion(nil, response, error)
                
            } else {
                completion(data, response, error)
            }
            
        })
        task?.resume()
    }
}

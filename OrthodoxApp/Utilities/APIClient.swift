import Foundation


class APIClient {
    static let shared = APIClient()
    
    // Fetch calendar day data from the API with cache control
    func fetchCalendarDay(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://orthocal.info/api/gregorian/") else {
            print("❌ [API] Invalid URL constructed")
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        print("🚀 [API] Initiating fresh API call to \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Disable caching
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        // Add cache control headers
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.setValue("no-cache", forHTTPHeaderField: "Pragma")
        
        print("📋 [API] Request headers: \(request.allHTTPHeaderFields ?? [:])")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ [API] Network error: \(error.localizedDescription)")
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                print("📥 [API] Response received with status code: \(httpResponse.statusCode)")
                print("🔍 [API] Response headers: \(httpResponse.allHeaderFields)")
                
                if let data = data {
                    print("✅ [API] Data received: \(data.count) bytes")
                    completion(.success(data))
                } else {
                    print("⚠️ [API] No data received despite successful status code")
                    completion(.failure(NSError(domain: "No Data", code: 204, userInfo: nil)))
                }
            } else {
                print("❌ [API] Unknown error: No response received")
                completion(.failure(NSError(domain: "Unknown Error", code: 500, userInfo: nil)))
            }
        }
        task.resume()
    }
}

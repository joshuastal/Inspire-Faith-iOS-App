import Foundation


class APIClient {
    static let shared = APIClient()

    // Fetch calendar day data from the API
    func fetchCalendarDay(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://orthocal.info/api/gregorian/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Unknown Error", code: 500, userInfo: nil)))
            }
        }
        task.resume()
    }
}

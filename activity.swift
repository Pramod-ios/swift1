import Foundation

func checkWalletActivity(address: String, etherscanApiKey: String, completion: @escaping ([String: Any]?) -> Void) {
    let urlStr = "https://api.etherscan.io/api?module=account&action=txlist&address=\(address)&startblock=0&endblock=99999999&sort=desc&apikey=\(etherscanApiKey)"
    
    guard let url = URL(string: urlStr) else {
        print("Invalid URL")
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("Request error: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                completion(json)
            } else {
                completion(nil)
            }
        } catch {
            print("JSON parse error: \(error.localizedDescription)")
            completion(nil)
        }
    }

    task.resume()
}

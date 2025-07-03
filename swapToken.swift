import Foundation

func swapTokens(fromToken: String, toToken: String, amount: String, walletAddress: String, apiKey: String, completion: @escaping (String?) -> Void) {
    let urlStr = "https://api.1inch.dev/swap/v5.2/1/swap?fromTokenAddress=\(fromToken)&toTokenAddress=\(toToken)&amount=\(amount)&fromAddress=\(walletAddress)&slippage=1"
    
    var request = URLRequest(url: URL(string: urlStr)!)
    request.setValue(apiKey, forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            completion(nil)
            return
        }
        guard let data = data else {
            completion(nil)
            return
        }
        
        do {
            if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let tx = result["tx"] as? [String: Any],
               let txData = tx["data"] as? String {
                // tx contains "to", "data", "value" needed for sending transaction
                print("Swap TX Data: \(txData)")
                completion(txData)
            } else {
                print("Invalid swap response")
                completion(nil)
            }
        } catch {
            print("JSON parse error: \(error)")
            completion(nil)
        }
    }.resume()
}

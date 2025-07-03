func bridgeTokens(fromChain: Int, toChain: Int, fromToken: String, toToken: String, amount: String, walletAddress: String, apiKey: String, completion: @escaping (String?) -> Void) {
    let urlStr = "https://li.quest/v1/quote?fromChain=\(fromChain)&toChain=\(toChain)&fromToken=\(fromToken)&toToken=\(toToken)&fromAmount=\(amount)&fromAddress=\(walletAddress)&slippage=1"
    
    var request = URLRequest(url: URL(string: urlStr)!)
    request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Bridge error: \(error)")
            completion(nil)
            return
        }
        guard let data = data else {
            completion(nil)
            return
        }
        
        do {
            if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let tx = result["transactionRequest"] as? [String: Any],
               let txData = tx["data"] as? String {
                print("Bridge TX Data: \(txData)")
                completion(txData)
            } else {
                print("Bridge response malformed")
                completion(nil)
            }
        } catch {
            print("Bridge parse error: \(error)")
            completion(nil)
        }
    }.resume()
}

import web3swift
import BigInt

func sendEther(from keystore: BIP32Keystore, to recipient: String, amountInEth: String, password: String) {
    do {
        // Initialize web3 instance with Infura or local provider
        let web3 = Web3.InfuraMainnetWeb3()

        // Add keystore to web3
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)

        // Sender address
        guard let sender = keystore.addresses?.first else {
            print("Sender address not found")
            return
        }

        // Recipient address
        guard let recipientAddress = EthereumAddress(recipient) else {
            print("Invalid recipient address")
            return
        }

        // Convert ETH string to Wei
        let value = Web3.Utils.parseToBigUInt(amountInEth, units: .eth)

        // Build the transaction
        var transaction = EthereumTransaction(
            to: recipientAddress,
            value: value!,
            data: Data(),
            gasPrice: .automatic,
            gasLimit: .automatic
        )

        // Sign the transaction
        try Web3Signer.signTX(transaction: &transaction, keystore: keystore, account: sender, password: password, chainID: 1)

        // Send transaction
        let result = try web3.eth.sendRawTransaction(transaction)
        print("Transaction hash: \(result.hash)")
    } catch {
        print("Error sending transaction: \(error)")
    }
}

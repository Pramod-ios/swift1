import UIKit

class WalletHomeViewController: UIViewController {

    // MARK: - UI Components
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance: 0 ETH"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "0xYourWalletAddress"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private lazy var swapButton = createActionButton(title: "Swap", action: #selector(swapTapped))
    private lazy var bridgeButton = createActionButton(title: "Bridge", action: #selector(bridgeTapped))
    private lazy var sendButton = createActionButton(title: "Send", action: #selector(sendTapped))
    private lazy var activityButton = createActionButton(title: "Activity", action: #selector(activityTapped))

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Wallet"
        view.backgroundColor = .white
        setupLayout()
        fetchBalance()
    }

    // MARK: - Setup
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [swapButton, bridgeButton, sendButton, activityButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        [balanceLabel, addressLabel, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            addressLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            stack.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func createActionButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    // MARK: - Actions
    @objc private func swapTapped() {
        print("Swap Tapped")
        // Navigate to Swap screen
    }

    @objc private func bridgeTapped() {
        print("Bridge Tapped")
        // Navigate to Bridge screen
    }

    @objc private func sendTapped() {
        print("Send Tapped")
        // Navigate to Send screen
    }

    @objc private func activityTapped() {
        print("Activity Tapped")
        // Navigate to Activity screen
    }

    // MARK: - Blockchain Integration Placeholder
    private func fetchBalance() {
        // Replace this with web3.swift or Alchemy/Infura call
        let walletAddress = "0xYourWalletAddress"
        let balance = "0.253 ETH" // Fake balance
        DispatchQueue.main.async {
            self.addressLabel.text = walletAddress
            self.balanceLabel.text = "Balance: \(balance)"
        }
    }
}

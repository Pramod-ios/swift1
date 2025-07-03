fileprivate func createWallet() {

        var web3KeyStore: BIP32Keystore?

        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        let web3KeystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")

        do {

            if (web3KeystoreManager?.addresses.count ?? 0 >= 0) {

                let web3Mnemonics = Mnemonics(entropySize: EntropySize.b128, language: .english)

                print(web3Mnemonics.description)

                web3KeyStore = try BIP32Keystore(mnemonics: web3Mnemonics)

                print("keystore", web3KeyStore as Any)

                guard let kStore = web3KeyStore else {

                    return
                }

                let address = kStore.addresses.first

                let param = kStore.keystoreParams

                #if DEBUG

                print("Mnemonics :-> ", web3Mnemonics.description)

                print("Address :::>>>>> ", address as Any)

                print("Address :::>>>>> ", kStore.addresses as Any)

                #endif

                let keyData = try? JSONEncoder().encode(param)

                self.moveToAccountSucessViewController()

            } else {

                web3KeyStore = web3KeystoreManager?.walletForAddress((web3KeystoreManager?.addresses[0])!) as? BIP32Keystore

            }

        } catch {

            print(error, "\(#line)")

        }

    }

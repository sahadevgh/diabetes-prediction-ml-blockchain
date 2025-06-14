from web3 import Web3
import json
import os

# Connect to Arbitrum Sepolia testnet (Section 4.1)
w3 = Web3(Web3.HTTPProvider('https://sepolia-rollup.arbitrum.io/rpc'))  # Public RPC
if not w3.is_connected():
    raise Exception("Failed to connect to Arbitrum Sepolia")

# Load smart contract ABI and address (deployed separately)
with open('MLTraceability.json') as f:
    contract_abi = json.load(f)['abi']
contract_address = 'xxxxx'  # Replace with your deployed contract address to test
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# Account setup (replace with your private key, securely managed)
private_key = os.getenv('PRIVATE_KEY')  # Store in .env file
account = w3.eth.account.from_key(private_key)
w3.eth.default_account = account.address

# Log a hash and metadata (Section 4.4)
def log_hash(data_hash, metadata):
    tx = contract.functions.submitHash(data_hash, json.dumps(metadata)).build_transaction({
        'chainId': 421614,  # Arbitrum Sepolia
        'gas': 100000,
        'gasPrice': w3.to_wei('0.1', 'gwei'),
        'nonce': w3.eth.get_transaction_count(account.address),
    })
    signed_tx = w3.eth.account.sign_transaction(tx, private_key)
    tx_hash = w3.eth.send_raw_transaction(signed_tx.raw_transaction)
    receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    return receipt

# Verify a hash (Section 4.4)
def verify_hash(data_hash):
    return contract.functions.verifyHash(data_hash).call()

# Example usage
if __name__ == "__main__":
    # Example metadata
    metadata = {"model_version": "1.0", "timestamp": "2025-06-14", "data_type": "model"}
    # Example hash from ml_pipeline.py
    data_hash = "example_sha256_hash_here"  # Replace with actual hash
    receipt = log_hash(data_hash, metadata)
    print("Transaction Receipt:", receipt)
    exists = verify_hash(data_hash)
    print("Hash Exists:", exists)
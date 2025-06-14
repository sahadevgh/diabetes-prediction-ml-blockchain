from cryptography.fernet import Fernet
import ipfshttpclient
import json
import os

# Generate or load encryption key (Section 3.7)
key_file = 'encryption_key.key'
if not os.path.exists(key_file):
    key = Fernet.generate_key()
    with open(key_file, 'wb') as f:
        f.write(key)
with open(key_file, 'rb') as f:
    key = f.read()
cipher = Fernet(key)

# Connect to local IPFS node (Section 4.1)
client = ipfshttpclient.connect('/ip4/127.0.0.1/tcp/5001')

# Encrypt and upload data to IPFS (Section 3.5)
def upload_to_ipfs(file_path):
    # Read and encrypt file
    with open(file_path, 'rb') as f:
        data = f.read()
    encrypted_data = cipher.encrypt(data)
    
    # Save encrypted data temporarily
    temp_file = 'encrypted_data.bin'
    with open(temp_file, 'wb') as f:
        f.write(encrypted_data)
    
    # Upload to IPFS
    result = client.add(temp_file)
    cid = result['Hash']
    
    # Clean up
    os.remove(temp_file)
    return cid

# Example usage
if __name__ == "__main__":
    # Example: Upload a model file
    cid = upload_to_ipfs('logistic_regression.pkl')
    print("IPFS CID:", cid)
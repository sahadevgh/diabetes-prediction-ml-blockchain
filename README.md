# 🧠 Diabetes Prediction with Machine Learning and Blockchain Traceability

This project demonstrates a practical implementation of supervised machine learning models for diabetes prediction using the Pima Indians Diabetes Dataset, with an added layer of trust through blockchain-based traceability. It combines Python-based ML modeling with a Solidity smart contract to log and verify the integrity of the data pipeline.

---

## 📌 Features

* Supervised ML models: Logistic Regression and Decision Tree Classifier
* Data preprocessing, visualization, and performance evaluation
* Blockchain logging of:

  * Dataset integrity (via SHA-256 hashes)
  * Model configurations
  * Prediction audit trails
* Smart contract written in Solidity
* Visualizations: Confusion matrix and Decision Tree structure

---

## 🗂️ Project Structure

```
diabetes-prediction-ml-blockchain/
├── blockchain/
│   └── MLTraceability.sol   # Smart contract for traceability
├── notebook/
│   └── diabetes_prediction.ipynb  # Jupyter Notebook with code and output
├── README.md              # Project documentation
```

---

## 📊 Dataset

* **Source**: [Pima Indians Diabetes Dataset](https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database)
* **Instances**: 768
* **Features**: 8 clinical features + 1 binary label (`Outcome`)

---

## ⚙️ Setup

### Clone this repository

```bash
git clone https://github.com/your-username/diabetes-prediction-ml-blockchain.git
cd diabetes-prediction-ml-blockchain
```

### Create and activate virtual environment

```bash
python3 -m venv venv
source venv/bin/activate
```

### Install Python dependencies

```bash
pip install -r requirements.txt
```

---

## 🚀 Run the Notebook

Launch Jupyter Notebook and open the project:

```bash
jupyter notebook notebook/diabetes_prediction.ipynb
```

---

## 🔐 Blockchain Logging (Solidity)

The `MLTraceability.sol` contract logs hashes of datasets, models, and predictions. This supports auditability without exposing sensitive patient data.

Key functions:

```solidity
function logHash(string memory _hash, string memory _label) public;
function getLog(uint index) public view returns (string memory, string memory, uint);
```

To test or deploy, use [Remix IDE](https://remix.ethereum.org) or integrate into a Truffle/Hardhat workflow.

---

## 🧪 Evaluation Metrics

* Accuracy
* Precision
* Recall
* F1 Score
* Confusion Matrix
* Decision Tree Visualization

---

## 👨‍⚕️ Authors

1. Yakubu Abdul-Karim 
2. ⁠Musah-Ishak Abdul-Haqq 
3. ⁠Ubaydah Nii Osang Aryeetey
4. ⁠Kwabena Boateng 

This project was built as part of an academic research paper to explore traceable AI systems in healthcare. Inspired by the need for trustworthy ML applications in clinical settings, particularly in under-resourced environments.
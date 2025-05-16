# Supply Chain Verification System

## Project Description

The Supply Chain Verification System is a blockchain-based solution that leverages Ethereum smart contracts to create a transparent, immutable, and verifiable record of a product's journey through the supply chain. The system utilizes cryptographic signatures from authorized participants to verify and record each checkpoint a product passes through, from manufacturing to retail delivery.

This decentralized approach eliminates the need for centralized record-keeping, reduces fraud, and provides end-to-end visibility into product journeys. By implementing role-based access control, the system ensures that only authorized parties can verify specific checkpoints, maintaining the integrity of the supply chain data.

## Project Vision

Our vision is to create a trustless ecosystem where all supply chain participants can confidently verify the authenticity and journey of products. By digitizing and securing the verification process on a blockchain, we aim to:

1. **Increase Transparency**: Provide complete visibility of product movements to all stakeholders
2. **Enhance Accountability**: Clearly define responsibilities at each checkpoint
3. **Prevent Fraud**: Make it nearly impossible to falsify records or origin information
4. **Simplify Compliance**: Automatically generate immutable audit trails for regulatory purposes
5. **Build Consumer Trust**: Allow end consumers to verify the authenticity and journey of products they purchase

## Key Features

- **Role-Based Authorization**: Different participants (manufacturers, distributors, retailers) have specific permissions
- **Checkpoint Verification**: Cryptographic verification of product status at each stage
- **Status Progression Control**: Ensures logical progression of product status through the supply chain
- **Immutable Record Keeping**: All verifications are permanently recorded on the blockchain
- **Event Logging**: Comprehensive event emission for off-chain tracking and notifications
- **Product Traceability**: Complete history of each product's journey is accessible and verifiable

## Smart Contract Functions

### Core Functions

1. **createProduct**: Allows manufacturers to register a new product in the system
2. **verifyCheckpoint**: Records verification of a product at a specific checkpoint with status updates
3. **getProductInfo**: Retrieves comprehensive information about a product and its current status

### Supporting Functions

1. **grantRole**: Assigns supply chain roles (manufacturer, distributor, retailer) to addresses
2. **Modifiers**: Ensures functions can only be called by authorized addresses

## Future Scope

The Supply Chain Verification System has significant potential for expansion:

1. **Integration with IoT Devices**: Automatic checkpoint verification through sensors and IoT devices
2. **Dispute Resolution System**: Add mechanisms for resolving discrepancies in verification
3. **Token-Based Incentives**: Reward participants for timely and accurate verifications
4. **Machine Learning Analytics**: Analyze supply chain data to predict bottlenecks and optimize routes
5. **Consumer Interface**: Mobile app allowing consumers to scan products and view their complete supply chain journey
6. **Conditional Payments**: Implement escrow mechanisms that release payments when checkpoints are verified
7. **Cross-Chain Integration**: Connect with other blockchain networks to create a unified supply chain ecosystem
8. **Carbon Footprint Tracking**: Add environmental impact monitoring at each checkpoint

## Getting Started

### Prerequisites

- Node.js v16+ and npm
- A wallet with testnet CORE tokens for deployment

### Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd supply-chain-verification-system
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Create a `.env` file in the root directory with your private key:
   ```
   PRIVATE_KEY=your_private_key_here_without_0x_prefix
   ```

### Deployment

To deploy to Core Testnet 2:

```
npm run deploy
```

For local development:

```
npm run node
```

In a separate terminal:

```
npm run deploy:local
```

## Testing

Run the test suite:

```
npm test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.


Contract Address:0x97a10574530449c8010A3D363f116011a8b8E7e2


![image](https://github.com/user-attachments/assets/f517eb4d-1a9c-406e-97d0-3f97b4e15a12)

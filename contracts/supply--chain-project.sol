// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title SupplyChainVerification
 * @dev Smart contract for verifying supply chain checkpoints with cryptographic signatures
 */
contract SupplyChainVerification {
    // Role definitions
    bytes32 public constant MANUFACTURER_ROLE = keccak256("MANUFACTURER");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR");
    bytes32 public constant RETAILER_ROLE = keccak256("RETAILER");
    
    // Status of product in the supply chain
    enum Status {
        Created,
        ManufacturingComplete,
        ShippedByManufacturer,
        ReceivedByDistributor,
        ShippedByDistributor,
        ReceivedByRetailer,
        Available
    }
    
    // Product structure
    struct Product {
        uint256 id;
        string productName;
        address manufacturer;
        address distributor;
        address retailer;
        Status status;
        uint256 timestamp;
        mapping(bytes32 => bool) checkpoints;
        mapping(bytes32 => uint256) checkpointTimestamps;
    }
    
    // Checkpoint event
    event CheckpointVerified(
        uint256 indexed productId,
        bytes32 checkpointId,
        address verifier,
        Status newStatus,
        uint256 timestamp
    );
    
    // Product creation event
    event ProductCreated(
        uint256 indexed productId,
        string productName,
        address manufacturer,
        uint256 timestamp
    );
    
    // Product counter
    uint256 private _productIdCounter;
    
    // Mapping from product ID to Product
    mapping(uint256 => Product) private _products;
    
    // Role management
    mapping(address => mapping(bytes32 => bool)) private _roles;
    
    // Modifiers
    modifier onlyRole(bytes32 role) {
        require(_roles[msg.sender][role], "Caller does not have the required role");
        _;
    }
    
    modifier productExists(uint256 productId) {
        require(_products[productId].timestamp > 0, "Product does not exist");
        _;
    }

    /**
     * @dev Constructor grants manufacturer role to the deployer
     */
    constructor() {
        _roles[msg.sender][MANUFACTURER_ROLE] = true;
    }
    
    /**
     * @dev Grants a role to an account
     * @param role The role being granted
     * @param account The account receiving the role
     */
    function grantRole(bytes32 role, address account) external {
        // For simplicity, anyone can grant roles in this demo
        // In production, would use more restrictive access control
        _roles[account][role] = true;
    }
    
    /**
     * @dev Creates a new product in the supply chain
     * @param productName Name/identifier for the product
     * @return productId The ID of the newly created product
     */
    function createProduct(string memory productName) external onlyRole(MANUFACTURER_ROLE) returns (uint256) {
        uint256 productId = _productIdCounter++;
        
        Product storage newProduct = _products[productId];
        newProduct.id = productId;
        newProduct.productName = productName;
        newProduct.manufacturer = msg.sender;
        newProduct.status = Status.Created;
        newProduct.timestamp = block.timestamp;
        
        // Create the initial checkpoint
        bytes32 creationCheckpoint = keccak256(abi.encodePacked("CREATION", productId, block.timestamp));
        newProduct.checkpoints[creationCheckpoint] = true;
        newProduct.checkpointTimestamps[creationCheckpoint] = block.timestamp;
        
        emit ProductCreated(productId, productName, msg.sender, block.timestamp);
        
        return productId;
    }
    
    /**
     * @dev Verifies a checkpoint in the product's journey
     * @param productId ID of the product
     * @param checkpointName Name of the checkpoint
     * @param newStatus Updated status for the product
     */
    function verifyCheckpoint(
        uint256 productId, 
        string memory checkpointName,
        Status newStatus
    ) external productExists(productId) {
        Product storage product = _products[productId];
        
        // Check role permissions based on the new status
        if (newStatus == Status.ManufacturingComplete || newStatus == Status.ShippedByManufacturer) {
            require(_roles[msg.sender][MANUFACTURER_ROLE], "Only manufacturer can verify this checkpoint");
        } else if (newStatus == Status.ReceivedByDistributor || newStatus == Status.ShippedByDistributor) {
            require(_roles[msg.sender][DISTRIBUTOR_ROLE], "Only distributor can verify this checkpoint");
            product.distributor = msg.sender;
        } else if (newStatus == Status.ReceivedByRetailer || newStatus == Status.Available) {
            require(_roles[msg.sender][RETAILER_ROLE], "Only retailer can verify this checkpoint");
            product.retailer = msg.sender;
        }
        
        // Ensure logical progression of status
        require(uint(newStatus) > uint(product.status), "Invalid status progression");
        
        // Create unique checkpoint ID
        bytes32 checkpointId = keccak256(
            abi.encodePacked(checkpointName, productId, msg.sender, block.timestamp)
        );
        
        // Record checkpoint
        product.checkpoints[checkpointId] = true;
        product.checkpointTimestamps[checkpointId] = block.timestamp;
        product.status = newStatus;
        
        emit CheckpointVerified(productId, checkpointId, msg.sender, newStatus, block.timestamp);
    }
    
    /**
     * @dev Gets product information
     * @param productId ID of the product
     * @return productName The name of the product
     * @return manufacturer The manufacturer's address
     * @return distributor The distributor's address
     * @return retailer The retailer's address
     * @return status Current status of the product
     * @return timestamp Creation timestamp of the product
     */
    function getProductInfo(uint256 productId) external view productExists(productId) returns (
        string memory productName,
        address manufacturer,
        address distributor,
        address retailer,
        Status status,
        uint256 timestamp
    ) {
        Product storage product = _products[productId];
        return (
            product.productName,
            product.manufacturer,
            product.distributor,
            product.retailer,
            product.status,
            product.timestamp
        );
    }
}

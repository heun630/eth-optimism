pragma solidity ^0.7.6;

// 라이브러리 및 인터페이스 불러오기
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@eth-optimism/contracts/contracts/optimistic-ethereum/libraries/bridge/OVM_CrossDomainEnabled.sol";

contract OptimismERC20 is ERC20, Ownable, OVM_CrossDomainEnabled {
    address public minter;

    // 컨트랙트 생성자
    constructor(
        string memory _name,
        string memory _symbol,
        address _l2Messenger
    ) ERC20(_name, _symbol) OVM_CrossDomainEnabled(_l2Messenger) {}

    // 민터 설정
    function setMinter(address _minter) external onlyOwner {
        minter = _minter;
    }

    // L1 에서 전송 요청 처리
    function receiveTokens(
        address _recipient,
        uint256 _amount,
        bytes calldata _data
    ) external onlyFromCrossDomainAccount(l2Messenger) {
        _mint(_recipient, _amount);
        emit ReceivedTokens(_recipient, _amount, _data);
    }

    // 이벤트 선언
    event ReceivedTokens(
        address indexed recipient,
        uint256 amount,
        bytes data
    );
}

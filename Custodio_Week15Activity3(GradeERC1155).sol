// SPDX-License-Identifier: HAU

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GradesNFT is ERC1155, Ownable {
    uint256 public constant EXCELLENT = 1;
    uint256 public constant VERY_GOOD = 2;
    uint256 public constant GOOD = 3;
    uint256 public constant FAIR = 4;
    uint256 public constant POOR = 5;

    mapping(uint256 => string) public gradeNames;

    constructor() ERC1155("https://custodiopunzalan.io/api/grades/{id}.json") Ownable(msg.sender) {
        gradeNames[EXCELLENT] = "Excellent";
        gradeNames[VERY_GOOD] = "Very Good";
        gradeNames[GOOD] = "Good";
        gradeNames[FAIR] = "Fair";
        gradeNames[POOR] = "Poor";
    }

    function mintGrade(address student, uint256 score) external onlyOwner {
        uint256 gradeID = getGradeID(score);
        require(gradeID > 0, "Invalid score");
        _mint(student, gradeID, 1, "");
    }

    function getGradeID(uint256 score) public pure returns (uint256) {
        if (score >= 90) return EXCELLENT;
        if (score >= 81) return VERY_GOOD;
        if (score >= 75) return GOOD;
        if (score >= 71) return FAIR;
        return POOR;
    }

    function getGradeName(uint256 gradeID) external view returns (string memory) {
        return gradeNames[gradeID];
    }
}

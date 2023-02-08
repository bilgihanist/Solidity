// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.1/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.8.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.8.1/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.8.1/utils/Counters.sol";

contract Bilgihan is ERC721, ERC721Enumerable, ERC721URIStorage  {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 10000;
    constructor() ERC721("Bilgihan", "BLGN") {}


//safemint özelliği
//cüzdan veya sözleşme ise , 
//onlyOwner = tek sahip işlevi demek
    function safeMint(address to, string memory uri) public  {
        uint256 tokenId = _tokenIdCounter.current();  //geçerli token idsini gerçekten depolayan tokenid adlı bşr uint256 değişkeni bildiriyor. _tokenIdCounter.current() parantez olacak o anki token id sayısını aldı 
        require(tokenId <= MAX_SUPPLY, "Uzgunum Tum NFT'ler Mint Edildi.");
        _tokenIdCounter.increment(); //sona tokenidcounter bu sayıyı artırıyoruz sonraki nft'nin oluşturacağından emin olarak , artırımlı bir sayıya sahip olunur
        _safeMint(to, tokenId);  //nft burada basılır ve bu adrexe göçnderelir sonra sayaç işini yapar ve sayıyı bir  arttırır. ve bu bize gas ücretine mal olacak
        _setTokenURI(tokenId, uri);  //smart controlleri'imize bir token uri yeniden atayacağız 
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal                    // internal 'ın private'den tek farkı sözleşmemizden devrelan kişi private function veya variables yalnızca smart kontaract içinden erişebilir veya okunabilir olduğunu ve smart kontract 
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view                        //view blok zincirine bir şey yazmaz oyüzden gas ödemezsiniz.
        override(ERC721, ERC721URIStorage)
        returns (string memory)  
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
     
}

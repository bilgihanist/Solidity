// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;





/*
modifier kullanım amacı eğer bir fonksiyona çalışmasından önce veya çalışmasından sonra daha önce belirlediğimiz özellikleri katmak 
kontrolleri yapmak belki kitleri katmak belki kitlere korumalr koymak bu tarz isteklerde modifier kullanılır.

bir komutu birden fazla fonksiyonda fonksiyondan önce veya sona kullanıyorsak modifier ile yazdığımızda bu komutu standartlaştırmış oluyoruz 
hem daha okunaklı hale getiriyor hemde standartlaştırmalar sayesinde kontratı okuyanlar daha güvenle bakabilecek.

hatta bu amaçla hazırlanmış kütüphaneler varsa onlyble kütüphanesi'den bahsedilmiş ilk videoda 

modifier'ler genelde kodun sonuna yazılırlar. styleguide olark belirtilmişir

keyword'ümüz == modifier

*/

modifier checkProducts {}
// eger bu modifierimiz bir parametre alacaksa parantezli kullaniyoruz

modifier checkProducts(uint256[] memory _products) {    // array ile kullanılacaksa uint256[] yapılır uint256 sadece int olur.
    require(_products.length > 0, "No products.");
    _;  // fonksiyonlarımızın value'sini gösterir
}

//bu modifier'ler uygulamak istediğimiz fonskiyonun parametrelerinden sonra parantezin dışına (pure view'in) başına yazılır.

//modifierin parametresinide parantez içinde yazılır.

function createOrder(string memory _zipCode, uint256[] memory _products) checkProducts(_products)
/* nasıl bir fonksiyon çalıştığında parametreleri elle giriyorsak modifierde Elle girme durumu yok parametresini fonksiyonun 
parametresini kullanır.*/

// Ö: müşteriler bu smart kontrat ile kaç defa etkileşime geçmiş örneği
modifier incTx {
    _;      // fonksiyonlarımızın value'sini gösterir
    txCount++;
}

//modifier'leri arka arkaya yan yana yazılabilir bir syntax yoktur.

modifier onlyOwner {
    require(owner == msg.sender, "You are not authorized");
    _;      // fonksiyonlarımızın value'sini gösterir
}

//bir siparişin sepeti değişecekse onu sadece siparişin sahibinin yapması isteniyorsa modifierle yapılacak
// order değişkeni bulunmadığından veriye başka türlü ulaşmak gerekiyor _orderId parametresi alındı sonra kısa yoldan 
//location ile erişerek ve bunu array içinden alacak
modifier onlyCustomer(uint256 _orderId){
    require(orders[_ordersId].customer == msg.sender,"You are not the owner of the order.");
    _;
}

//modifier'ler içinde kullandığımız gereksiz duruma düşmüş komutları kaldırmış olduk 
//Bir fonksiyondan önce ve ya sonra uygulamak istediğimiz değişilikler , çıkarmak istediğimiz fonksiyonlar , getiremk istediğimiz kısıtlamalar varsa modifier'ler kullanılır.

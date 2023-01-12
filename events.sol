// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


/*kontract içerisinde baktığımızda hiç bir işe yaramayan parçalarıdır. ancak bir dapp geliştirdiğimizde 
eventlere çok büyük bir ihtiyaç duyuyoruz çünkü smart kontract'ta oluşacak bazı sonuçları , bazı fonksiyonların tamamlandığını
veya dışarı çıkarmak istediğmiz bilgileri eventler aracılığıyla takip edebiliyoruz.

fonksiyonların üzerinde tercih edilir.

nası bir event yaratılacağına bakalım createOrder sipariş oluşturduğunda sipariş id değer olarak dönüyoruz. siparişin idsini retrun olarak 
dönemktense dışarya event olarak çıkartmak istersek 

event Keyword + Event'in adı + Eventimizin alacağı parametreleri yazarız.
event OrderCreated(uint256 _orderId, address indexed _consumer);      //parametreler siparişin Id'si ve sipariş veren kullanıcının adresi 
//indexed nedir ?= yayınlanan bir event'de bir değişkeni index olarad belirlersek sonrasında blockcahainden bu indexeds değerlerini sorgulayabiliyoruz.
Blockchaine diyoruz ki bu kullanıcın geçmişe dönük tüm transactionları getir, bu transaction bir event yayınlıyor bizde bu değeri indexed keywordu 
ile işaretlersek aslında bu değişkene yönmelik sorgular yapabiliyoruz.

eventleri kullanırken emit diye farklı bir keywordumuz var.
function içine yazılacak emit 
    emit OrderCreated(orders.length -1 , msg.sender);   //arrayin son elemanı -1 , göndren kişinin adresi

Genelde baş harfleri büyük olur emitlerin 
    event ZipChanged(uint256 _orderId, string _zipCode)
    emit  ZipChanged(_orderId, _zipCode)            //sipariş adresi değiştinde dışarıdan takip edeilceğiz , 
    
kontractın sonlanıp sonlamadığını takip etmede kullanılıyor.marketplace'lerde satışa çıkar satıştan çıkar gibi eventler takip edilerek
takip edilebiliyor.



*/
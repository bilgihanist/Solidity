// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*adreslerin gönderdiği etherlerin değerini tutumak */

contract Bank {
//  keyword(kulannıcı adresi => değer tipi ) mapping adı ;
    mapping(address => uint ) balances; 

    //etherlerimizi burada kontrol edeceğiz.

    //kontrata ether göndermek için function yazıyoruz.
    //kontract içinde çağırmayacağımız için external yazıyoruz.
    //parametrre yok çünkü değer dönmeyecek
    
    function sendEtherTocontract()payable  external{
        //tanımladığımız mappingde sahip oludğumuz değeri artırmak istiyoruz.
        //bu fonksiyonu çağıran kişinin değerini arttırmak istiyoruz.
        balances[msg.sender] = msg.value;  
        /* gonderdiği miktar kadar arttiriyoruz. 
           payable = para gönderimi yapılacaksa yazılmak zorundadaır.
        */
    }     

   //external= sadece okuma 
   function showBalance() external view returns(uint) {
       //sahip olduğumuz değerede mappingden ulaşabiliyoruz.
       return balances[msg.sender];
   }

   //Para çekmek için yapılacaklar / dışarıdan çağırılacak = external / değer döndürülmeyecek.
   function withdraw() external {
       //kontractan kendi cüzdan adresime bir transfer gerçekleştirmek gerekiyor.
       // HATALI KULLANIM 
       //msg.sender.transfer(balances[msg.sender]); 
       //payable etiketi olmadığı için para gönderilemez. ama biz balance'mizdeki kadar paranın gönderilmesini istersek.hata alırız

        payable(msg.sender).transfer(balances[msg.sender]);
   //----Buraya kadar olan kısımda para gönder ve al çalışıyor fakat show balance güncellenmiyor 
        balances[msg.sender] = 0;

   } 
      function withdraw1(address payable to, uint amount) external { 
          //parametre ile göndermke istedigimiz kisi ve miktarı
        //require ile önlem alınır.
        //msg.sender'in göndermek istediği para kendi bakiyesinden büyük mü küçük mü kontrol et.
        //göndericinin bakiyesi göndermek istediği miktara eşit yada büyük olmak zorunddır.
        require(balances[msg.sender] >= amount, "yetersiz bakiye");
        to.transfer(amount);
        balances[msg.sender] -= 0; //gönderdiğimiz miktar kadar balance'yi azalt


/*sadece transfer function'nun yanında tanımlamak zorundna değiliz, adresi parametre içinde de payable yapabiliyoruz 
fonksiyonlar için üst tarafta nitelendirilmesi gerekirken , kişisel adresler için parametre, input ve transferiçinde yazılabilir.*/
   }

   /*
        3 Farklı ether gönderme yöntemi vardır.
        1.) Transfer()
            kontractta olmayan bir mikarı göndermek istersek, cüzdanda yeterli miktarda para yoksa 
   */ 
    
}
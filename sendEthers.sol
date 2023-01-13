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

    function withdraw2() external {
        payable(msg.sender).transfer(balances[msg.sender]);
    }

    function withdraw3(address payable to, uint amount) external {
        require(balances[msg.sender] >= amount , "yeterli bakiye yoktur");
        to.transfer(amount);
        balances[msg.sender] -= amount;
    }




   /*
        ---3 Farklı ether gönderme yöntemi vardır.---

        1.) Transfer() Revert
            kontractta olmayan bir mikarı göndermek istersek, cüzdanda yeterli miktarda para yoksa yeterli miktarı göndermiyorsak 
            bu geri dönüş(revert) yapar transfer keywordunun özelliği "Revert" yapamasıdır
   */ 
    

    function withdraw4(address payable to, uint amount) external {
        // require(balances[msg.sender]) >= amount, "yeterli bakiye yoktur";
        to.transfer(amount);
        balances[msg.sender] -= amount;
    }


    /* Send()
    fonksiyon gerçekleştiyse true gerçekleşmezse false 
    fonksiyonumzda bir işlemin gerçekleşip gerçekleşmediğini kontrol edeceksek send() özelliğini kullanırız.
    
    */


    function withdraw5(address payable to, uint amount ) external returns(bool) {
        bool ok = to.send(amount);
        balances[msg.sender] -= amount;
        return ok;
    }


    /* Call()
    true ve false ile birlikte bize data gönderen bir fonksiyondur.
    call 
    
    */

    function withdrawCall(address payable to, uint amount) external returns(bool) {
        //call bize 2 tane değer döndürüyor
        //1.si bool özelliği 2.si ise data özelliği 
    //(bool keyword, data keyword) = göndermek istediğimiz adres{göndermek istediğimiz miktar, gas ücreti belirtebiliyoruz}(data mesajı)
        (bool sent,/* bytes memory data*/ ) = to.call{value: amount /*,gas:452221*/ } ("data burada"); 
        balances[msg.sender] -= amount;
        return sent; 
    }
 

// herhangi bir functionu çağırmadan kontracta ether göndermek için "Low Level İnteractions" CallData ile gönderilir.
// bir kontracta ether göndemek istiyorsan "receive" ve "fallback" kullanmalısın 
// hata almamak için  

    uint public receiveCount = 0;
    uint public fallbackCount = 0;
    receive() external payable {
        receiveCount +=1;
    }

    //fallback 
    //eğer bir datamız varsa fallback çalışacaktır. veri gönderdiğimiz data gönderdiğimiz durumlarda işe yarar.

    //fallback fonksiyonumuz yooken bir data göndermeye çalışırsak fullback function olmadığını göstren bir uyarı alırız.


    //fallback ile gönmderilen verilerin gönderilecek veriler string değin "HEXADECIMAL" olarak gönderilmek zorundadır.
    //kontrata direk ether göndermek istersek fallback ve receive fonksiyonlarının çalışması gerkiyor..
    //data göndermiyorsak receive data gömnderiyorsak fallback fonksiyonu kullanılır.
    //fallback hem veri içeren durumda hemde veri olamayan durumda çalışırken receive sadece veri olmayn durumda çalışır.

    fallback() external payable {
        fallbackCount +=1;
    }

}


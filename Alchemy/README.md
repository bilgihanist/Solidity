alchemy hesabı aç
yeni proje oluştur goerli test ağında ethereum 
Metamaskta ile Alchmey için ağ oluştur ağ adı ve RPC URL metamask ağ kısmına yapıştır goerli 5 
 view api key ile HTTPS keyi alınır
filebase buckets'e create bucket oluşturulur IPFS olacak ve format düzeninde olacak
metadata.json ve resim.png dosyaları yüklenir
Remix safemint için metadata.json dosayasındaki IPFS CID kodunu kopyala 

 `
{
  "description": "BURAYA AÇIKLAMA GİR", 
  "external_url": "BURAYA LINK GIRRILIR", 
  "image": "BURAYA PNG DOSYANIN IPFS GATEWAY URL LINKI KOPYALANIR", 
  "name": "KOLEKSIYON ADINI GIR",
  "attributes": [
    {
      "trait_type": "Background", 
      "value": "pink line"
    }, 
    {
      "trait_type": "Eyes", 
      "value": "Yellow Glasses"
    }, 
    {
      "trait_type": "Hat", 
      "value": "Inspector"
    }
  ]
}
`

Remixde kodlarımızı deploy ettikten sonra
safemint ile 
to = nft gönderilecek hesap türü
uri = ipfs://IPFS CID Kodunu yapıştır

BalanceOf 
  owner = kısmına yazılan hesap noda kaç adet nft olduğunu gösterir

TokenURI 
   ilk nft için 0' yazmak yeterli bize metadata IPFS CID kodu gösterilir.
